//
//  WLModifyViewController.m
//  MyBoRuiSi
//
//  Created by mo on 16/8/6.
//  Copyright © 2016年 itcast.com. All rights reserved.
//
#import "WLModifyViewController.h"
#import "WLSuccessfulViewController.h"
@interface WLModifyViewController ()

@end

@implementation WLModifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    

    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
    btn.backgroundColor = [UIColor clearColor];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setImage:[UIImage imageNamed:@"图层-47"] forState:UIControlStateNormal];
    [btn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
    [btn setTitle:@"修改支付密码" forState:UIControlStateNormal];
    self.navigationItem.titleView = btn;
    
    //设置右边的按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(Modify)];
    
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor colorWithRed:164 /255.0 green:30/255.0 blue:59/255.0 alpha:1];

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

- (void)Modify{//跳转到下一界面
    WLSuccessfulViewController *SuccessfulVC = [[WLSuccessfulViewController alloc]init];
    [self.navigationController pushViewController:SuccessfulVC animated:YES];
//    //返回我的钱包首页
//    [self.navigationController popViewControllerAnimated:YES];
}


@end
