//
//  WLTestDetailViewController.m
//  MyBoRuiSi
//
//  Created by Magician on 2017/1/6.
//  Copyright © 2017年 itcast.com. All rights reserved.
//

#import "WLTestDetailViewController.h"
#import <Masonry.h>
#import "WLQuetionModel.h"
#import "WLHomeDataHandle.h"
#import "WLFinallyViewController.h"

@interface WLTestDetailViewController ()

@property (nonatomic, strong) UILabel *questionLbl;
@property (nonatomic, strong) UIButton *optionA;
@property (nonatomic, strong) UIButton *optionB;
@property (nonatomic, strong) UIButton *optionC;
@property (nonatomic, strong) UIButton *optionD;

@end

@implementation WLTestDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self configureUI];
    
    [self layout];
    
    [self loadData];
}

- (void)configureUI
{
    [self.view addSubview:self.questionLbl];
    [self.view addSubview:self.optionA];
    [self.view addSubview:self.optionB];
    [self.view addSubview:self.optionC];
    [self.view addSubview:self.optionD];
}

- (void)layout
{
    [self.questionLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view).offset(40);
        make.right.equalTo(self.view).offset(-40);
        make.height.mas_lessThanOrEqualTo(14*4+5);
    }];
    
    [self.optionA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.questionLbl);
        make.height.mas_greaterThanOrEqualTo(45);
        make.top.equalTo(self.questionLbl).offset(200);
    }];
    
    [self.optionB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.optionA.mas_bottom).offset(15);
        make.left.right.height.equalTo(self.optionA);
    }];
    
    [self.optionC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.optionB.mas_bottom).offset(15);
        make.left.right.height.equalTo(self.optionA);
    }];
    
    [self.optionD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.optionC.mas_bottom).offset(15);
        make.left.right.height.equalTo(self.optionA);
    }];
}

