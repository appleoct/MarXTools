//
//  UIView+MarXTools.h
//  MarXTools
//
//  Created by CodeRiding on 2018/6/21.
//

#import <UIKit/UIKit.h>

@interface UIView (MarXTools)

/**
 通过响应者链条获取view所在的控制器

 @return 控制器
 */
- (UIViewController *)lw_parentController;


/**
 获取所有子视图
 @return 子视图字符串
 */
- (NSString *)lw_allSubViews;

/**
 移除所有子视图
 */
- (void)lw_removeAllSubviews;

/**
 * 判断一个控件是否真正显示在主窗口
 */
- (BOOL)lw_isShowingOnKeyWindow;

/**
 画线

 @param view 父视图
 @param rect 线的尺寸
 @param color 线的颜色
 */
+ (void)lw_drawLineOnView:(UIView*)view lineFrame:(CGRect)rect lineColor:(UIColor*)color;

/**
 *  给视图添加虚线边框
 *
 *  @param lineWidth  线宽
 *  @param lineMargin 每条虚线之间的间距
 *  @param lineLength 每条虚线的长度
 *  @param lineColor 每条虚线的颜色
 */
- (void)lw_drawDottedLineWithLineWidth:(CGFloat)lineWidth lineMargin:(CGFloat)lineMargin lineLength:(CGFloat)lineLength lineColor:(UIColor *)lineColor;
@end


@interface UIView (lw_cornerRadius)
- (void)lw_cycleView;
- (void)lw_cornerRadius;
- (void)lw_cornerRadius:(CGFloat)radius;
- (void)lw_cornerRadius:(CGFloat)radius color:(UIColor *)color;
- (void)lw_cornerBorder:(CGFloat)width color:(UIColor *)color;
- (void)lw_cornerRadius:(CGFloat)radius borderColor:(UIColor *)color width:(CGFloat)width;

/**
 设置圆角和边框
 
 @param cornerRadii 圆角尺寸
 @param backgroundColor 最好设置成白色
 @param corners 视图的边角，4个边角 {UIRectCorner r = UIRectCornerTopLeft | UIRectCornerBottomLeft;}
 @param borderColor 边框的颜色
 @param borderWidth 边框的宽度
 [v lw_setRoundedCorner:CGSizeMake(100, 100) backgroundColor:[UIColor whiteColor] corners:r borderColor:[UIColor blackColor] borderWidth:1];
 */
- (void)lw_setCorner:(CGSize)cornerRadii
     backgroundColor:(nonnull UIColor *)backgroundColor
             corners:(UIRectCorner)corners
         borderColor:(nullable UIColor *)borderColor
         borderWidth:(CGFloat)borderWidth;
@end


@interface UIView (lw_pointView)

/**
 红点

 @param x 坐标x
 @param y 坐标y
 @param numberCount 红点的值
 */
- (void)lw_showRedPointView_x:(CGFloat)x y:(CGFloat)y numberCount:(NSInteger)numberCount;


/**
 隐藏点视图
 */
- (void)lw_hidePointView;
@end


@interface UIView (lw_xib)

/**
 从xib加载View

 @return View
 */
+ (instancetype)lw_viewFromXib;
@end


@interface UIView (lw_frame)
@property (nonatomic) CGFloat lw_left;        ///< Shortcut for frame.origin.x.
@property (nonatomic) CGFloat lw_top;         ///< Shortcut for frame.origin.y
@property (nonatomic) CGFloat lw_right;       ///< Shortcut for frame.origin.x + frame.size.width
@property (nonatomic) CGFloat lw_bottom;      ///< Shortcut for frame.origin.y + frame.size.height

@property (nonatomic) CGFloat lw_x;
@property (nonatomic) CGFloat lw_y;
@property (nonatomic) CGFloat lw_maxX;
@property (nonatomic) CGFloat lw_maxY;
@property (nonatomic) CGFloat lw_width;       ///< Shortcut for frame.size.width.
@property (nonatomic) CGFloat lw_height;      ///< Shortcut for frame.size.height.

@property (nonatomic) CGFloat lw_centerX;     ///< Shortcut for center.x
@property (nonatomic) CGFloat lw_centerY;     ///< Shortcut for center.y
@property (nonatomic) CGPoint lw_origin;      ///< Shortcut for frame.origin.
@property (nonatomic) CGSize  lw_size;        ///< Shortcut for frame.size.

- (CGFloat)lw_endWithX:(CGFloat)x;
- (CGFloat)lw_endWithY:(CGFloat)y;
@end



@interface CALayer (lw_cornerRadius)
- (void)lw_setRoundedCorner:(CGSize)cornerRadii
                cornerColor:(nonnull UIColor *)cornerColor
                    corners:(UIRectCorner)corners
                borderColor:(nullable UIColor *)borderColor
                borderWidth:(CGFloat)borderWidth;
@property (nonatomic, strong) NSString *_cornerLayerIdentifier;
@end
