//
//  UITextView+MarXTools.h
//  MarXTools
//
//  Created by CodeRiding on 2018/6/22.
//

#import <UIKit/UIKit.h>

@interface UITextView (MarXTools)

/**
 文字居中
 */
- (void)lw_resetContentSizeToCenter;
@end


FOUNDATION_EXPORT double UITextView_PlaceholderVersionNumber;
FOUNDATION_EXPORT const unsigned char UITextView_PlaceholderVersionString[];
@interface UITextView (lw_placeholder)

+ (UIColor *)defaultPlaceholderColor;

@property (nonatomic, readonly) UILabel *placeholderLabel;
@property (nonatomic, strong) NSAttributedString *attributedPlaceholder;

@property (nonatomic, strong) IBInspectable NSString *placeholder;
@property (nonatomic, strong) IBInspectable UIColor *placeholderColor;

@end
