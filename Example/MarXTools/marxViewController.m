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
    v.backgroundColor = [UIColor lw_color_hexString:@"#eeeeee"];
    [v addTarget:self action:@selector(clickbutton) forControlEvents:UIControlEventTouchDown];
    [v lw_cycleView];
    v.lw_click_timeInterval = 6;
    [self.view addSubview:v];
    

	// Do any additional setup after loading the view, typically from a nib.
}

- (void)clickbutton{
    NSLog(@"----%@",[self.view lw_allSubViews]);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
