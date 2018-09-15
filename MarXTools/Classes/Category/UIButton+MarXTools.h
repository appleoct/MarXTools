//
//  UIButton+MarXTools.h
//  MarXTools
//
//  Created by CodeRiding on 2018/6/22.
//

#import <UIKit/UIKit.h>

@interface UIButton (MarXTools)

@end


@interface UIButton (lw_touch)
/**设置点击时间间隔*/
@property (nonatomic, assign) NSTimeInterval lw_click_timeInterval;
/**
 *  用于设置单个按钮不需要被hook
 */
@property (nonatomic, assign) BOOL isIgnore;
@end


typedef NS_ENUM(NSUInteger, lw_imagetitle_style) {
    lw_imagetitle_style_topImage_bottomLabel,     // 上image，下label
    lw_imagetitle_style_topLabel_bottomImage,    // 上label,下image
    lw_imagetitle_style_leftImage_rightLabel,  // 左image，右label
    lw_imagetitle_style_leftLabel_rightImage    // 左label,右image
};
@interface UIButton (lw_imagetitle)
- (void)lw_topImage_bottomLabel:(UIImage *)image  margin:(CGFloat )margin;
- (void)lw_topLabel_bottomImage:(UIImage *)image margin:(CGFloat )margin;
- (void)lw_leftImage_rightLabel:(UIImage *)image margin:(CGFloat )margin;
- (void)lw_leftLabel_rightImage:(UIImage *)image margin:(CGFloat )margin;
@end
