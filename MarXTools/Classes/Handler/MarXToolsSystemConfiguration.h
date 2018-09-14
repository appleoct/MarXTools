//
//  MarXToolsSystemConfiguration.h
//  MarXTools
//
//  Created by CodeRiding on 2018/6/22.
//

#import <Foundation/Foundation.h>

@interface MarXToolsSystemConfiguration : NSObject

@end


@interface MarXToolsSystemConfiguration (lw_phone)

/**
 手机UUID

 @return 手机UUID
 */
+ (NSString *)lw_phone_uuid;

/**
 手机系统版本号

 @return 系统版本号
 */
+ (NSString *)lw_phone_systemVersion;

/**
 APP软件版本号

 @return 软件版本号
 */
+ (NSString *)lw_appVersion;

/**
 获取手机可用空间

 @return 可用空间
 */
+ (NSString *)lw_phone_freeSpace;

/**
 获取手机总的内存

 @return 总的内存
 */
+ (NSString *)lw_phone_totalMemory;

/**
 获取手机运营商

 @return 手机运行商
 */
+ (NSString *)lw_phone_carrierName;
+ (NSString *)lw_phone_networkType;
@end


@interface MarXToolsSystemConfiguration (lw_cache)

/**
 清除缓存

 @param completion 清除缓存后回调
 */
+ (void)lw_clearCache:(void (^)(void))completion;

/**
 获取缓存

 @param completion 获取缓存后回调
 */
+ (void)lw_getCache:(void (^)(NSString *))completion;
@end
