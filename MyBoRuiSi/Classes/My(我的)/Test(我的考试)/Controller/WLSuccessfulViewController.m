//
//  WLSuccessfulViewController.m
//  MyBoRuiSi
//
//  Created by mo on 16/8/6.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLSuccessfulViewController.h"

@interface WLSuccessfulViewController ()

@end

@implementation WLSuccessfulViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
    btn.backgroundColor = [UIColor clearColor];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setImage:[UIImage imageNamed:@"图层-47"] forState:UIControlStateNormal];
    [btn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
    [btn setTitle:@"修改成功" forState:UIControlStateNormal];
    self.navigationItem.titleView = btn;
    
    //设置导航条右边的按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"关闭" style:UIBarButtonItemStyleDone target:self action:@selector(Modify)];
    
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor colorWithRed:164 /255.0 green:30/255.0 blue:59/255.0 alpha:1];
    
//        //uiviewcontroller添加图片
//        UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"2345"]];
//        imageView.frame = CGRectMake((WLScreenW-110)/2,(WLScreenH-110)/3 , 110, 110);
//    
//        [self.view addSubview:imageView];
    
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

- (void)Modify{
    //返回我的钱包首页
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
