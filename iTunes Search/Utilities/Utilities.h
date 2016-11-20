//
//  Utilities.h
//  iTunes Search
//
//  Created by Abhishek Tyagi on 11/18/16.
//  Copyright © 2016 Department of Education. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Utilities : NSObject

+ (CGFloat)heigthWithWidth:(CGFloat)width andFont:(UIFont *)font string:(NSString *)string;
+ (UIImageView *)makeImageViewBlur:(UIImageView *)imageView;
+(id)makeRoundCornerForObject:(id)object ofRadius:(CGFloat)radius;
+ (void)showAlertWithTitle:(NSString *)title withMessage:(NSString *)errorMessage forView:(id)view success:(BOOL)success;
+ (BOOL)checkInternetConnection;
@end
