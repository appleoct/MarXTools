//
//  UIView+MarXTools.m
//  MarXTools
//
//  Created by CodeRiding on 2018/6/21.
//

#import "UIView+MarXTools.h"
#import <objc/runtime.h>

@implementation UIView (MarXTools)

- (UIViewController *)lw_parentController
{
    UIResponder *responder = [self nextResponder];
    while (responder) {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
        responder = [responder nextResponder];
    }
    return nil;
}

- (NSString *)lw_allSubViews
{
    NSMutableString *result = [NSMutableString string];
    NSString *class = NSStringFromClass(self.class);
    class = [class stringByReplacingOccurrencesOfString:@"_" withString:@""];
    [result appendFormat:@"<%@ frame=\"%@\">\n", class, NSStringFromCGRect(self.frame)];
    for (UIView *childView in self.subviews) {
        NSString *subviewXml = [childView lw_allSubViews];
        [result appendString:subviewXml];
    }
    [result appendFormat:@"</%@>\n", class];
    
    return result;
}

- (void)lw_removeAllSubviews
{
    while (self.subviews.count) {
        [self.subviews.lastObject removeFromSuperview];
    }
}

- (BOOL)lw_isShowingOnKeyWindow
{
    // 主窗口
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    // 以主窗口左上角为坐标原点, 计算self的矩形框
    CGRect newFrame = [keyWindow convertRect:self.frame fromView:self.superview];
    CGRect winBounds = keyWindow.bounds;
    
    // 主窗口的bounds 和 self的矩形框 是否有重叠
    BOOL intersects = CGRectIntersectsRect(newFrame, winBounds);
    
    return !self.isHidden && self.alpha > 0.01 && self.window == keyWindow && intersects;
}

+ (void)lw_drawLineOnView:(UIView*)view lineFrame:(CGRect)rect lineColor:(UIColor*)color
{
    UILabel *lineLab = [[UILabel alloc] initWithFrame:rect];
    lineLab.backgroundColor = color;
    [view sendSubviewToBack:lineLab];
    [view addSubview:lineLab];
}

- (void)lw_drawDottedLineWithLineWidth:(CGFloat)lineWidth lineMargin:(CGFloat)lineMargin lineLength:(CGFloat)lineLength lineColor:(UIColor *)lineColor
{
    CAShapeLayer *border = [CAShapeLayer layer];
    border.strokeColor = lineColor.CGColor;
    border.fillColor = nil;
    border.path = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
    border.frame = self.bounds;
    border.lineWidth = lineWidth;
    border.lineCap = @"round";
    border.lineDashPattern = @[@(lineLength), @(lineMargin)];
    [self.layer addSublayer:border];
}
@end


@implementation UIView (lw_cornerRadius)

- (void)lw_cycleView
{
    [self lw_cornerRadius:self.frame.size.width/2 borderColor:[UIColor clearColor] width:1.0];
}

- (void)lw_cornerRadius
{
    [self lw_cornerRadius:7];
}

- (void)lw_cornerRadius:(CGFloat)radius
{
    [self lw_cornerRadius:radius borderColor:[UIColor clearColor] width:1.0];
}

- (void)lw_cornerRadius:(CGFloat)radius color:(UIColor *)color
{
    [self lw_cornerRadius:radius borderColor:color width:1.0];
}

- (void)lw_cornerBorder:(CGFloat)width color:(UIColor *)color
{
    [self lw_cornerRadius:0 borderColor:color width:width];
}

- (void)lw_cornerRadius:(CGFloat)radius borderColor:(UIColor *)color width:(CGFloat)width
{
    if (!self.backgroundColor) {
        self.backgroundColor = [UIColor whiteColor];
    }
    
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = radius;
    self.layer.borderWidth = width;
    self.layer.borderColor = [color CGColor];
}



/**
 传说中更加优秀的性能

 @param radius 圆角尺寸
 */
- (void)lw_setCorner:(CGFloat)radius {
    [self lw_setCorner:radius backgroundColor:[UIColor whiteColor]];
}

- (void)lw_setCorner:(CGFloat)radius
     backgroundColor:(nonnull UIColor *)backgroundColor {
    [self lw_setCorner:radius backgroundColor:backgroundColor corners:UIRectCornerAllCorners];
}

- (void)lw_setCorner:(CGFloat)radius
     backgroundColor:(nonnull UIColor *)backgroundColor
             corners:(UIRectCorner)corners {
    [self lw_setCorner:CGSizeMake(radius, radius) backgroundColor:backgroundColor corners:corners borderColor:nil borderWidth:0];
}

