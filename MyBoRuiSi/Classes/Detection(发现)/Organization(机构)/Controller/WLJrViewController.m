//
//  WLJrViewController.m
//  MyBoRuiSi
//
//  Created by wsl on 16/8/4.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLJrViewController.h"

#import "WLTjViewController.h"
#import "WLHomeDataHandle.h"

@interface WLJrViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *telTF;
@property (weak, nonatomic) IBOutlet UITextField *departTF;
@property (weak, nonatomic) IBOutlet UIView *containView;

//@property (assign, nonatomic) BOOL isNeedUp;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomContain;

@end

@implementation WLJrViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bgView.backgroundColor = RGBA(0, 0, 0, 0.15);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    self.isNeedUp = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//取消按钮
- (IBAction)QxbtnaClik:(id)sender {
    
     [self dismissViewControllerAnimated:YES completion:nil];
}
//提交按钮
- (IBAction)QdbtnClike:(id)sender {
    
    if (_nameTF.text.length == 0) {
        [MOProgressHUD showErrorWithStatus:@"请输入名字!"];
    }else if (_telTF.text.length < 11) {
        [MOProgressHUD showErrorWithStatus:@"手机号有误!"];
    }else if (_departTF.text.length == 0) {
        [MOProgressHUD showErrorWithStatus:@"请输入部门!"];
    }else {
        [WLHomeDataHandle requestInstitutionJoinWithUid:[WLUserInfo share].userId
                                                    jid:_institutionId
                                                   name:_nameTF.text
                                               telphone:_telTF.text
                                                 depart:_departTF.text
                                                success:^(id responseObject) {
                                                    
                                                    WLTjViewController *share = [[WLTjViewController alloc]init];
                                                    share.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                                                    [self presentViewController:share animated:YES completion:^{
                                                    }];

                                                    
                                                } failure:^(NSError *error) {
                                                    [self dismissViewControllerAnimated:YES completion:nil];
                                                    [MOProgressHUD showErrorWithStatus:error.userInfo[@"msg"]];
                                                }];
    }
    
}

//点击屏幕退出
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)keyboardShow:(NSNotification *)notification
{
    [UIView animateWithDuration:0.3 animations:^{
        _bottomContain.constant = 220;
    }];
}

- (void)keyboardHide:(NSNotification *)notification
{
    [UIView animateWithDuration:0.3 animations:^{
        _bottomContain.constant = 0;
    }];
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
