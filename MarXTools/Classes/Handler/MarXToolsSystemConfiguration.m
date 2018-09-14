//
//  MarXToolsSystemConfiguration.m
//  MarXTools
//
//  Created by CodeRiding on 2018/6/22.
//

#import "MarXToolsSystemConfiguration.h"
#include <sys/mount.h>

#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
@implementation MarXToolsSystemConfiguration

@end


@implementation MarXToolsSystemConfiguration (lw_phone)

+ (NSString *)lw_phone_uuid
{
    NSString *uuid =[[[UIDevice currentDevice] identifierForVendor] UUIDString];
    
    return uuid;
}

+ (NSString *)lw_phone_systemVersion
{
    NSString *version = [UIDevice currentDevice].systemVersion;
    
    return version;
}

+ (NSString *)lw_appVersion
{
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    
    return appVersion;
}

+ (NSString *)lw_phone_freeSpace
{
    struct statfs buf;
    unsigned long long freeSpace = -1;
    if (statfs("/var", &buf) >= 0){
        freeSpace = (unsigned long long)(buf.f_bsize * buf.f_bavail);
    }
    return [NSString stringWithFormat:@"%llu",freeSpace];
}

+ (NSString *)lw_phone_totalMemory
{
    unsigned long long memory = [NSProcessInfo processInfo].physicalMemory;
    return [NSString stringWithFormat:@"%llu",memory];
}

+ (NSString *)lw_phone_carrierName
{
    CTTelephonyNetworkInfo *telephonyInfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [telephonyInfo subscriberCellularProvider];
    NSString *currentCountry = [carrier carrierName];
    return currentCountry;
}

+ (NSString *)lw_phone_networkType
{
    UIApplication *application = [UIApplication sharedApplication];
    UIView *statusBar = [application valueForKey:@"statusBar"];
    if([statusBar isKindOfClass:[NSClassFromString(@"UIStatusBar_Modern") class]]) {
        statusBar = [statusBar valueForKey:@"statusBar"];
    }
    UIView *foregroundView = [statusBar valueForKey:@"foregroundView"];
    NSArray *subviews = [foregroundView subviews];
    
    NSNumber *dataNetworkItemView = nil;
    
    for (id subview in subviews) {
        if([subview isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
            dataNetworkItemView = subview;
            break;
        }
    }
    NSString *networkType = nil;
    switch ([[dataNetworkItemView valueForKey:@"dataNetworkType"] integerValue]) {
        case 0:
            networkType = @"无服务";
            break;
            
        case 1:
            networkType = @"2G";
            break;
            
        case 2:
            networkType = @"3G";
            break;
            
        case 3:
            networkType = @"4G";
            break;
            
        case 4:
            networkType = @"LTE";
            break;
            
        case 5:
            networkType = @"Wifi";
            break;
            
        default:
            break;
    }
    return networkType;
}

@end


@implementation MarXToolsSystemConfiguration (lw_cache)
+ (void)lw_clearCache:(void (^)(void))completion
{
    NSString *directoryPath =  [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    
    // 获取文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    BOOL isDirectory;
    BOOL isExist = [mgr fileExistsAtPath:directoryPath isDirectory:&isDirectory];
    
    if (!isExist || !isDirectory) {
        // 抛异常
        // name:异常名称
        // reason:报错原因
        NSException *excp = [NSException exceptionWithName:@"pathError" reason:@"需要传入的是文件夹路径,并且路径要存在" userInfo:nil];
        [excp raise];
        
    }
    
    // 获取cache文件夹下所有文件,不包括子路径的子路径
    NSArray *subPaths = [mgr contentsOfDirectoryAtPath:directoryPath error:nil];
    
    for (NSString *subPath in subPaths) {
        // 拼接完成全路径
        NSString *filePath = [directoryPath stringByAppendingPathComponent:subPath];
        
        // 删除路径
        [mgr removeItemAtPath:filePath error:nil];
        
        
    }
    
    if (completion)
        completion();
}

+ (void)lw_getCache:(void (^)(NSString *))completion
{
    NSString *directoryPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    
    // 获取文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    BOOL isDirectory;
    BOOL isExist = [mgr fileExistsAtPath:directoryPath isDirectory:&isDirectory];
    
    if (!isExist || !isDirectory) {
        // 抛异常
        // name:异常名称
        // reason:报错原因
        NSException *excp = [NSException exceptionWithName:@"pathError" reason:@"笨蛋 需要传入的是文件夹路径,并且路径要存在" userInfo:nil];
        [excp raise];
        
    }
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        // 获取文件夹下所有的子路径,包含子路径的子路径
        NSArray *subPaths = [mgr subpathsAtPath:directoryPath];
        
        NSInteger totalSize = 0;
        
        for (NSString *subPath in subPaths) {
            // 获取文件全路径
            NSString *filePath = [directoryPath stringByAppendingPathComponent:subPath];
            
            // 判断隐藏文件
            if ([filePath containsString:@".DS"]) continue;
            
            // 判断是否文件夹
            BOOL isDirectory;
            // 判断文件是否存在,并且判断是否是文件夹
            BOOL isExist = [mgr fileExistsAtPath:filePath isDirectory:&isDirectory];
            if (!isExist || isDirectory) continue;
            
            // 获取文件属性
            // attributesOfItemAtPath:只能获取文件尺寸,获取文件夹不对,
            NSDictionary *attr = [mgr attributesOfItemAtPath:filePath error:nil];
            
            // 获取文件尺寸
            NSInteger fileSize = [attr fileSize];
            
            totalSize += fileSize;
        }
        
        // 计算完成回调(为了避免计算大的文件夹,比较耗时,如果直接返回结果,控制器跳转的时候回产生卡顿,所以采用block回调的方式)
        dispatch_sync(dispatch_get_main_queue(), ^{
            if (completion) {
                
                NSString *sizeStr = @"";
                // MB KB B
                if (totalSize > 1000 * 1000) {
                    // MB
                    CGFloat sizeF = totalSize / 1000.0 / 1000.0;
                    sizeStr = [NSString stringWithFormat:@"%@%.1fMB",sizeStr,sizeF];
                } else if (totalSize > 1000) {
                    // KB
                    CGFloat sizeF = totalSize / 1000.0;
                    sizeStr = [NSString stringWithFormat:@"%@%.1fKB",sizeStr,sizeF];
                } else if (totalSize > 0) {
                    // B
                    sizeStr = [NSString stringWithFormat:@"%@%.ldB",sizeStr,totalSize];
                }
                
                completion(sizeStr);
            }
        });
        
    });
}
@end
