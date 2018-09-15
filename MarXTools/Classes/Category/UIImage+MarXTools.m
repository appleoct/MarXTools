//
//  UIImage+MarXTools.m
//  MarXTools
//
//  Created by CodeRiding on 2018/6/22.
//

#import "UIImage+MarXTools.h"

@implementation UIImage (MarXTools)

- (NSString *)lw_toBase64String
{
    NSData * data = [UIImagePNGRepresentation(self) base64EncodedDataWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return [NSString stringWithUTF8String:[data bytes]];
}

+ (UIImage*)lw_imageWithColor:(UIColor*)color
{
    CGSize imageSize = CGSizeMake(1, 1);
    UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
    [color set];
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end


@implementation UIImage (lw_scale)

- (UIImage *)lw_cutImageToTargetFrame:(CGRect )targetFrame
{
    UIImage *scaleImage=[[UIImage alloc]init];
    
    if (targetFrame.size.width/targetFrame.size.height > self.size.width/self.size.height)
    {
        CGSize imageSize = self.size;
        CGFloat width = imageSize.width;
        CGFloat height = imageSize.height;
        CGFloat targetWidth = targetFrame.size.width;
        CGFloat targetHeight = height / (width / targetWidth);
        CGSize size = CGSizeMake(targetWidth, targetHeight);
        scaleImage=[self lw_scaleImageToSize:size];
    }else{
        
        CGSize imageSize = self.size;
        CGFloat width = imageSize.width;
        CGFloat height = imageSize.height;
        CGFloat targetHeight = targetFrame.size.height;
        CGFloat targetWidth = width / (height / targetHeight);
        CGSize size = CGSizeMake(targetWidth, targetHeight);
        scaleImage=[self lw_scaleImageToSize:size];
    }
    
    CGFloat targetWidth = targetFrame.size.width;
    CGFloat destionX = 0;
    CGFloat destionY = 0;
    
    if (scaleImage.size.width>targetWidth){
        destionX=(scaleImage.size.width-targetWidth)/2;
    }else{
        destionX=0;
    }
    if (scaleImage.size.height > targetFrame.size.height)
    {
        destionY=(scaleImage.size.height - targetFrame.size.height)/2;
    }else{
        destionY=0;
    }
    
    CGRect cropRect = CGRectMake(destionX,destionY,targetFrame.size.width ,targetFrame.size.height);
    cropRect = CGRectMake(cropRect.origin.x * scaleImage.scale,
                          cropRect.origin.y * scaleImage.scale,
                          cropRect.size.width * scaleImage.scale,
                          cropRect.size.height * scaleImage.scale);
    CGImageRef imagePartRef = CGImageCreateWithImageInRect(scaleImage.CGImage, cropRect);
    scaleImage = [UIImage imageWithCGImage:imagePartRef];
    CGImageRelease(imagePartRef);
    
    return scaleImage;
}

- (UIImage *)lw_scaleImageToSize:(CGSize)newSize
{
    CGRect scaledImageRect = CGRectZero;
    
    CGFloat aspectWidth = newSize.width / self.size.width;
    CGFloat aspectHeight = newSize.height / self.size.height;
    CGFloat aspectRatio = MIN ( aspectWidth, aspectHeight );
    
    scaledImageRect.size.width = self.size.width * aspectRatio;
    scaledImageRect.size.height = self.size.height * aspectRatio;
    scaledImageRect.origin.x = (newSize.width - scaledImageRect.size.width) / 2.0f;
    scaledImageRect.origin.y = (newSize.height - scaledImageRect.size.height) / 2.0f;
    
    UIGraphicsBeginImageContextWithOptions( newSize, NO, 0.0);
    [self drawInRect:scaledImageRect];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

- (UIImage *)lw_scaleImageToHeight:(NSInteger)targetHeight
{
    CGFloat targetWidth = self.size.width / (self.size.height / targetHeight);
    return [self lw_scaleImageToWidth:targetWidth targetHeight:targetHeight];
}

- (UIImage *)lw_scaleImageToWidth:(NSInteger )targetWidth
{
    CGFloat targetHeight = self.size.height / (self.size.width / targetWidth);
    return [self lw_scaleImageToWidth:targetWidth targetHeight:targetHeight];
}

- (UIImage *)lw_scaleImageToWidth:(NSInteger )targetWidth targetHeight:(NSInteger )targetHeight
{
    UIImage *newImage = nil;
    CGSize imageSize = self.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    
    CGSize size = CGSizeMake(targetWidth, targetHeight);
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    if(CGSizeEqualToSize(imageSize, size) == NO){
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        if(widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(size);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [self drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil){
        NSLog(@"scale image fail");
    }
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)lw_fixImageDirection{
    
    // No-op if the orientation is already correct
    if (self.imageOrientation == UIImageOrientationUp)
        return self;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (self.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    
    return img;
}
@end
