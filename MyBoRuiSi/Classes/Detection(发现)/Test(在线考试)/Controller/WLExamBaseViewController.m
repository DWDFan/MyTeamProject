//
//  WLExamBaseViewController.m
//  MyBoRuiSi
//
//  Created by Magician on 2017/1/9.
//  Copyright © 2017年 itcast.com. All rights reserved.
//

#import "WLExamBaseViewController.h"

@interface WLExamBaseViewController ()

@property (nonatomic, strong) UIAlertView *alertView; 

@end

@implementation WLExamBaseViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(examinationEnd:) name:@"examinationEnd" object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"examinationEnd" object:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = RGB(243, 244, 246);

    self.examHelper = [WLExaminationHelper sharedInstance];
    
    [self.leftBtn setImage:[UIImage imageNamed:@"素彩网www.sc115.com-139"] forState:UIControlStateNormal];
    
    self.timeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.timeBtn.frame = CGRectMake(WLScreenW - 80, 0, 70, 40);
    [self.timeBtn setTitleColor:kColor_button_bg forState:UIControlStateNormal];
    self.timeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    self.timeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.timeBtn setImage:[UIImage imageNamed:@"素彩网www.sc115.com-219-拷贝-2"] forState:UIControlStateNormal];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [self.timeBtn setTitle:self.examHelper.timelongStr forState:UIControlStateNormal];
    }];
}

- (void)examinationEnd:(NSNotification *)noti
{
    self.alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"考试时间到，感谢您的参与。" delegate:self cancelButtonTitle:@"提交试卷" otherButtonTitles:nil, nil];
    [self.alertView show];
}

// 提交试卷
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView == self.alertView) {
        [self.examHelper commitAnswerCompletion:^{
            [self.timeBtn removeFromSuperview];
            [self.navigationController popToViewController:self.navigationController.childViewControllers[1]
                                                  animated:YES];
        }];
    }
}

@end
