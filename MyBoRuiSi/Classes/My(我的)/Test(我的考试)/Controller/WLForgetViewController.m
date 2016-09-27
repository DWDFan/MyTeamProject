
//
//  WLForgetViewController.m
//  MyBoRuiSi
//
//  Created by mo on 16/8/6.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLForgetViewController.h"
#import "WLPayViewController.h"

@interface WLForgetViewController ()

@end

@implementation WLForgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
    btn.backgroundColor = [UIColor clearColor];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setImage:[UIImage imageNamed:@"图层-47"] forState:UIControlStateNormal];
    [btn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
    [btn setTitle:@"验证身份" forState:UIControlStateNormal];
    self.navigationItem.titleView = btn;
    
    //设置右边的按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"下一步" style:UIBarButtonItemStyleDone target:self action:@selector(Forget)];
    
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor colorWithRed:164 /255.0 green:30/255.0 blue:59/255.0 alpha:1];
    
//    //uiviewcontroller添加图片
//    UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tick"]];
//    imageView.frame = CGRectMake((WLScreenW-110)/2,(WLScreenH-110)/3 , 110, 110);
//    
//    [self.view addSubview:imageView];
    
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


- (void)Forget{
    //跳转下一页面
    WLPayViewController *Pay = [[WLPayViewController alloc]init];
    [self.navigationController pushViewController:Pay animated:YES];
}


@end
