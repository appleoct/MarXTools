//
//  MarXToolsToast.h
//  Pods
//
//  Created by CodeRiding on 2018/6/29.
//

#ifndef MarXToolsToast_h
#define MarXToolsToast_h

/// 两边都定义，主要是兼容只导入这个文件，无法使用的问题
#define lw_t_scrren_width            ([UIScreen mainScreen].bounds.size.width)
#define lw_t_scrren_height           ([UIScreen mainScreen].bounds.size.height)
#define lw_t_windows                 [UIApplication sharedApplication].windows.firstObject
#define lw_t_toast_time 2.0

/// 自己定义一个点，主要是适配iphoneX；原生太靠顶部和太靠底部，所以自定义点
#define lw_t_toast_top_pointValue       [NSValue valueWithCGPoint:CGPointMake(lw_scrren_width/2,84)]
#define lw_t_toast_bottom_pointValue    [NSValue valueWithCGPoint:CGPointMake(lw_scrren_width/2,lw_t_scrren_height-84)]

#define lw_toast_top(msg)     [lw_t_windows makeToast:msg duration:lw_t_toast_time position:lw_t_toast_top_pointValue];
#define lw_toast_center(msg)  [lw_t_windows makeToast:msg duration:lw_t_toast_time position:CSToastPositionCenter];
#define lw_toast_bottom(msg)  [lw_t_windows makeToast:msg duration:lw_t_toast_time position:lw_t_toast_bottom_pointValue];

#define lw_toast_top_time(msg,interval)     [lw_t_windows makeToast:msg duration:interval position:lw_t_toast_top_pointValue];
#define lw_toast_center_time(msg,interval)  [lw_t_windows makeToast:msg duration:interval position:CSToastPositionCenter];
#define lw_toast_bottom_time(msg,interval)  [lw_t_windows makeToast:msg duration:interval position:lw_t_toast_bottom_pointValue];

#endif /* MarXToolsToast_h */
