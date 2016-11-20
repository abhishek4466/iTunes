//
//  SearchViewController.m
//  iTunes Search
//
//  Created by Abhishek Tyagi on 11/17/16.
//  Copyright © 2016 Department of Education. All rights reserved.
//

#import "SearchViewController.h"
#import "MBProgressHUD.h"
#import "FTPopOverMenu.h"
#import "Constants.h"
#import "FCAlertView.h"

#define CellIdentifier @"resultCell"

@interface SearchViewController () <UISearchBarDelegate> {
    
    NSArray                     *listOfEntity;
    iTunesInstance              *instance;
}

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Below line is helping us to fetch the list of entities saved in the plist.
    listOfEntity = [[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Entity" ofType:@"plist"]] objectForKey:@"iTunesEntity"];

    //creating the instance of the intunes search to hold the values during the session of the app.
    instance = [iTunesInstance getInstanceOfiTunesSearch];
    
    //assigning the default value of entity i.e. ALL .
    instance.selectedEntity = [listOfEntity objectAtIndex:0];

    //seeting a right item of navigation bar...by clicking right item user can select different entity for the search
    [self setNavigationItemTitleWithEntityInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation bar items-----------------

- (void)setNavigationItemTitleWithEntityInfo {
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:[instance.selectedEntity objectForKey:@"name"] style:UIBarButtonItemStylePlain target:self action:@selector(entityButtonClicked:event:)]];
}

#pragma mark - API Request-----------------

- (void)getListOfResultsForCategory {
    
    if (![Utilities checkInternetConnection]) {
        [Utilities showAlertWithTitle:@"No Internet Connection" withMessage:@"Kindly check your internet connection." forView:self success:NO];
        return;
    }
    
    NSString *urlString = @"";
    [instance setListOfResults:[[NSMutableArray alloc] init]];
    
    if ([[instance.selectedEntity objectForKey:@"key"] isEqualToString:@"all"]) {
        urlString = [NSString stringWithFormat:@"%@%@",API_BASE_URL,keywordSearchBar.text];
        
    }
    else {
        urlString = [NSString stringWithFormat:@"%@%@&entity=%@",API_BASE_URL,keywordSearchBar.text,[instance.selectedEntity objectForKey:@"key"]];
    }
    
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    //
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.view.userInteractionEnabled = NO;

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:urlString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        NSArray *array = [responseObject objectForKey:@"results"];

        if (array.count > 0) {
            [iTunesInstance saveSearchInfoInInstance:array];
        }
        else {
            [Utilities showAlertWithTitle:applicationName withMessage:@"No result found for this search." forView:self success:YES];
        }
        [searchTableView reloadData];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        self.view.userInteractionEnabled = YES;
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        self.view.userInteractionEnabled = YES;
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [Utilities showAlertWithTitle:@"Error" withMessage:@"Something went wrong. Kindly try again." forView:self success:NO];

    }];
}

#pragma mark -  action  methods-----------------
- (void)entityButtonClicked:(UIBarButtonItem *)barButton event:(UIEvent *)event{
    
    [FTPopOverMenu showFromEvent:event
                        withMenu:listOfEntity
                  imageNameArray:nil
                       doneBlock:^(NSInteger selectedIndex) {
                           instance.selectedEntity = [listOfEntity objectAtIndex:selectedIndex];
                           [barButton setTitle:[instance.selectedEntity objectForKey:@"name"]];
                       } dismissBlock:^{
                           
                       }];
}

#pragma mark - Table view data source-----------------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return instance.listOfResults.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 78;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomResultCell *cell = (CustomResultCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    iTunesObject *resultInfo = [instance.listOfResults objectAtIndex:indexPath.row];
    
    cell.trackNameLabel.text = resultInfo.trackName;
    cell.trackPriceLabel.text = resultInfo.trackPrice;
    cell.shortDescriptionLabel.text = resultInfo.shortDescription;
    
    if (resultInfo.artworkUrl60 != nil && ![resultInfo.artworkUrl60 isEqual:[NSNull null]]) {
        [[Utilities makeRoundCornerForObject:cell.iconImageView ofRadius:cell.iconImageView.frame.size.height/2] setImageWithURL:[NSURL URLWithString:resultInfo.artworkUrl60] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
    }
    return cell;
}

#pragma mark - TableView Delegates-----------------

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    instance.selectedResultIndex = indexPath.row;
    NAVIGATE_TO_VIEW(searchDetailedView);
}

#pragma Mark Search Delegates-----------------

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    keywordSearchBar.showsCancelButton = YES;
}

- (IBAction)cancelButtonClicked:(id)sender {
    [self searchBarCancelButtonClicked:keywordSearchBar];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    keywordSearchBar.showsCancelButton = NO;
    [self.view endEditing:YES];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    //sending the api request to fetch the results according to user search.
    [self getListOfResultsForCategory];
    [self.view endEditing:YES];
}

@end
