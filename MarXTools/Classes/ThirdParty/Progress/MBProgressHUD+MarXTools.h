//
//  MBProgressHUD+MarXTools.h
//  MarXTools_Example
//
//  Created by CodeRiding on 2018/6/28.
//  Copyright © 2018年 codeRiding. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (MarXTools)

+ (void)lw_show;
+ (void)lw_dismiss;

+ (MBProgressHUD *)lw_showHubOnWindow:(NSString *)title;
+ (MBProgressHUD *)lw_showHubOnWindow:(NSString *)title hideAfter:(NSTimeInterval)interval;

+ (MBProgressHUD *)lw_showHubOnWindow:(NSString *)title image:(UIImage *)image;
+ (MBProgressHUD *)lw_showHubOnWindow:(NSString *)title image:(UIImage *)image  hideAfter:(NSTimeInterval)interval;

@end
