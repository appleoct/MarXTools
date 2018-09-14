//
//  UITextField+MarXTools.m
//  MarXTools
//
//  Created by CodeRiding on 2018/6/21.
//

#import "UITextField+MarXTools.h"

@implementation UITextField (MarXTools)

@end


@implementation UITextField (lw_placeholder)

@dynamic lw_placeholderColor;
- (void)setLw_placeholderColor:(UIColor *)lw_placeholderColor
{
    [self setValue:lw_placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
}

@end
