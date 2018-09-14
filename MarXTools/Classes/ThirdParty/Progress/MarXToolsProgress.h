//
//  MarXToolsProgress.h
//  MarXTools
//
//  Created by CodeRiding on 2018/6/28.
//  Copyright © 2018年 codeRiding. All rights reserved.
//

#ifndef MarXToolsProgress_h
#define MarXToolsProgress_h

#import "MBProgressHUD+MarXTools.h"

#define lw_progress_show()     [MBProgressHUD lw_showHubOnWindow]
#define lw_progress_hide()     [MBProgressHUD lw_hideHubOnWindow]

#define lw_progress_showMsg(msg)  [MBProgressHUD lw_showHubOnWindow:msg]
#define lw_progress_show_hideAfter(msg,interval)  [MBProgressHUD lw_showHubOnWindow:msg hideAfter:interval]

#endif /* MarXToolsProgress_h */
