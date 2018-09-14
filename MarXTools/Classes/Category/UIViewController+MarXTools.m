//
//  UIViewController+MarXTools.m
//  MarXTools
//
//  Created by CodeRiding on 2018/6/21.
//

#import "UIViewController+MarXTools.h"

@implementation UIViewController (MarXTools)

@end


@implementation UIViewController (lw_storyboard)

+ (instancetype)lw_initFromStoryboardName:(NSString *)sbName
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:sbName bundle:nil];
    NSString *vcName = NSStringFromClass([self class]);
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:vcName];

    return vc;
}

+ (instancetype)lw_initFromStoryboardClassName:(Class)sbClassName
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:NSStringFromClass(sbClassName) bundle:nil];
    NSString *vcName = NSStringFromClass([self class]);
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:vcName];
    
    return vc;
}

@end
