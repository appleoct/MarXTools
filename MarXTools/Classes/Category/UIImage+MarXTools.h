//
//  UIImage+MarXTools.h
//  MarXTools
//
//  Created by CodeRiding on 2018/6/22.
//

#import <UIKit/UIKit.h>

@interface UIImage (MarXTools)
- (NSString *)lw_toBase64String;

/**
 用颜色创建Image

 @param color 颜色
 @return UIImage
 */
+ (UIImage*)lw_imageWithColor:(UIColor*)color;
@end


@interface UIImage (lw_scale)

/**
 根据目标尺寸截取图片{从中间开始截取，如果图片很大，就只会截取中间的一块}

 @param targetFrame 目标尺寸
 @return 截取后的图片
 */
- (UIImage *)lw_cutImageToTargetFrame:(CGRect )targetFrame;

/**
 缩放照片尺寸

 @param newSize 新的尺寸
 @return 缩放后的Image
 */
- (UIImage *)lw_scaleImageToSize:(CGSize)newSize;

/**
 指定高度缩放

 @param targetHeight 目标高度
 @return 缩放后的图片
 */
- (UIImage *)lw_scaleImageToHeight:(NSInteger)targetHeight;

/**
 指定宽度缩放

 @param targetWidth 目标宽度
 @return 缩放后的图片
 */
- (UIImage *)lw_scaleImageToWidth:(NSInteger )targetWidth;

/**
 调整照片方向

 @return 调整方向后的Image
 */
- (UIImage *)lw_fixImageDirection;
@end
