//
//  WLOrderPayOKViewController.m
//  MyBoRuiSi
//
//  Created by 莫瑞伟 on 16/8/4.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLOrderPayOKViewController.h"
#import "UIImage+Image.h"

@interface WLOrderPayOKViewController ()
@property (weak, nonatomic) IBOutlet UIButton *button_lookOrder;
@property (weak, nonatomic) IBOutlet UIButton *button_can;

@end

@implementation WLOrderPayOKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [MOTool MODealWithRadius:4 border:1 borderColor:color_red view:self.button_can];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    //左
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:btn];
    // 设置导航条的按钮
    self.navigationItem.leftBarButtonItem = right;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    //设置导航控制器导航上的背景图片，并且拉伸
    UIColor *colorx = [[UIColor colorWithPatternImage:[UIImage imageNamed:@"navW"]]colorWithAlphaComponent:0.00];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage cleImage:colorx] forBarMetrics:UIBarMetricsDefault];
    //    让黑线消失的方法
    self.navigationController.navigationBar.shadowImage=[UIImage new];
    
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    //设置导航控制器导航上的背景图片，并且拉伸
    [self.navigationController.navigationBar setBackgroundImage:[UIImage cleImage:RGBA(255, 255, 255, 1)] forBarMetrics:UIBarMetricsDefault];
    
}

- (IBAction)clickPopMyOrder:(id)sender {
     [self.navigationController popToRootViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kReloadShopTalbeViewController" object:nil userInfo:@{@"selectIndex": @(2)}];
    
}
- (IBAction)clickCan:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
