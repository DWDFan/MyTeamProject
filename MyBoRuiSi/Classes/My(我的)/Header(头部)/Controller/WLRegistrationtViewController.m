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
        
        [WLLoginDataHandle requestTelCodeWithTelphone:self.phone.text success:^(id responseObject) {
            
            NSDictionary *dic = responseObject ;
            
            if ([dic[@"code"] integerValue]  == 1) {
                
                [MOProgressHUD showErrorWithStatus:@"验证码已经发到你手机,请留意你的手机"];
                
//                self.message.text = dic[@"json"];
                
            }else{
                
                [MOProgressHUD showErrorWithStatus:dic[@"msg"]];
            }

        } failure:^(NSError *error) {
            
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
                
                [MOProgressHUD dismiss];
                
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
