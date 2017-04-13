//
//  WLAnswerViewController.m
//  MyBoRuiSi
//
//  Created by Magician on 2017/1/10.
//  Copyright © 2017年 itcast.com. All rights reserved.
//

#import "WLAnswerViewController.h"
#import "WLChooseViewController.h"
#import "WLfillingViewController.h"
#import "WLJudgmentsViewController.h"
#import "WLEssayViewController.h"
#import "WLHomeDataHandle.h"

@interface WLAnswerViewController ()

@end

@implementation WLAnswerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self configureUI];
    
    [self requestData];
}

- (void)configureUI
{
    [self setNavigationBarStyleDefultWithTitle:@"考试答案"];
    self.tableView.rowHeight = 50;
    self.tableView.backgroundColor = kColor_backgroud;
    
}

- (void)requestData
{
    [WLHomeDataHandle requestExaminationTypeWithUid:[WLUserInfo share].userId kid:self.kid success:^(id responseObject) {
        [self.dataSoureArray addObjectsFromArray:responseObject[@"data"]];
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        [MOProgressHUD showErrorWithStatus:error.userInfo[@"msg"]];
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textColor = COLOR_WORD_BLACK;
    }
    cell.textLabel.text = self.dataSoureArray[indexPath.row][@"type"];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSoureArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *type = self.dataSoureArray[indexPath.row][@"type"];
    if ([type isEqualToString:@"填空题"]) {
        
        [WLHomeDataHandle requestExaminationContentWithUid:[WLUserInfo share].userId kid:_kid type:@"填空题" success:^(id responseObject) {
            
            WLfillingViewController *fillVC = [[WLfillingViewController alloc] init];
            fillVC.questionArray = responseObject[@"data"];
            fillVC.index = 0;
            fillVC.isShowAnswer = YES;
            [self.navigationController pushViewController:fillVC animated:YES];
            
        } failure:^(NSError *error) {
            [MOProgressHUD showErrorWithStatus:error.userInfo[@"msg"]];
        }];
    }else if ([type isEqualToString:@"判断题"]) {
        
        [WLHomeDataHandle requestExaminationContentWithUid:[WLUserInfo share].userId kid:_kid type:@"判断题" success:^(id responseObject) {
            
            WLJudgmentsViewController *vc = [[WLJudgmentsViewController alloc] init];
            vc.questionArray = responseObject[@"data"];
            vc.index = 0;
            vc.isShowAnswer = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
        } failure:^(NSError *error) {
            [MOProgressHUD showErrorWithStatus:error.userInfo[@"msg"]];
        }];
    }else if ([type isEqualToString:@"选择题"]) {
        
        [WLHomeDataHandle requestExaminationContentWithUid:[WLUserInfo share].userId kid:_kid type:@"选择题" success:^(id responseObject) {
            
            WLChooseViewController *vc = [[WLChooseViewController alloc] init];
            vc.questionArray = responseObject[@"data"];
            vc.index = 0;
            vc.isShowAnswer = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
        } failure:^(NSError *error) {
            [MOProgressHUD showErrorWithStatus:error.userInfo[@"msg"]];
        }];
    }else if ([type isEqualToString:@"问答题"]){
        
        [WLHomeDataHandle requestExaminationContentWithUid:[WLUserInfo share].userId kid:_kid type:@"问答题" success:^(id responseObject) {
            
            WLEssayViewController *vc = [[WLEssayViewController alloc] init];
            vc.questionArray = responseObject[@"data"];
            vc.index = 0;
            vc.isShowAnswer = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
        } failure:^(NSError *error) {
            [MOProgressHUD showErrorWithStatus:error.userInfo[@"msg"]];
        }];
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
