//
//  UIColor+MarXTools.h
//  MarXTools
//
//  Created by CodeRiding on 2018/6/21.
//

#import <UIKit/UIKit.h>

@interface UIColor (MarXTools)

@end


@interface UIColor (lw_hexColor)

+ (UIColor *)lw_color_hexString:(NSString *)hexStr;

//从十六进制字符串获取颜色，
//color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
+ (UIColor *)lw_color_hexString:(NSString *)hexStr alpha:(CGFloat)alpha;

@end
