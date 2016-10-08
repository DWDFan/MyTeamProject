//
//  WLRegisteringViewController.m
//  MyBoRuiSi
//
//  Created by wsl on 16/8/4.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLRegisteringViewController.h"
#import "WLRegistrationtViewController.h"
#import "WLLoginDataHandle.h"
#import "WLUserInfo.h"

@interface WLRegisteringViewController ()
//手机号
@property (weak, nonatomic) IBOutlet UITextField *phone;

//验证码
@property (weak, nonatomic) IBOutlet UITextField *code;
@property (weak, nonatomic) IBOutlet UIButton *verify_btn;

@property (strong, nonatomic) NSTimer *timer;//定时器
@property (assign, nonatomic) int secondsCountDown;//计数标识

@end

@implementation WLRegisteringViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
    btn.backgroundColor = [UIColor clearColor];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setImage:[UIImage imageNamed:@"图层-47"] forState:UIControlStateNormal];
    [btn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
    [btn setTitle:@"登录" forState:UIControlStateNormal];
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

//获取验证码
- (IBAction)Hqubutton:(id)sender {
    if (self.phone.text.length == 0  || self.phone.text.length > 11 ) {
         [MOProgressHUD showErrorWithStatus:@"请输入正确手机号码"];
    }else{
        //倒计时
        [self countDown];
        [WLLoginDataHandle requestTelCodeWithTelphone:self.phone.text success:^(id responseObject) {
            
            NSDictionary *dic = responseObject;
            
            WLLog(@"%@",dic);
            if ([dic[@"code"]integerValue] == 1) {
                
                [MOProgressHUD showSuccessWithStatus:@"验证码已经发到你手机,请留意你的手机"];
//                self.code.text = dic[@"json"];
            }else{
                [MOProgressHUD showErrorWithStatus:dic[@"msg"]];
            }
        } failure:^(NSError *error) {
            
        }];
    }
}

//登录按钮
- (IBAction)DuLbutton:(id)sender {
    
    if (self.phone.text.length == 0 ||self.code.text.length == 0) {
        
        [MOProgressHUD showErrorWithStatus:@"手机号码或者验证码不正确"];
        
    }else{
        
        [MOProgressHUD  showWithStatus:@"正在登录..."];
        
        [WLLoginDataHandle requestLoginWithTelphone:self.phone.text code:self.code.text success:^(id responseObject) {
            NSDictionary *dict = responseObject;
            NSLog(@"%@",responseObject);
           
            if ([dict[@"code"]integerValue] == 1) {
                
                
                [MOProgressHUD dismiss];
              
                //归档
                [[WLUserInfo share] archivWithDict:dict];
                
                //通知刷新登录状态
                [[NSNotificationCenter defaultCenter] postNotificationName:@"changeLoginStatus" object:nil];
                [self.navigationController popToRootViewControllerAnimated:YES];
                
            }else {
                [MOProgressHUD showErrorWithStatus:dict[@"msg"]];
                 [MOProgressHUD dismissWithDelay:1];
            }

        } failure:^(NSError *error) {
            [MOProgressHUD showErrorWithStatus:@"登录失败"];
            [MOProgressHUD dismissWithDelay:1];
        }];
    }
}
//注册按钮
- (IBAction)Zcbutton:(id)sender {
    
    WLRegistrationtViewController *reg = [[WLRegistrationtViewController alloc]init];
    [self.navigationController pushViewController:reg animated:YES];
}

#pragma mark - Private Method
-(void)countDown
{
    self.verify_btn.enabled = NO;
    [self.code becomeFirstResponder];
    
    self.secondsCountDown = 60;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
}

//secondsCountDown = 60;//60秒倒计时
//定时器方法
-(void)timeFireMethod
{
    self.secondsCountDown--;
    
    if(self.secondsCountDown <= 0){
        [self.timer invalidate];
        self.timer = nil;
        
        [self.verify_btn setEnabled:YES];
        [self.verify_btn setTitle:@"重新获取" forState:UIControlStateNormal];
        
    }else{
        [self.verify_btn setTitle:[NSString stringWithFormat:@"%2dS",self.secondsCountDown] forState:UIControlStateNormal];
    }
}
@end
