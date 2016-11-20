//
//  SearchViewController.h
//  iTunes Search
//
//  Created by Abhishek Tyagi on 11/17/16.
//  Copyright © 2016 Department of Education. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController {
    
    __weak IBOutlet UISearchBar     *keywordSearchBar;
    __weak IBOutlet UITableView     *searchTableView;
}

@end
