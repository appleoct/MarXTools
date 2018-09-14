//
//  MarXToolsPCH.h
//  Pods
//
//  Created by CodeRiding on 2018/6/22.
//

#ifndef MarXToolsPCH_h
#define MarXToolsPCH_h

/// 控制器
#define lw_push(vc)    [self.navigationController pushViewController:vc animated:YES];
#define lw_dismissVC   [self dismissViewControllerAnimated:YES completion:nil];
#define lw_vc(sbName, vcName) [[UIStoryboard storyboardWithName:sbName bundle:nil] instantiateViewControllerWithIdentifier:vcName]
#define lw_vcFromSb(sbName) [[UIStoryboard storyboardWithName:sbName bundle:nil] instantiateViewControllerWithIdentifier:sbName]


/// 图片
#define lw_image(name) [UIImage imageNamed:name]


/// 系统
#define lw_windows [UIApplication sharedApplication].windows.firstObject
#define lw_keyWindow [UIApplication sharedApplication].keyWindow
#define lw_delegate ((AppDelegate *)[UIApplication sharedApplication].delegate)
#define lw_scrren_width ([UIScreen mainScreen].bounds.size.width)
#define lw_scrren_height ([UIScreen mainScreen].bounds.size.height)

#define lw_isIPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define lw_isIPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define lw_isIPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define lw_isIPhone6P ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define lw_isIPhoneX ([[UIApplication sharedApplication] statusBarFrame].size.height>20)

#define lw_ios_version ([[[UIDevice currentDevice] systemVersion] floatValue])
#define lw_isIOS7 ((lw_ios_version >= 7.0) ? YES : NO)
#define lw_isIOS8 ((lw_ios_version >= 8.0) ? YES : NO)
#define lw_isIOS9 ((lw_ios_version >= 9.0) ? YES : NO)
#define lw_isIOS11 ((lw_ios_version >= 11.0) ? YES : NO)


/// 颜色
#define lw_rgb(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define lw_rgba(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]



/// 网络
#define lw_url(String) [NSURL URLWithString:String]


/// 打印
#ifdef DEBUG
#   define lw_log(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define lw_log(...)
#endif



/// 弱引用和强引用
#ifndef lw_weakify
#if DEBUG
#if __has_feature(objc_arc)
#define lw_weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define lw_weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define lw_weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define lw_weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif


#ifndef lw_strongify
#if DEBUG
#if __has_feature(objc_arc)
#define lw_strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define lw_strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define lw_strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define lw_strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif

#endif /* MarXToolsPCH_h */
