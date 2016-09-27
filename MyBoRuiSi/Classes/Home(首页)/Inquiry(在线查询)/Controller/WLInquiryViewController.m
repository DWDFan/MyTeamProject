//
//  WLInquiryViewController.m
//  MyBoRuiSi
//
//  Created by wsl on 16/8/1.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLInquiryViewController.h"
#import "WLFinallysViewController.h"
#import "WLHomeDataHandle.h"

@interface WLInquiryViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UIButton *commitBtn;

@end

@implementation WLInquiryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
    btn.backgroundColor = [UIColor clearColor];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setImage:[UIImage imageNamed:@"图层-47"] forState:UIControlStateNormal];
    [btn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
    [btn setTitle:@"证书查询" forState:UIControlStateNormal];
    self.navigationItem.titleView = btn;
    
    [self.navigationController.navigationBar setBackgroundImage:[MOTool createImageWithColor:RGBA(255, 255, 255, 1)] forBarMetrics:UIBarMetricsDefault];
    
    UIButton *commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    commitBtn.frame = CGRectMake(0, WLScreenH - 50 - 64, WLScreenW, 50);
    commitBtn.backgroundColor = [UIColor grayColor];
    [commitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    commitBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [commitBtn addTarget:self action:@selector(commitBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    commitBtn.enabled = NO;
    [self.view addSubview:commitBtn];
    _commitBtn = commitBtn;
}

- (IBAction)buttonimage:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        
        self.btnT.selected = NO;
        
    }
}
- (IBAction)buttonimagetow:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        
        self.btnO.selected = NO;

    }
}

- (void)commitBtnAction:(UIButton *)sender
{
    [WLHomeDataHandle requestQueryCertificateWithUid:[WLUserInfo share].userId name:_nameTF.text card_id:_idTF.text zs_num:_certificateIdTF.text success:^(id responseObject) {
        
        if (responseObject[@"data"]) {
            WLFinallysViewController *vc = [[WLFinallysViewController alloc] init];
            
            vc.dataDict = @{@"type":@"EDS高级工程师", @"name":@"李四", @"birthday":@"1990-10-1", @"xueli":@"烟酒生", @"px_time":@"2000-1-1"};
            
            [self.navigationController pushViewController:vc animated:YES];
        }else {
            [MOProgressHUD showErrorWithStatus:@"查询不到证书信息,请检查输入信息是否正确."];
        }
       
    } failure:^(NSError *error) {
        [MOProgressHUD showErrorWithStatus:@"查询不到证书信息,请检查输入信息是否正确."];
    }];
}

#pragma mark - textFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (_nameTF.text.length > 0 && (_idTF.text.length > 0 || _certificateIdTF.text.length > 0)) {
        _commitBtn.enabled = YES;
        _commitBtn.backgroundColor = color_red;
    }else {
        _commitBtn.enabled = NO;
        _commitBtn.backgroundColor = [UIColor grayColor];
    }
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
