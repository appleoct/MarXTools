//
//  UIWindow+MarXTools.m
//  MarXTools
//
//  Created by CodeRiding on 2018/6/21.
//

#import "UIWindow+MarXTools.h"

@implementation UIWindow (MarXTools)

@end



#pragma mark -
@implementation UIWindow (lw_viewController)
- (UIViewController *)lw_currentTopVC
{
    UIViewController *topViewController = [self rootViewController];
    
    while (true) {
        if (topViewController.presentedViewController)
        {
            topViewController = topViewController.presentedViewController;
            
        } else if ([topViewController isKindOfClass:[UINavigationController class]] && [(UINavigationController*)topViewController topViewController])
        {
            topViewController = [(UINavigationController *)topViewController topViewController];
            
        } else if ([topViewController isKindOfClass:[UITabBarController class]])
        {
            UITabBarController *tab = (UITabBarController *)topViewController;
            topViewController = tab.selectedViewController;
            
        } else {
            break;
        }
    }
    
    return topViewController;
}
@end
