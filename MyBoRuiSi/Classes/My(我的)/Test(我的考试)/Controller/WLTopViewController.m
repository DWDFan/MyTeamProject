//
//  WLTopViewController.m
//  MyBoRuiSi
//
//  Created by mo on 16/8/8.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLTopViewController.h"
#import "WLAddOrderViewController.h"

@interface WLTopViewController ()

@end

@implementation WLTopViewController

- (void)viewDidLoad {
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
    btn.backgroundColor = [UIColor clearColor];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setImage:[UIImage imageNamed:@"图层-47"] forState:UIControlStateNormal];
    [btn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
    [btn setTitle:@"充值" forState:UIControlStateNormal];
    self.navigationItem.titleView = btn;
    
    
    //    [MOTool createImageWithColor:]
    [self.navigationController.navigationBar setBackgroundImage:[MOTool createImageWithColor:RGBA(255, 255, 255, 1)] forBarMetrics:UIBarMetricsDefault];
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
- (IBAction)nextstepbtn:(id)sender {
    WLAddOrderViewController *top = [[WLAddOrderViewController alloc]init];
    [self.navigationController pushViewController:top animated:YES];
}

@end
