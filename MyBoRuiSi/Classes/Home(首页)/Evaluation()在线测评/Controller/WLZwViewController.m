//
//  WLZwViewController.m
//  MyBoRuiSi
//
//  Created by wsl on 16/8/5.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLZwViewController.h"
#import "WLFinallyViewController.h"

@interface WLZwViewController ()

@end

@implementation WLZwViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
    btn.backgroundColor = [UIColor clearColor];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setImage:[UIImage imageNamed:@"图层-47"] forState:UIControlStateNormal];
    [btn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
    [btn setTitle:@"自我测评" forState:UIControlStateNormal];
    self.navigationItem.titleView = btn;
    
    
    
    [self.navigationController.navigationBar setBackgroundImage:[self createImageWithColor:RGBA(255, 255, 255, 1)] forBarMetrics:UIBarMetricsDefault];
    
    
}
//颜色转图片
- (UIImage*) createImageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage*theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    return theImage;
}
//会
- (IBAction)Cantbutton:(id)sender {
    WLFinallyViewController *finall = [[WLFinallyViewController alloc]init];
    [self.navigationController pushViewController:finall animated:YES];
}
//不会
- (IBAction)dontClik:(id)sender {
    
    WLFinallyViewController *finall = [[WLFinallyViewController alloc]init];
    [self.navigationController pushViewController:finall animated:YES];

}
//不清楚
- (IBAction)qIchClik:(id)sender {
    
    WLFinallyViewController *finall = [[WLFinallyViewController alloc]init];
    [self.navigationController pushViewController:finall animated:YES];

}

@end
