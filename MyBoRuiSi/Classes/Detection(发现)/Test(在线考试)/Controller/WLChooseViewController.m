//
//  WLChooseViewController.m
//  MyBoRuiSi
//
//  Created by Magician on 2017/1/8.
//  Copyright © 2017年 itcast.com. All rights reserved.
//

#import "WLChooseViewController.h"
#import "WLExaminationHelper.h"
#import <Masonry.h>

@interface WLChooseViewController ()

@property (nonatomic, strong) UILabel *questionLbl;
@property (nonatomic, strong) UIButton *optionA;
@property (nonatomic, strong) UIButton *optionB;
@property (nonatomic, strong) UIButton *optionC;
@property (nonatomic, strong) UIButton *optionD;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIButton *preBtn;
@property (nonatomic, strong) UIButton *nextBtn;
@property (nonatomic, strong) UILabel *indexLbl;
@property (nonatomic, strong) UIButton *selectBtn;
@end

@implementation WLChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureUI];
    
    [self layout];
    
    [self loadData];
}

- (void)configureUI
{
    [self setNavigationBarStyleDefultWithTitle:@"选择题"];
    
    [self.view addSubview:self.questionLbl];
    [self.view addSubview:self.optionA];
    [self.view addSubview:self.optionB];
    [self.view addSubview:self.optionC];
    [self.view addSubview:self.optionD];
    [self.view addSubview:self.bottomView];
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
        make.height.mas_greaterThanOrEqualTo(50);
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
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
        make.height.mas_equalTo(45);
    }];
}