- (void)lw_setCorner:(CGSize)cornerRadii
     backgroundColor:(nonnull UIColor *)backgroundColor
             corners:(UIRectCorner)corners
         borderColor:(nullable UIColor *)borderColor
         borderWidth:(CGFloat)borderWidth {
    //only scaleAspectFill not cause offscreen-renderd, do this for better display
    if ([self isKindOfClass:[UIImageView class]]) {
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
    }
    
    [self.layer lw_setRoundedCorner:cornerRadii cornerColor:backgroundColor corners:corners borderColor:borderColor borderWidth:borderWidth];
}

@end


@implementation UIView (lw_pointView)
static char pointViewKey;
- (UILabel *)pointView
{
    return objc_getAssociatedObject(self,&pointViewKey);
}

- (void)setPointView:(UILabel *)pointView
{
    objc_setAssociatedObject(self, &pointViewKey, pointView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)lw_showRedPoint_x:(CGFloat)x y:(CGFloat)y
{
    [self lw_showRedPointView_x:x y:y width:5];
}

- (void)lw_showRedPointView_x:(CGFloat)x y:(CGFloat)y width:(CGFloat)width
{
    [self lw_showPointView_x:x y:y width:width backgroundColor:[UIColor redColor]];
}

- (void)lw_showPointView_x:(CGFloat)x y:(CGFloat)y width:(CGFloat)width backgroundColor:(UIColor *)backgroundColor
{
    if (!self.pointView) {
        self.pointView = [[UILabel alloc] init];
        self.pointView.backgroundColor = backgroundColor;
        self.pointView.lw_width = width;
        self.pointView.lw_height = width;
        self.pointView.layer.cornerRadius = self.pointView.lw_height * 0.5;
        self.pointView.layer.masksToBounds = YES;
        [self insertSubview:self.pointView atIndex:self.subviews.count];
    }
    [self bringSubviewToFront:self.pointView];
    self.pointView.lw_x = x;
    self.pointView.lw_y = y;
    self.pointView.hidden = NO;
}

- (void)lw_showRedPointView_x:(CGFloat)x y:(CGFloat)y numberCount:(NSInteger)numberCount
{
    if (!self.pointView) {
        self.pointView = [[UILabel alloc] init];
        self.pointView.backgroundColor = [UIColor redColor];
    }
    self.pointView.lw_x = x;
    self.pointView.lw_y = y;
    self.pointView.text = [NSString stringWithFormat:@"%zd",numberCount];
    self.pointView.textAlignment = NSTextAlignmentCenter;
    self.pointView.textColor = [UIColor whiteColor];
    self.pointView.font = [UIFont systemFontOfSize:13];
    [self.pointView sizeToFit];
    self.pointView.lw_width += 8.5;
    self.pointView.layer.cornerRadius = self.pointView.lw_height * 0.5;
    self.pointView.layer.masksToBounds = YES;
    [self insertSubview:self.pointView atIndex:self.subviews.count];
    self.pointView.hidden = NO;
}

- (void)lw_hidePointView
{
    self.pointView.hidden = YES;
}
@end


@implementation UIView (lw_xib)
+ (instancetype)lw_viewFromXib
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}
@end


#pragma mark -
@implementation UIView (lw_frame)
@dynamic lw_maxX,lw_maxY;
- (CGFloat)lw_maxX
{
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)lw_maxY
{
    return CGRectGetMaxY(self.frame);
}

- (CGFloat)lw_top
{
    return self.frame.origin.y;
}

- (void)setLw_top:(CGFloat)lw_top
{
    CGRect frame = self.frame;
    frame.origin.y = lw_top;
    self.frame = frame;
}

- (CGFloat)lw_bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setLw_bottom:(CGFloat)lw_bottom
{
    CGRect frame = self.frame;
    frame.origin.y = lw_bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)lw_left
{
    return self.frame.origin.x;
}

- (void)setLw_left:(CGFloat)lw_left
{
    CGRect frame = self.frame;
    frame.origin.x = lw_left;
    self.frame = frame;
}

- (CGFloat)lw_right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setLw_right:(CGFloat)lw_right
{
    CGRect frame = self.frame;
    frame.origin.x = lw_right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)lw_x
{
    return self.frame.origin.x;
}

- (void)setLw_x:(CGFloat)lw_x
{
    CGRect frame = self.frame;
    frame.origin.x = lw_x;
    self.frame = frame;
}

- (CGFloat)lw_y
{
    return self.frame.origin.y;
}

