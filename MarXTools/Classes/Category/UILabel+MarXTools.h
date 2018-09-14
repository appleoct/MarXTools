//
//  UILabel+MarXTools.h
//  MarXTools
//
//  Created by CodeRiding on 2018/6/21.
//

#import <UIKit/UIKit.h>

@interface UILabel (MarXTools)

@end


@interface UILabel (lw_size)
- (CGFloat)lw_labelHeightFromWidth:(CGFloat)width;
@end


@interface UILabel (lw_attribute)
- (NSAttributedString*)lw_attributeRange:(NSRange )range color:(UIColor*)color;
- (NSAttributedString*)lw_attributeRange:(NSRange )range font:(UIFont *)font;
- (NSAttributedString*)lw_attributeRange:(NSRange )range color:(UIColor*)color  font:(UIFont *)font;
@end
