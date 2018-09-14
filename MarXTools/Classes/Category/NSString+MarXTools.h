//
//  NSString+MarXTools.h
//  MarXTools
//
//  Created by CodeRiding on 2018/6/22.
//

#import <Foundation/Foundation.h>

@interface NSString (MarXTools)
- (NSDictionary *)lw_toDict;
- (BOOL) lw_isBlankString;
@end


@interface NSString (lw_phone)

/**
 将电话号码格式化为188 8888 8888

 @return 188 8888 8888
 */
- (NSString *)lw_format_phone;

/**
 恢复电话号码的格式

 @return 18888888888
 */
- (NSString*)lw_recoverFormat_phone;
@end



@interface NSString (lw_money)

/**
 去除多余的0

 @param string 价格
 @return 去除多余0的价格
 */
- (NSString *)lw_rmbWithoutZero:(NSString *)string;
@end


@interface NSString (lw_security)

/**
 对字符串进行加密

 @return MD5加密后的字符串
 */
- (NSString *)lw_toMD5;
@end


@interface NSString (lw_image)

/**
 解析图片数据

 @return 图片
 */
- (UIImage *)lw_decodingToImage;
@end
