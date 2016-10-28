
//
//  WLForgetViewController.m
//  MyBoRuiSi
//
//  Created by mo on 16/8/6.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLForgetViewController.h"
#import "WLPayViewController.h"

#import "WLLoginDataHandle.h"
@interface WLForgetViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UIButton *verify_btn;
@property (weak, nonatomic) IBOutlet UITextField *verifyCode_textField;

@property (strong, nonatomic) NSTimer *timer;//定时器
@property (assign, nonatomic) int secondsCountDown;//计数标识

@property (nonatomic, copy) NSString *verifyCode;//服务器的返回验证码
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

#pragma mark - Private Method
-(void)countDown
{
    self.verify_btn.enabled = NO;
    [self.verifyCode_textField becomeFirstResponder];
    
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
#pragma mark - Event Response
- (IBAction)getVerifyCodeAction:(UIButton *)sender {
    if (self.phone.text.length == 0) {
        
        [MOProgressHUD showErrorWithStatus:@"请输入手机号码"];
        
    }else if (self.phone.text.length > 11){
        
        [MOProgressHUD showErrorWithStatus:@"请输入正确的手机号码"];
        
    }else {
        [self countDown];
        [WLLoginDataHandle requestTelCodeWithTelphone:self.phone.text success:^(id responseObject) {
            _verifyCode = [NSString stringWithFormat:@"%@",responseObject];
        } failure:^(NSError *error) {
            [self.timer invalidate];
            self.timer = nil;
            
            [self.verify_btn setEnabled:YES];
            [self.verify_btn setTitle:@"重新获取" forState:UIControlStateNormal];
            
        }];
    }
}

- (void)Forget{
    if ([self.verifyCode isEqualToString:self.verifyCode_textField.text] && self.verifyCode.length != 0) {
        //跳转下一页面
        WLPayViewController *Pay = [[WLPayViewController alloc]init];
        Pay.phone = self.phone.text;
        Pay.code = self.verifyCode_textField.text;
        Pay.type = WLSetupPwpTypeForget;
        [self.navigationController pushViewController:Pay animated:YES];
    }else{
         [MOProgressHUD showErrorWithStatus:@"输入验证码不正确"];
    }
    
}


@end
