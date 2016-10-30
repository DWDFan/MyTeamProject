//
//  WLModifyViewController.m
//  MyBoRuiSi
//
//  Created by mo on 16/8/6.
//  Copyright © 2016年 itcast.com. All rights reserved.
//
#import "WLModifyViewController.h"
#import "WLSuccessfulViewController.h"

#import "WLMyDataHandle.h"
#import "NSString+Util.h"
#import "WLNoCopyTextField.h"

@interface WLModifyViewController ()
@property (weak, nonatomic) IBOutlet WLNoCopyTextField *old_TextField;
@property (weak, nonatomic) IBOutlet WLNoCopyTextField *pwd_1_TextField;
@property (weak, nonatomic) IBOutlet WLNoCopyTextField *pwd_2_TextField;
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

#pragma mark - Private Method
- (BOOL)checkoutPwd{
    
    if(![self.pwd_1_TextField.text isEqualToString:self.pwd_2_TextField.text]){
        [MOProgressHUD showErrorWithStatus:@"密码不一致"];
    }else if (self.pwd_1_TextField.text.length != 6 || self.pwd_2_TextField.text.length != 6) {
        [MOProgressHUD showErrorWithStatus:@"请输入6位数密码"];
    } else if (self.pwd_1_TextField.text.length == 6 && self.pwd_2_TextField.text.length == 6 && [self.pwd_1_TextField.text isEqualToString:self.pwd_2_TextField.text]){
        return YES;
    }
    return NO;
}
- (void)Modify{
    //request
    if([self checkoutPwd]){
        [self requestUpdatePwd];
    }
}

#pragma mark - TextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == self.pwd_1_TextField) {
        [self.pwd_2_TextField becomeFirstResponder];
    }else{
        //request
        if([self checkoutPwd]){
            [self requestUpdatePwd];
        }
    }
    return YES;
}

#pragma mark - Request
- (void)requestUpdatePwd{
    [self.view endEditing:YES];
    [WLMyDataHandle requestUpdatePwdWithUid:[WLUserInfo share].userId oldpwd:[self.old_TextField.text md532BitLower] pwd:[self.pwd_1_TextField.text md532BitLower] success:^(id responseObject) {
        WLSuccessfulViewController *SuccessfulVC = [[WLSuccessfulViewController alloc]init];
        [self.navigationController pushViewController:SuccessfulVC animated:YES];
    } failure:^(NSError *error) {
        
    }];
}



@end
