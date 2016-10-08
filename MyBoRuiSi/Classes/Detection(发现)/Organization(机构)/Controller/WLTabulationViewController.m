//
//  WLTabulationViewController.m
//  MyBoRuiSi
//
//  Created by wsl on 16/8/4.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLTabulationViewController.h"
#import "WLTabulationerableViewCell.h"
#import "WLInstitutionLecturersCell.h"
#import "WLDetailsViewController.h"
#import "WLHomeDataHandle.h"

@interface WLTabulationViewController ()

@property (nonatomic, strong)NSArray *lecturers;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation WLTabulationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
    btn.backgroundColor = [UIColor clearColor];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setImage:[UIImage imageNamed:@"图层-47"] forState:UIControlStateNormal];
    [btn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
    [btn setTitle:@"讲师列表" forState:UIControlStateNormal];
    self.navigationItem.titleView = btn;
    
    self.tableView.tableFooterView = [UIView new];
    
    [self.navigationController.navigationBar setBackgroundImage:[MOTool createImageWithColor:RGBA(255, 255, 255, 1)] forBarMetrics:UIBarMetricsDefault];
    
    [self requestData];
}

- (void)requestData
{
    [WLHomeDataHandle requestInstitutionLecturersWithJid:_institutionId success:^(id responseObject) {
        
        _lecturers = [WLLecturerModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return _lecturers.count;
}


//cell高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

////返回组头的高度
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    
//    return 10 ;
//}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *deteID = @"WLTabulationerableViewCell";
    
    WLInstitutionLecturersCell *cell = [tableView dequeueReusableCellWithIdentifier:deteID];
    
    if (cell == nil) {
        cell = [[WLInstitutionLecturersCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:deteID];
    }
    cell.lecturer = _lecturers[indexPath.row];
       
    return cell;
}


#pragma mark 点击tableViewcell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //讲师详情
    WLDetailsViewController *deta = [[WLDetailsViewController alloc]init];
    deta.teacherId = [_lecturers[indexPath.row] tid];
    [self.navigationController pushViewController:deta animated:YES];
    
}



@end