- (void)loadData
{
    
    NSDictionary *dict = self.questionArray[self.index];
    NSArray *tureAnser = dict[@"ok_answer"];
    NSArray *option = dict[@"answer"];
    NSString *question = dict[@"title"];
    question = [question stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"];
    question = [NSString stringWithFormat:@"%ld.%@", self.index + 1, question];
    self.questionLbl.text = question;
    
    if (self.isShowAnswer) {
        for (int i = 0; i < 4; i++) {
            
            UIButton *optionBtn = (UIButton *)[self.view viewWithTag:1000 + i];
            if (i < option.count) {
                [optionBtn setTitle:option[i] forState:UIControlStateNormal];
                optionBtn.enabled = NO;
                NSString *optionFlag = [optionBtn.titleLabel.text substringToIndex:1];
                if ([optionFlag isEqualToString:tureAnser[0]]) {
                    optionBtn.backgroundColor = kColor_green;
                    [optionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                }
            }else {
                optionBtn.hidden = YES;
            }
        }
    }else {
        
        NSString *answer = [self.examHelper getAnswerByQuestionId:dict[@"id"]];
        
        for (int i = 0; i < 4; i ++) {
            
            UIButton *optionBtn = (UIButton *)[self.view viewWithTag:1000 + i];
            if (i < option.count) {
                [optionBtn setTitle:option[i] forState:UIControlStateNormal];
                if ([optionBtn.titleLabel.text isEqualToString:answer]) {
                    optionBtn.selected = YES;
                    optionBtn.backgroundColor = kColor_button_bg;
                }
                
            }else {
                optionBtn.hidden = YES;
            }
        }
    }

    
    self.indexLbl.text = [NSString stringWithFormat:@"%ld/%ld",self.index + 1,self.questionArray.count];
    if (self.index == self.questionArray.count - 1) {
        self.nextBtn.selected = YES;
    }
    if (self.index == 0) {
        self.preBtn.enabled = NO;
    }
}

- (UILabel *)questionLbl
{
    if (!_questionLbl) {
        _questionLbl = [[UILabel alloc] init];
        _questionLbl.textColor = COLOR_WORD_BLACK;
        _questionLbl.font = [UIFont systemFontOfSize:15];
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
        _optionA.titleLabel.font = [UIFont systemFontOfSize:15];
        [_optionA setTitleColor:COLOR_WORD_BLACK forState:UIControlStateNormal];
        [_optionA setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        _optionA.layer.cornerRadius = 3;
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
        _optionB.titleLabel.font = [UIFont systemFontOfSize:15];
        [_optionB setTitleColor:COLOR_WORD_BLACK forState:UIControlStateNormal];
        [_optionB setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        _optionB.layer.cornerRadius = 3;
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
        _optionC.titleLabel.font = [UIFont systemFontOfSize:15];
        [_optionC setTitleColor:COLOR_WORD_BLACK forState:UIControlStateNormal];
        [_optionC setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        _optionC.layer.cornerRadius = 3;
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
        _optionD.titleLabel.font = [UIFont systemFontOfSize:15];
        [_optionD setTitleColor:COLOR_WORD_BLACK forState:UIControlStateNormal];
        [_optionD setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        _optionD.layer.cornerRadius = 3;
        _optionD.tag = 1003;
        [_optionD addTarget:self action:@selector(optionBtnAction:)
           forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _optionD;
}

- (UIView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = [UIColor whiteColor];
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = COLOR_tableView_separator;
        [_bottomView addSubview:line];
        
        _preBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_preBtn setTitle:@"上一题" forState:UIControlStateNormal];
        [_preBtn setTitleColor:kColor_button_bg forState:UIControlStateNormal];
        [_preBtn setTitleColor:[UIColor blackColor] forState:UIControlStateDisabled];
        _preBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_preBtn addTarget:self action:@selector(preBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:_preBtn];
        
        _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nextBtn setTitle:@"下一题" forState:UIControlStateNormal];
        [_nextBtn setTitle:@"完成" forState:UIControlStateSelected];
        [_nextBtn setTitleColor:kColor_button_bg forState:UIControlStateNormal];
        _nextBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_nextBtn addTarget:self action:@selector(nextBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:_nextBtn];
        
        _indexLbl = [[UILabel alloc] init];
        _indexLbl.textColor = kColor_button_bg;
        _indexLbl.font = [UIFont systemFontOfSize:15];
        _indexLbl.textAlignment = NSTextAlignmentCenter;
        [_bottomView addSubview:_indexLbl];
        
        [_preBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.equalTo(_bottomView);
            make.width.mas_equalTo(70);
        }];
        
        [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.equalTo(_bottomView);
            make.width.equalTo(_preBtn);
        }];
        
        [_indexLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.centerX.equalTo(_bottomView);
            make.width.mas_equalTo(100);
        }];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(_bottomView);
            make.height.mas_equalTo(1);
        }];
    }
    return _bottomView;
}

- (void)preBtnAction:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)nextBtnAction:(UIButton *)sender
{
    UIButton *button = (UIButton *)sender;
    
    if (button.selected) {
        [self.navigationController popToViewController:self.navigationController.childViewControllers[2] animated:YES];
        return;
    }
    
    WLChooseViewController *vc = [[WLChooseViewController alloc] init];
    vc.questionArray = self.questionArray;
    vc.kid = self.kid;
    vc.index = self.index + 1;
    vc.isShowAnswer = self.isShowAnswer;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)optionBtnAction:(UIButton *)sender
{
//    if (sender == self.selectBtn) {
//        return;
//    }

    if (sender != self.selectBtn) {
        self.selectBtn.selected = NO;
        self.selectBtn.backgroundColor = [UIColor whiteColor];
        
        self.selectBtn = sender;
        self.selectBtn.selected = YES;
        self.selectBtn.backgroundColor = kColor_button_bg;
    }
    
    [[WLExaminationHelper sharedInstance] addAnswer:sender.titleLabel.text questionId:self.questionArray[self.index][@"id"] type:@"选择题"];
    
    if (self.nextBtn.selected) {
        [self.navigationController popToViewController:self.navigationController.childViewControllers[2] animated:YES];
        return;
    }
    WLChooseViewController *vc = [[WLChooseViewController alloc] init];
    vc.questionArray = self.questionArray;
    vc.kid = self.kid;
    vc.index = self.index + 1;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
