//
//  marxViewController.m
//  MarXTools
//
//  Created by codeRiding on 06/21/2018.
//  Copyright (c) 2018 codeRiding. All rights reserved.
//

#import "marxViewController.h"
#import "MarXTools.h"

@interface marxViewController ()

@end

@implementation marxViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *v = [[UIButton alloc]initWithFrame:CGRectMake(self.view.lw_centerX, self.view.lw_centerY, 200, 200)];
//    v.backgroundColor = UIColor.greenColor;
    [v addTarget:self action:@selector(clickbutton) forControlEvents:UIControlEventTouchDown];
    [v lw_cornerBorder:1 color:[UIColor redColor]];
    v.lw_click_timeInterval = 6;
    [self.view addSubview:v];
	// Do any additional setup after loading the view, typically from a nib.
    
    ///2018-09-06 14:36:43
    NSDate *sdate = [NSDate lw_normalTime_to_nsdate:@"2018-09-06 14:36:43"];
    NSDate *edate = [NSDate date];
    NSTimeInterval s = [NSDate lw_comparesDate:sdate edate:edate];
    NSLog(@"++%f",s);
    
}

- (void)clickbutton{
    NSLog(@"----%@",[self.view lw_allSubViews]);
    [MBProgressHUD lw_showHubOnWindow:@"上传成功" image:lw_image(@"success") hideAfter:2];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