- (void)loadData
{
    WLQuetionModel *questionModel = self.questionsArray[_questionIndex];
    NSString *questionStr = questionModel.title;
    questionStr = [questionStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    questionStr = [NSString stringWithFormat:@"%ld.%@",_questionIndex + 1,questionStr];
    self.questionLbl.text = questionStr;
    
    for (int i = 0; i < 4; i ++) {
        
        UIButton *optionBtn = (UIButton *)[self.view viewWithTag:1000 + i];
        if (i < questionModel.xuanze.count) {
            [optionBtn setTitle:[questionModel.xuanze[i] content] forState:UIControlStateNormal];
        }else {
            optionBtn.hidden = YES;
        }
    }
    
//    self.testPaperId = questionModel.tid;
//    [WLHomeDataHandle requestPaperStarTestWithUid:[WLUserInfo share].userId tid:self.testPaperId success:^(id responseObject) {
//        
//        self.testId = responseObject[@"id"];
//    } failure:^(NSError *error) {
//        
//    }];
}

- (UILabel *)questionLbl
{
    if (!_questionLbl) {
        _questionLbl = [[UILabel alloc] init];
        _questionLbl.textColor = COLOR_WORD_BLACK;
        _questionLbl.font = [UIFont systemFontOfSize:14];
        _questionLbl.numberOfLines = 4;
    }
    return _questionLbl;
}

- (UIButton *)optionA
{
    if (!_optionA) {
        _optionA = [UIButton buttonWithType:UIButtonTypeCustom];
        _optionA.backgroundColor = [UIColor whiteColor];
        _optionA.titleLabel.numberOfLines = 3;
        _optionA.titleLabel.font = [UIFont systemFontOfSize:14];
        [_optionA setTitleColor:RGB(146, 30, 59) forState:UIControlStateNormal];
        [_optionA setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
        _optionA.layer.cornerRadius = 3;
        _optionA.layer.borderWidth = 1;
        _optionA.layer.borderColor = RGB(146, 30, 59).CGColor;
        _optionA.tag = 1000;
        [_optionA addTarget:self action:@selector(optionBtnAction:)
           forControlEvents:UIControlEventTouchUpInside];
    }
    return _optionA;
}

- (UIButton *)optionB
{
    if (!_optionB) {
        _optionB = [UIButton buttonWithType:UIButtonTypeCustom];
        _optionB.backgroundColor = [UIColor whiteColor];
        _optionB.titleLabel.numberOfLines = 3;
        _optionB.titleLabel.font = [UIFont systemFontOfSize:14];
        [_optionB setTitleColor:RGB(146, 30, 59) forState:UIControlStateNormal];
        [_optionB setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
        _optionB.layer.cornerRadius = 3;
        _optionB.layer.borderWidth = 1;
        _optionB.layer.borderColor = RGB(146, 30, 59).CGColor;
        _optionB.tag = 1001;
        [_optionB addTarget:self action:@selector(optionBtnAction:)
           forControlEvents:UIControlEventTouchUpInside];
    }
    return _optionB;
}

- (UIButton *)optionC
{
    if (!_optionC) {
        _optionC = [UIButton buttonWithType:UIButtonTypeCustom];
        _optionC.backgroundColor = [UIColor whiteColor];
        _optionC.titleLabel.numberOfLines = 3;
        _optionC.titleLabel.font = [UIFont systemFontOfSize:14];
        [_optionC setTitleColor:RGB(146, 30, 59) forState:UIControlStateNormal];
        [_optionC setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
        _optionC.layer.cornerRadius = 3;
        _optionC.layer.borderWidth = 1;
        _optionC.layer.borderColor = RGB(146, 30, 59).CGColor;
        _optionC.tag = 1002;
        [_optionC addTarget:self action:@selector(optionBtnAction:)
           forControlEvents:UIControlEventTouchUpInside];
    }
    return _optionC;
}

- (UIButton *)optionD
{
    if (!_optionD) {
        _optionD = [UIButton buttonWithType:UIButtonTypeCustom];
        _optionD.backgroundColor = [UIColor whiteColor];
        _optionD.titleLabel.numberOfLines = 3;
        _optionD.titleLabel.font = [UIFont systemFontOfSize:14];
        [_optionD setTitleColor:RGB(146, 30, 59) forState:UIControlStateNormal];
        [_optionD setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
        _optionD.layer.cornerRadius = 3;
        _optionD.layer.borderWidth = 1;
        _optionD.layer.borderColor = RGB(146, 30, 59).CGColor;
        _optionD.tag = 1003;
        [_optionD addTarget:self action:@selector(optionBtnAction:)
           forControlEvents:UIControlEventTouchUpInside];

    }
    return _optionD;
}

- (void)optionBtnAction:(UIButton *)sender
{
    sender.enabled = NO;
    sender.backgroundColor = RGB(146, 30, 59);
    [WLHomeDataHandle requestSubmitAnswerWithId:self.testPaperId aid:self.questionId tid:self.testId uid:[WLUserInfo share].userId answer:sender.titleLabel.text success:^(id responseObject) {
        
        if (self.questionIndex == self.questionsArray.count - 1) {
            
            WLFinallyViewController *finishVC = [[WLFinallyViewController alloc] init];
            finishVC.testId = self.testId;
            [self.navigationController pushViewController:finishVC animated:YES];
            return ;
        }
        WLTestDetailViewController *testVC = [[WLTestDetailViewController alloc] init];
        testVC.title = self.title;
        testVC.questionsArray = self.questionsArray;
        NSInteger index = self.questionIndex + 1;
        testVC.questionIndex = index;
        testVC.questionId = [NSString stringWithFormat:@"%ld",[self.questionId integerValue] + 1];
        testVC.testId = self.testId;
        testVC.testPaperId = self.testPaperId;
        [self.navigationController pushViewController:testVC animated:YES];

    } failure:^(NSError *error) {
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
