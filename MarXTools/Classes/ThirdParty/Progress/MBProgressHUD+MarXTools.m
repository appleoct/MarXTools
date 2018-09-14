//
//  MBProgressHUD+MarXTools.m
//  MarXTools_Example
//
//  Created by CodeRiding on 2018/6/28.
//  Copyright © 2018年 codeRiding. All rights reserved.
//

#import "MBProgressHUD+MarXTools.h"

static CGFloat FONT_SIZE = 14.0f;

@implementation MBProgressHUD (MarXTools)

+ (void)lw_showHubOnWindow
{
    [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].windows.firstObject animated:YES];
}

+ (void)lw_hideHubOnWindow
{
    [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].windows.firstObject animated:YES];
}

+ (MBProgressHUD *)lw_showHubOnWindow:(NSString *)title
{
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].windows.firstObject animated:YES];
    hub.label.font = [UIFont systemFontOfSize:FONT_SIZE];
    hub.label.text = title;
    return hub;
}

+ (MBProgressHUD *)lw_showHubOnWindow:(NSString *)title hideAfter:(NSTimeInterval)interval
{
    MBProgressHUD *hub = [self lw_showHubOnWindow:title];
    [hub hideAnimated:YES afterDelay:interval];
    return hub;
}

+ (MBProgressHUD *)lw_showHubOnWindow:(NSString *)title image:(UIImage *)image
{
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].windows.firstObject animated:YES];
    hub.label.font = [UIFont systemFontOfSize:FONT_SIZE];
    hub.label.text = title;
    hub.mode = MBProgressHUDModeCustomView;
    hub.customView = [[UIImageView alloc] initWithImage:image];
    return hub;
}

+ (MBProgressHUD *)lw_showHubOnWindow:(NSString *)title image:(UIImage *)image  hideAfter:(NSTimeInterval)interval
{
    MBProgressHUD *hub = [self lw_showHubOnWindow:title image:image];
    [hub hideAnimated:YES afterDelay:interval];
    return hub;
}

@end
