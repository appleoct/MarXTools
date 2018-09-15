//
//  UILabel+MarXTools.m
//  MarXTools
//
//  Created by CodeRiding on 2018/6/21.
//

#import "UILabel+MarXTools.h"

@implementation UILabel (MarXTools)

@end


@implementation UILabel (lw_size)

- (CGFloat)lw_labelHeightFromWidth:(CGFloat)width{
    self.frame = CGRectMake(0, 0, width, 0);
    [self sizeToFit];
    self.numberOfLines = 0;
    return self.frame.size.height;
}

@end


@implementation UILabel (lw_attribute)

- (NSAttributedString*)lw_attributeRange:(NSRange )range color:(UIColor*)color
{
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:self.text];
    
    [attributedStr addAttribute:NSForegroundColorAttributeName
                          value:color
                          range:range];
    return attributedStr;
}

- (NSAttributedString*)lw_attributeRange:(NSRange )range font:(UIFont *)font
{
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:self.text];
    
    [attributedStr addAttribute:NSFontAttributeName
                          value:font
                          range:range];

    return attributedStr;
}

- (NSAttributedString*)lw_attributeRange:(NSRange )range color:(UIColor*)color  font:(UIFont *)font
{
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:self.text];
    
    [attributedStr addAttribute:NSFontAttributeName
                          value:font
                          range:range];
    
    [attributedStr addAttribute:NSForegroundColorAttributeName
                          value:color
                          range:range];
    return attributedStr;
}
@end
