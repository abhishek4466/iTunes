//
//  Utilities.m
//  iTunes Search
//
//  Created by Abhishek Tyagi on 11/18/16.
//  Copyright © 2016 Department of Education. All rights reserved.
//

#import "Utilities.h"
#import "FCAlertView.h"
#import "AFNetworking.h"

@implementation Utilities


+ (CGFloat)heigthWithWidth:(CGFloat)width andFont:(UIFont *)font string:(NSString *)string
{
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:string];
    [attrStr addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, [string length])];
    CGRect rect = [attrStr boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    return rect.size.height;
}

+ (UIImageView *)makeImageViewBlur:(UIImageView *)imageView {
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    
    // add effect to an effect view
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc]initWithEffect:blur];
    effectView.frame = imageView.frame;
    
    // add the effect view to the image view
    [imageView addSubview:effectView];
    return imageView;
}

+(id)makeRoundCornerForObject:(id)object ofRadius:(CGFloat)radius {
    [[object layer]setMasksToBounds:YES];
    [[object layer] setCornerRadius:radius];
    return object;
}

+ (void)showAlertWithTitle:(NSString *)title withMessage:(NSString *)errorMessage forView:(id)view success:(BOOL)success{
    FCAlertView *alert = [[FCAlertView alloc] init];
    alert.blurBackground = 1;
    alert.bounceAnimations = 1;
    alert.detachButtons = YES;
    if (success) {
        alert.colorScheme = alert.flatBlue;
    }
    else {
        alert.colorScheme = alert.flatRed;
    }
    [alert showAlertInView:view
                 withTitle:title
              withSubtitle:errorMessage
           withCustomImage:nil
       withDoneButtonTitle:nil
                andButtons:nil];

}

#pragma mark - internet reachability

+ (BOOL)checkInternetConnection {
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus)
    {
        if ([AFNetworkReachabilityManager sharedManager].reachable)
        {
            return YES;
        }
        else if ([AFNetworkReachabilityManager sharedManager].reachableViaWiFi)
        {
            return YES;
        }
        else if ([AFNetworkReachabilityManager sharedManager].reachableViaWWAN)
        {
            return YES;
        }
        else
        {
//            [self showAlertWithTitle:@"No Internet Connection" withMessage:@"Kindly check your internet connection."];
            return NO;
        }
    }
    else
    {
//        [self showAlertWithTitle:@"No Internet Connection" withMessage:@"Kindly check your internet connection."];
        return  NO;
    }
}


@end
