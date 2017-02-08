//
//  WLEssayViewController.m
//  MyBoRuiSi
//
//  Created by Magician on 2017/1/10.
//  Copyright © 2017年 itcast.com. All rights reserved.
//

#import "WLEssayViewController.h"
#import "UIPlaceHolderTextView.h"
#import <Masonry.h>

@interface WLEssayViewController ()<UITextViewDelegate>

@property (nonatomic, strong) UILabel *questionLbl;
@property (nonatomic, strong) UIPlaceHolderTextView *answerTV;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIButton *preBtn;
@property (nonatomic, strong) UIButton *nextBtn;
@property (nonatomic, strong) UILabel *indexLbl;

@end

@implementation WLEssayViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self configureUI];
    
    [self loadData];
}

- (void)configureUI
{
    [self setNavigationBarStyleDefultWithTitle:@"问答题"];
    
    
    UIView *labelBack = [[UIView alloc] init];
    labelBack.backgroundColor = RGB(243, 244, 246);
    [self.view addSubview:labelBack];
    
    self.questionLbl = [[UILabel alloc] init];
    self.questionLbl.textColor = COLOR_WORD_BLACK;
    self.questionLbl.font = [UIFont systemFontOfSize:15];
    self.questionLbl.numberOfLines = 0;
    [labelBack addSubview:self.questionLbl];
    
    UIView *textViewBack = [[UIView alloc] init];
    textViewBack.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:textViewBack];
    
    self.answerTV = [[UIPlaceHolderTextView alloc] init];
    self.answerTV.font = [UIFont systemFontOfSize:15];
    self.answerTV.textColor = COLOR_WORD_BLACK;
    self.answerTV.placeholder = @"请输入";
    self.answerTV.delegate = self;
    [textViewBack addSubview:self.answerTV];
    
    [self.view addSubview:self.bottomView];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.height.mas_equalTo(49);
    }];
    
    [labelBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(WLScreenH * 0.3);
    }];
    
    [self.questionLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(labelBack).offset(40);
        make.right.equalTo(labelBack).offset(-40);
        make.top.equalTo(labelBack).offset(40);
        make.height.mas_lessThanOrEqualTo(WLScreenH * 0.3 - 40);
    }];
    
    [textViewBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(labelBack.mas_bottom);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
    
    [self.answerTV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(textViewBack);
        make.left.right.equalTo(textViewBack).insets(UIEdgeInsetsMake(0, 15, 0, 15));
    }];
}

- (void)loadData
{
    NSDictionary *dict = self.questionArray[self.index];
    NSString *question = dict[@"title"];
    NSArray *tureAnser = dict[@"ok_answer"];
    question = [question stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    question = [NSString stringWithFormat:@"%ld.%@", self.index + 1, question];
    self.questionLbl.text = question;
    
    
    if (self.isShowAnswer) {
        self.answerTV.text = tureAnser[0];
        self.answerTV.userInteractionEnabled = NO;
        self.answerTV.textColor = kColor_green;
    }else {
        NSString *answer = [self.examHelper getAnswerByQuestionId:dict[@"id"]];
        self.answerTV.text = answer;
    }
    
    self.indexLbl.text = [NSString stringWithFormat:@"%ld/%ld",self.index + 1,self.questionArray.count];
    if (self.index == self.questionArray.count - 1) {
        self.nextBtn.selected = YES;
    }
    if (self.index == 0) {
        self.preBtn.enabled = NO;
    }
}


- (UIView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.frame = CGRectMake(0, WLScreenH - 49, WLScreenW, 49);
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
    if (button.selected) {  // 没有下一题，返回题型列表
        [self.navigationController popToViewController:self.navigationController.childViewControllers[2] animated:YES];
        return;
    }
    
    // 进入下一题
    WLEssayViewController *vc = [[WLEssayViewController alloc] init];
    vc.questionArray = self.questionArray;
    vc.kid = self.kid;
    vc.index = self.index + 1;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (self.answerTV.text.length != 0) {     // 有输入，保存答案
        [[WLExaminationHelper sharedInstance] addAnswer:self.answerTV.text questionId:self.questionArray[self.index][@"id"] type:@"问答题"];
    }
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
