//
//  WLTeacherViewController.m
//  MyBoRuiSi
//
//  Created by wsl on 16/8/4.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLTeacherViewController.h"
#import "WLHometwoTableViewCell.h"

#import "WLDetailsViewController.h"
#import "WLHomeDataHandle.h"
#import "WLLecturerModel.h"
#import "RecommendModell.h"

@interface WLTeacherViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *lecturesArray;

@end

@implementation WLTeacherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
    
    [btn setBackgroundColor:[UIColor clearColor]];
    
    [btn setImage:[UIImage imageNamed:@"图层-47"] forState:UIControlStateNormal];
    [btn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
    [btn setTitle:@"推荐讲师" forState:UIControlStateNormal];
    self.navigationItem.titleView = btn;
    
    [self.navigationController.navigationBar setBackgroundImage:[MOTool createImageWithColor:RGBA(255, 255, 255, 1)] forBarMetrics:UIBarMetricsDefault];
    
    [self requestData];
}

- (void)requestData
{
    [WLHomeDataHandle requestHomeRecommendLectureWithNum:@10 Success:^(id responseObject) {
        
        self.lecturesArray = [RecommendModell mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return _lecturesArray.count;
}


//cell高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 262;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *deteID = @"WLHometwoTableViewCell";
    
    WLHometwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:deteID];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:deteID owner:nil options:nil] lastObject];
    }
    cell.Modell = _lecturesArray[indexPath.row];
    
    return cell;
}

#pragma mark 点击tableViewcell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //讲师详情
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    WLDetailsViewController *det = [[WLDetailsViewController alloc]init];
    [self.navigationController pushViewController:det animated:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
}



@end
