//
//  WLPayViewController.m
//  MyBoRuiSi
//
//  Created by mo on 16/8/7.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLPayViewController.h"

#import "WLMyDataHandle.h"
#import "NSString+Util.h"
@interface WLPayViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *pwd_1_textField;
@property (weak, nonatomic) IBOutlet UITextField *pwd_2_textField;

@end

@implementation WLPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super viewDidLoad];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
    btn.backgroundColor = [UIColor clearColor];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setImage:[UIImage imageNamed:@"图层-47"] forState:UIControlStateNormal];
    [btn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
    [btn setTitle:@"设置支付密码" forState:UIControlStateNormal];
    self.navigationItem.titleView = btn;
    
    //设置右边的按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(Modify)];
    
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor colorWithRed:164 /255.0 green:30/255.0 blue:59/255.0 alpha:1];
    
    //request
     [self requestSetPwd];
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
- (BOOL)checkoutPwd{
    [self.view endEditing:YES];
    if(![self.pwd_1_textField.text isEqualToString:self.pwd_2_textField.text]){
        [MOProgressHUD showErrorWithStatus:@"密码不一致"];
    }else if (self.pwd_1_textField.text.length != 6 || self.pwd_2_textField.text.length != 6) {
        [MOProgressHUD showErrorWithStatus:@"请输入6位数密码"];
    } else if (![self.pwd_1_textField.text isNumber] && ![self.pwd_2_textField.text isNumber]){
         [MOProgressHUD showErrorWithStatus:@"请输入6位纯数字密码"];
    }else if (self.pwd_1_textField.text.length == 6 && self.pwd_2_textField.text.length == 6 && [self.pwd_1_textField.text isEqualToString:self.pwd_2_textField.text]){
        return YES;
    }
    return NO;
}
- (void)Modify{
    //request
    if([self checkoutPwd]){
        [self requestSetPwd];
    }
}

#pragma mark - TextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == self.pwd_1_textField) {
        [self.pwd_2_textField becomeFirstResponder];
    }else{
        //request
        if([self checkoutPwd]){
            [self requestSetPwd];
        }
    }
    return YES;
}

#pragma mark - Request
- (void)requestSetPwd{
    [WLMyDataHandle requestSetPwdWithUid:[WLUserInfo share].userId pwd:[self.pwd_1_textField.text md532BitLower] success:^(id responseObject) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        
    }];
}
@end
