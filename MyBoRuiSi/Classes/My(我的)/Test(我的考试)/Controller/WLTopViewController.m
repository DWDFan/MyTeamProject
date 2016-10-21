//
//  WLTopViewController.m
//  MyBoRuiSi
//
//  Created by mo on 16/8/8.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLTopViewController.h"
#import "WLOrderPayViewController.h"

#define kMaxAmount        9999999
@interface WLTopViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *moneyTextField;

@property (nonatomic, strong) NSString *changeMoney;
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
    if ([self isValidateMoney:self.moneyTextField.text]) {
        WLOrderPayViewController *vc = [[WLOrderPayViewController alloc]init];
        //转换金额  1  转换成 1.00
        vc.needMoney = [NSString stringWithFormat:@"%@.00",self.moneyTextField.text];
        vc.type = rechargeType;
        [self.navigationController pushViewController:vc animated:YES];

    }else{
        [MOProgressHUD showErrorWithStatus:@"输入金额错误"];
    }
}

//判断金额是否正确
- (BOOL)isValidateMoney:(NSString *)money
{
    NSString *regex = @"^[1-9]\\d*$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:money];
}


@end