- (void)setLw_y:(CGFloat)lw_y
{
    CGRect frame = self.frame;
    frame.origin.y = lw_y;
    self.frame = frame;
}

- (CGFloat)lw_width
{
    return self.frame.size.width;
}

- (void)setLw_width:(CGFloat)lw_width
{
    CGRect frame = self.frame;
    frame.size.width = lw_width;
    self.frame = frame;
}

- (CGFloat)lw_height
{
    return self.frame.size.height;
}

- (void)setLw_height:(CGFloat)lw_height
{
    CGRect frame = self.frame;
    frame.size.height = lw_height;
    self.frame = frame;
}

- (CGFloat)lw_centerX
{
    return self.center.x;
}

- (void)setLw_centerX:(CGFloat)lw_centerX
{
    CGPoint center = self.center;
    center.x = lw_centerX;
    self.center = center;
}

- (CGFloat)lw_centerY
{
    return self.center.y;
}

- (void)setLw_centerY:(CGFloat)lw_centerY
{
    CGPoint center = self.center;
    center.y = lw_centerY;
    self.center = center;
}

- (CGPoint)lw_origin
{
    return self.frame.origin;
}

- (void)setLw_origin:(CGPoint)lw_origin
{
    CGRect frame = self.frame;
    frame.origin = lw_origin;
    self.frame = frame;
}

- (CGSize)lw_size
{
    return self.frame.size;
}

- (void)setLw_size:(CGSize)lw_size
{
    CGRect frame = self.frame;
    frame.size = lw_size;
    self.frame = frame;
}

- (CGFloat)lw_endWithX:(CGFloat)x
{
    CGRect frame = self.frame;
    return CGRectGetMaxX(frame) + x;
}

- (CGFloat)lw_endWithY:(CGFloat)y
{
    CGRect frame = self.frame;
    return CGRectGetMaxY(frame) + y;
}

@end








@interface _RoundedCornerLayer : CALayer
@end

@implementation _RoundedCornerLayer
@end



@implementation CALayer (lw_cornerRadius)

- (void)lw_setRoundedCorner:(CGSize)cornerRadii
                cornerColor:(nonnull UIColor *)cornerColor
                    corners:(UIRectCorner)corners
                borderColor:(nullable UIColor *)borderColor
                borderWidth:(CGFloat)borderWidth {
    NSString *key = [NSString stringWithFormat:@"Identifier_%@x%@_%@_%@_%@_%@", @(cornerRadii.width), @(cornerRadii.height), cornerColor.description, @(corners), borderColor.description, @(borderWidth)];
    if ([key isEqualToString:self._cornerLayerIdentifier]) {
        //无需重复设置
        return;
    } else {
        self._cornerLayerIdentifier = key;
    }
    
    //remove exit layer
    for (CALayer *layer in self.sublayers) {
        if ([layer isKindOfClass:[_RoundedCornerLayer class]]) {
            [layer removeFromSuperlayer];
            break;
        }
    }
    
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (!context) {return;}
    
    //draw round corner by using eo rule
    CGContextSetLineWidth(context, 0);
    CGContextSetFillColorWithColor(context, cornerColor.CGColor);
    
    //outer rect path
    UIBezierPath *rectPath = [UIBezierPath bezierPathWithRect:self.bounds];
    //inner round path
    UIBezierPath *roundPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:cornerRadii];
    [rectPath appendPath:roundPath];
    
    CGContextAddPath(context, rectPath.CGPath);
    CGContextEOFillPath(context);
    
    //set border
    if (borderColor && borderWidth > 0) {
        CGContextSetFillColorWithColor(context, borderColor.CGColor);
        UIBezierPath *borderOutterPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:cornerRadii];
        UIBezierPath *borderInnerPath = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(self.bounds, borderWidth, borderWidth) byRoundingCorners:corners cornerRadii:cornerRadii];
        [borderOutterPath appendPath:borderInnerPath];
        
        CGContextAddPath(context, borderOutterPath.CGPath);
        CGContextEOFillPath(context);
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    _RoundedCornerLayer *subLayer = [_RoundedCornerLayer new];
    subLayer.frame = self.bounds;
    subLayer.opaque = YES;
    subLayer.contents = (__bridge id _Nullable)(image.CGImage);
    [self addSublayer:subLayer];
}

- (NSString *)_cornerLayerIdentifier {
    return objc_getAssociatedObject(self, @selector(_cornerLayerIdentifier));
}

- (void)set_cornerLayerIdentifier:(NSString *)_cornerLayerIdentifier {
    objc_setAssociatedObject(self, @selector(_cornerLayerIdentifier), _cornerLayerIdentifier, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
