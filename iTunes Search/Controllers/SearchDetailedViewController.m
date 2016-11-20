//
//  SearchDetailedViewController.m
//  iTunes Search
//
//  Created by Abhishek Tyagi on 11/18/16.
//  Copyright © 2016 Department of Education. All rights reserved.
//

#import "SearchDetailedViewController.h"
#import "Constants.h"

#define ImageCellIdentifier @"ImageCell"
#define DescriptionCellIdentifier @"DescriptionCell"

@interface SearchDetailedViewController () {
    iTunesInstance              *instance;
}
@end

@implementation SearchDetailedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    instance = [iTunesInstance getInstanceOfiTunesSearch];
    self.tableView.alwaysBounceVertical = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source--------------------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        return 214;
    }
    iTunesObject *resultInfo = [instance.listOfResults objectAtIndex:instance.selectedResultIndex];
    float height = [Utilities heigthWithWidth:self.view.frame.size.width-16 andFont:[UIFont systemFontOfSize:14] string:resultInfo.longDescription];
    return height+43;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    iTunesObject *resultInfo = [instance.listOfResults objectAtIndex:instance.selectedResultIndex];
    
    CustomResultCell *cell;

    if (indexPath.row == 0) {
        cell = (CustomResultCell*)[tableView dequeueReusableCellWithIdentifier:ImageCellIdentifier];
        cell.trackNameLabel.text = resultInfo.trackName;
        cell.artistNameLabel.text = resultInfo.artistName;
        
        if (resultInfo.artworkUrl60 != nil && ![resultInfo.artworkUrl60 isEqual:[NSNull null]]) {
            [[Utilities makeRoundCornerForObject:cell.iconImageView ofRadius:cell.iconImageView.frame.size.height/2] setImageWithURL:[NSURL URLWithString:resultInfo.artworkUrl60] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
            [[Utilities makeImageViewBlur:cell.blurredImageView] setImageWithURL:[NSURL URLWithString:resultInfo.artworkUrl60] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
        }
    }
    else {
        cell = (CustomResultCell*)[tableView dequeueReusableCellWithIdentifier:DescriptionCellIdentifier];
        cell.longDescriptionLabel.text = resultInfo.longDescription;
    }
    
    return cell;
}

@end
