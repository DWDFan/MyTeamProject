//
//  WLDgViewController.m
//  MyBoRuiSi
//
//  Created by wsl on 16/8/9.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLDgViewController.h"

@interface WLDgViewController ()

@end

@implementation WLDgViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
    btn.backgroundColor = [UIColor clearColor];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setImage:[UIImage imageNamed:@"图层-47"] forState:UIControlStateNormal];
    [btn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
    [btn setTitle:@"教学大纲" forState:UIControlStateNormal];
    self.navigationItem.titleView = btn;
    
    
    
    [self.navigationController.navigationBar setBackgroundImage:[MOTool createImageWithColor:RGBA(255, 255, 255, 1)] forBarMetrics:UIBarMetricsDefault];
    
  }



@end
