//
//  CustomResultCell.h
//  iTunes Search
//
//  Created by Abhishek Tyagi on 11/17/16.
//  Copyright © 2016 Department of Education. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomResultCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel        *trackNameLabel;
@property (weak, nonatomic) IBOutlet UILabel        *trackPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel        *artistNameLabel;
@property (weak, nonatomic) IBOutlet UILabel        *shortDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel        *longDescriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView    *iconImageView;
@property (weak, nonatomic) IBOutlet UIImageView    *blurredImageView;

@end
