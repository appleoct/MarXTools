//
//  UIViewController+MarXTools.h
//  MarXTools
//
//  Created by CodeRiding on 2018/6/21.
//

#import <UIKit/UIKit.h>

@interface UIViewController (MarXTools)

@end


@interface UIViewController (lw_storyboard)

/**
 控制器加载

 @param sbName storyboar名字
 @return 控制器
 */
+ (instancetype)lw_initFromStoryboardName:(NSString *)sbName;
+ (instancetype)lw_initFromStoryboardClassName:(Class)sbClassName;
@end
