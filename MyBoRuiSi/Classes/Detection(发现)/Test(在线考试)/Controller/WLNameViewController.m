//
//  WLNameViewController.m
//  MyBoRuiSi
//
//  Created by wsl on 16/8/5.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLNameViewController.h"
#import "WLnameTableViewCell.h"

#import "WLfillingViewController.h"
#import "WLChoiceViewController.h"
#import "WLChooseViewController.h"
#import "WLJudgmentsViewController.h"
#import "WLQuestionViewController.h"
#import "WLExaminationHelper.h"
#import "WLHomeDataHandle.h"
#import "WLSubmitSureView.h"

@interface WLNameViewController ()<UIAlertViewDelegate>

@property (nonatomic,strong)UIView *view_main;
@property (nonatomic,strong)UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UITableView *tableviewt;
@property (nonatomic, strong) NSArray *typeArray;

@end

@implementation WLNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
    btn.backgroundColor = [UIColor clearColor];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setImage:[UIImage imageNamed:@"图层-47"] forState:UIControlStateNormal];
    [btn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
    [btn setTitle:self.title forState:UIControlStateNormal];
    self.navigationItem.titleView = btn;
    
    [self.navigationController.navigationBar setBackgroundImage:[MOTool createImageWithColor:RGBA(255, 255, 255, 1)] forBarMetrics:UIBarMetricsDefault];
    
    UIView *view = [UIView new];
    self.tableviewt.tableFooterView = view;
    
    [self requestData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar addSubview:self.timeBtn];
    
    if (self.examHelper.isAnswer) {
        [self.tableviewt reloadData];
        
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(0, 0, WLScreenW, 200);
        UIButton *subbmitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        subbmitBtn.frame = CGRectMake(100, 120, WLScreenW - 200, 50);
        [subbmitBtn setTitle:@"提交试卷" forState:UIControlStateNormal];
        [subbmitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [subbmitBtn setBackgroundColor:kColor_button_bg];
        [subbmitBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        subbmitBtn.layer.cornerRadius = 5;
        subbmitBtn.layer.masksToBounds = YES;
        [subbmitBtn addTarget:self action:@selector(submitBtnAcion:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:subbmitBtn];
        self.tableviewt.tableFooterView = view;
    }
}

#pragma mark - 退出考试
- (void)leftBtnAction:(UIButton *)sender
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您的考试尚未完成，是否退出本次考试？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"退出考试", nil];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [super alertView:alertView didDismissWithButtonIndex:buttonIndex];
    if (buttonIndex == 1) {
        [self.timeBtn removeFromSuperview];
        [self.examHelper resetExaminationData];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - 数据请求
- (void)requestData
{    
    [WLHomeDataHandle requestExaminationTypeWithUid:[WLUserInfo share].userId kid:self.kid success:^(id responseObject) {
        
        self.typeArray = responseObject[@"data"];
        [self.tableviewt reloadData];
    } failure:^(NSError *error) {
        
    }];
}

- (void)submitBtnAcion:(UIButton *)sender
{
    WLSubmitSureView *sureView = [[WLSubmitSureView alloc] init];
    
    [sureView showWithBlock:^(NSInteger index) {
        [self.examHelper commitAnswerCompletion:^{
            [self.timeBtn removeFromSuperview];
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.typeArray.count;
}


//cell高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *deteID = @"WLnameTableViewCell";
    
    WLnameTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:deteID];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:deteID owner:nil options:nil] lastObject];
    }
    NSString *type = self.typeArray[indexPath.row][@"type"];
    NSInteger finishCount = 0;
    cell.labelone.text = type;
    
    if ([type isEqualToString:@"选择题"]) {
        finishCount = [[WLExaminationHelper sharedInstance] chooseCount];
    }else if ([type isEqualToString:@"填空题"]) {
        finishCount = [[WLExaminationHelper sharedInstance] fillCount];
    }else if ([type isEqualToString:@"判断题"]) {
        finishCount = [[WLExaminationHelper sharedInstance] judgeCount];
    }else if ([type isEqualToString:@"问答题"]) {
        finishCount = [[WLExaminationHelper sharedInstance] essayCount];
    }
    
    cell.labeltwo.text = [NSString stringWithFormat:@"完成度%ld/%@",finishCount,self.typeArray[indexPath.row][@"num"]];
    return cell;
}


#pragma mark 点击tableViewcell

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NSString *type = self.typeArray[indexPath.row][@"type"];
    if ([type isEqualToString:@"填空题"]) {
        
        [WLHomeDataHandle requestExaminationContentWithUid:[WLUserInfo share].userId kid:_kid type:@"填空题" success:^(id responseObject) {
            
            WLfillingViewController *fillVC = [[WLfillingViewController alloc] init];
            fillVC.questionArray = responseObject[@"data"];
            fillVC.kid = self.kid;
            fillVC.index = 0;
            [self.navigationController pushViewController:fillVC animated:YES];
            
        } failure:^(NSError *error) {
            
        }];
    }else if ([type isEqualToString:@"判断题"]) {
        
        [WLHomeDataHandle requestExaminationContentWithUid:[WLUserInfo share].userId kid:_kid type:@"判断题" success:^(id responseObject) {
            
            WLJudgmentsViewController *fillVC = [[WLJudgmentsViewController alloc] init];
            fillVC.questionArray = responseObject[@"data"];
            fillVC.kid = self.kid;
            fillVC.index = 0;
            [self.navigationController pushViewController:fillVC animated:YES];
            
        } failure:^(NSError *error) {
            
        }];
    }else if ([type isEqualToString:@"选择题"]) {
        
        [WLHomeDataHandle requestExaminationContentWithUid:[WLUserInfo share].userId kid:_kid type:@"选择题" success:^(id responseObject) {
            
            WLChooseViewController *vc = [[WLChooseViewController alloc] init];
            vc.questionArray = responseObject[@"data"];
            vc.kid = self.kid;
            vc.index = 0;
            [self.navigationController pushViewController:vc animated:YES];
            
        } failure:^(NSError *error) {
            
        }];
    }
    
}




@end
