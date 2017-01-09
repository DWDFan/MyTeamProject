//
//  WLRegistrationtViewController.m
//  MyBoRuiSi
//
//  Created by wsl on 16/8/4.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLRegistrationtViewController.h"

#import "WLConsummationViewController.h"
#import "WLProtocolViewController.h"
#import "WLLoginDataHandle.h"

@interface WLRegistrationtViewController ()

@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *message;
@property (weak, nonatomic) IBOutlet UITextField *yaoqingma;
@property (weak, nonatomic) IBOutlet UIButton *verify_btn;

@property (strong, nonatomic) NSTimer *timer;//定时器
@property (assign, nonatomic) int secondsCountDown;//计数标识
@end

@implementation WLRegistrationtViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
    btn.backgroundColor = [UIColor clearColor];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setImage:[UIImage imageNamed:@"图层-47"] forState:UIControlStateNormal];
    [btn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
    [btn setTitle:@"注册" forState:UIControlStateNormal];
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
#pragma mark - Private Method
-(void)countDown
{
    self.verify_btn.enabled = NO;
    [self.message becomeFirstResponder];
    
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
//用户协议
- (IBAction)Xybutton:(id)sender {
    
    
    WLProtocolViewController *protocol = [[WLProtocolViewController alloc]init];
    [self.navigationController pushViewController:protocol animated:YES];
}

//获取验证码
- (IBAction)Hqbutton:(id)sender {
    
    
    if (self.phone.text.length == 0) {
        
        [MOProgressHUD showErrorWithStatus:@"请输入手机号码"];
        
    }else if (self.phone.text.length > 11){
        
        [MOProgressHUD showErrorWithStatus:@"请输入正确的手机号码"];
        
    }else {
        [self countDown];
        [WLLoginDataHandle requestTelCodeWithTelphone:self.phone.text success:^(id responseObject) {
            
        } failure:^(NSError *error) {
            [self.timer invalidate];
            self.timer = nil;
            
            [self.verify_btn setEnabled:YES];
            [self.verify_btn setTitle:@"重新获取" forState:UIControlStateNormal];

        }];
    }
}


- (IBAction)wchnegclik:(id)sender {
    
    //||  self.yaoqingma.text.length == 0
    if (self.phone.text.length == 0 || self.message.text.length == 0 ) {
        
        [MOProgressHUD showErrorWithStatus:@"请完善你的信息"];
        
    }else{
        
        [MOProgressHUD showWithStatus:@""];
    
        [WLLoginDataHandle requestRegisterWithTelphone:self.phone.text code:self.message.text yqcode:self.yaoqingma.text success:^(id responseObject) {
            
            NSDictionary *dic = responseObject;
            
            if ([dic[@"code"]integerValue ] == 1) {
                
                [MOProgressHUD showSuccessWithStatus:@"注册成功"];
                //归档
                [[WLUserInfo share] archivWithDict:dic];

                
                UIStoryboard *stroryboard = [UIStoryboard storyboardWithName:@"WLConsummationViewController" bundle:nil];
                WLConsummationViewController *vc = [stroryboard instantiateInitialViewController];
                vc.id = dic[@"id"];
                vc.hidesBottomBarWhenPushed = YES;//隐藏tabbar
                [self.navigationController pushViewController:vc animated:YES];
                
            }else{
                [MOProgressHUD showErrorWithStatus:dic[@"msg"]];
                
                [MOProgressHUD dismissWithDelay:1];
            }
            
        } failure:^(NSError *error) {
            [MOProgressHUD showErrorWithStatus:error.userInfo[@"msg"]];

        }];
//          __weak typeof(self) weakSelf = self;
//        [MOHTTP Post:@"API/index.php?action=Login&do=Reg" parameters:@{@"telphone":self.phone.text,@"code":self.message.text, @"yqcode":self.yaoqingma.text} success:^(id responseObject) {
//            
//            NSDictionary *dic = responseObject;
//            if ([dic[@"code"]integerValue ] == 1) {
//                [MOProgressHUD showSuccessWithStatus:@"注册成功"];
//                
//                [MOProgressHUD dismiss];
//    
//                
//                UIStoryboard *stroryboard = [UIStoryboard storyboardWithName:@"WLConsummationViewController" bundle:nil];
//                WLConsummationViewController *vc = [stroryboard instantiateInitialViewController];
//                vc.id = dic[@"id"];
//                vc.hidesBottomBarWhenPushed = YES;//隐藏tabbar
//                [weakSelf.navigationController pushViewController:vc animated:YES];
//          
//            }else{
//                
//             
//                [MOProgressHUD showErrorWithStatus:dic[@"msg"]];
//               
//                [MOProgressHUD dismiss];
//            }
//            
//        } failure:^(NSError *error) {
//            
//        }];
    }
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
