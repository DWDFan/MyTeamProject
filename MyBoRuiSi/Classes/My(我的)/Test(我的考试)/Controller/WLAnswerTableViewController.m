//
//  WLAnswerTableViewController.m
//  MyBoRuiSi
//
//  Created by mo on 16/8/5.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLAnswerTableViewController.h"
#import "WLfillingViewController.h"
#import "WLChoiceViewController.h"
#import "WLJudgmentsViewController.h"
#import "WLQuestionViewController.h"


@interface WLAnswerTableViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *AnswerTable;

@end

@implementation WLAnswerTableViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
    btn.backgroundColor = [UIColor clearColor];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setImage:[UIImage imageNamed:@"图层-47"] forState:UIControlStateNormal];
    [btn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
    [btn setTitle:@"试卷答案" forState:UIControlStateNormal];
    self.navigationItem.titleView = btn;
    
    
    
    [self.navigationController.navigationBar setBackgroundImage:[MOTool createImageWithColor:RGBA(255, 255, 255, 1)] forBarMetrics:UIBarMetricsDefault];
    
    self.AnswerTable.delegate = self;
    self.AnswerTable.dataSource = self;
    self.AnswerTable.rowHeight = 70;
    
}

//一共有多少组数据
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//第section组有多少行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 4 ;
    }else{
        return 1 ;
    }
}
-(UITableViewCell *)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    cell.textLabel.text = @"问答题";
    
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"填空题";
        }
        if (indexPath.row == 1) {
            cell.textLabel.text = @"选择题";
        }
        if (indexPath.row == 2) {
            cell.textLabel.text = @"判断题";
        }
    }
    //添加图片尾部
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    //添加尾部图片
//    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(320, 25,10, 20)];
//    imageView.image = [UIImage imageNamed:@"素彩网www.sc115.com-138-拷贝-4"];
//    [cell.contentView addSubview:imageView];
    
    
    return cell ;
}

//设置跳转到另一个控制器
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    WLQuestionController *vc = [[WLQuestionController alloc]init];
//    [self.navigationController pushViewController:vc animated:YES];
//}
//设置同事跳转到多个控制器
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            WLfillingViewController *QuestionVC = [[WLfillingViewController alloc]init];
            [self.navigationController pushViewController:QuestionVC animated:YES];
        }
        if (indexPath.row == 1) {
            WLChoiceViewController *ChooseVC = [[WLChoiceViewController alloc]init];
            [self.navigationController pushViewController:ChooseVC animated:YES];
        }
        if (indexPath.row == 2) {
            WLJudgmentsViewController *JudgeVC = [[WLJudgmentsViewController alloc]init];
            [self.navigationController pushViewController:JudgeVC animated:YES];
        }
        if (indexPath.row == 3) {
            WLQuestionViewController *EssayVC = [[WLQuestionViewController alloc]init];
            [self.navigationController pushViewController:EssayVC animated:YES];
        }

    }
}

@end
