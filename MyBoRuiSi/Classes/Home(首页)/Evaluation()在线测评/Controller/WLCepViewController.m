//
//  WLCepViewController.m
//  MyBoRuiSi
//
//  Created by wsl on 16/8/5.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLCepViewController.h"
#import "WLPaperTypeCell.h"
#import "WLHomeDataHandle.h"
#import "WLPhysiologyViewController.h"
#import "WLTestDetailViewController.h"
#import "WLQuetionModel.h"

@interface WLCepViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableviewtow;
@property (nonatomic, strong) NSArray *paperArray;
@property (nonatomic, strong) UIButton *titleView;

@end

@implementation WLCepViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
//    btn.backgroundColor = [UIColor clearColor];
//    [btn setBackgroundColor:[UIColor clearColor]];
//    [btn setImage:[UIImage imageNamed:@"图层-47"] forState:UIControlStateNormal];
//    [btn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
//    [btn setTitle:_paperTypeName forState:UIControlStateNormal];
//    self.navigationItem.titleView = btn;
    
    UIView *titleView = [[UIView alloc] init];

    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    icon.image = [UIImage imageNamed:@"图层-47"];
    icon.contentMode = UIViewContentModeCenter;
    [titleView addSubview:icon];
    
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:17];
    label.textColor = COLOR_WORD_BLACK;
    label.text = self.paperTypeName;
    CGFloat labelW = [MOTool sizeWithString:self.paperTypeName font:label.font].width;
    labelW = labelW > 17 * 14 ? 17 * 14: labelW;
    label.frame = CGRectMake(icon.width, 0, labelW, 30);
    [titleView addSubview:label];
    
    titleView.frame = CGRectMake(0, 0, labelW + 30, 30);
    
    self.navigationItem.titleView = titleView;
    
    [self.navigationController.navigationBar setBackgroundImage:[MOTool createImageWithColor:RGBA(255, 255, 255, 1)] forBarMetrics:UIBarMetricsDefault];
    
    UIView *view  = [UIView new];
    self.tableviewtow.tableFooterView = view;
    
    [self requestData];
}

- (void)requestData
{
    [WLHomeDataHandle requestPaperListWithType:_paperType page:@1 success:^(id responseObject) {
        
        self.paperArray = responseObject[@"data"];
        [self.tableviewtow reloadData];
    } failure:^(NSError *error) {
        
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return _paperArray.count;
}


//cell高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

//返回组头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10 ;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *deteID = @"WLDetectionTableViewCell";
    
    WLPaperTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:deteID];
    
    if (cell == nil) {
        cell = [[WLPaperTypeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:deteID];
    }
    
    cell.photoImgV.image = [UIImage imageNamed:@"组-4"];
    cell.nameLbl.text = _paperArray[indexPath.row][@"name"];
    return cell;
}
#pragma mark 点击tableViewcell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [WLHomeDataHandle requestPaperContentWithId:_paperArray[indexPath.row][@"id"] success:^(id responseObject) {
        
        NSArray *questionsArray = [WLQuetionModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];

        WLQuetionModel *questionModel = questionsArray[0];
        
        [WLHomeDataHandle requestPaperStarTestWithUid:[WLUserInfo share].userId tid:questionModel.tid success:^(id responseObject) {
            
            WLTestDetailViewController *testVC = [[WLTestDetailViewController alloc] init];
            testVC.title = _paperArray[indexPath.row][@"name"];
            testVC.questionsArray = questionsArray;
            testVC.questionId= [questionsArray[0] id];
            testVC.testId = responseObject[@"id"];
            testVC.testPaperId = questionModel.tid;
            testVC.questionIndex = 0;
            [self.navigationController pushViewController:testVC animated:YES];

        } failure:^(NSError *error) {
            
        }];
        
    } failure:^(NSError *error) {
        
        WLTestDetailViewController *testVC = [[WLTestDetailViewController alloc] init];
        testVC.title = _paperArray[indexPath.row][@"name"];
//        testVC.Id = _paperArray[indexPath.row][@"id"];
        [self.navigationController pushViewController:testVC animated:YES];
    }];
}
@end
