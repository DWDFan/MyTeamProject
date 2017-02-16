//
//  WLxqusViewController.m
//  MyBoRuiSi
//
//  Created by wsl on 16/8/10.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLxqusViewController.h"
#import "WLCirCleDetailViewController.h"
#import "WLCircleListViewController.h"
#import "WLCurriculumTableViewCell.h"
#import "WLFindDataHandle.h"
#import "WLCircleModel.h"
#import "WLCirCleCell.h"

@interface WLxqusViewController ()

@property (nonatomic, strong) NSArray *circleArray;

@end

@implementation WLxqusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableViewStyle = UITableViewStyleGrouped;
    [self.view addSubview:self.tableView];
    
    [self requestData];
}

- (void)requestData
{
    [WLFindDataHandle requestFindCircleTypeSuccess:^(id responseObject) {
        
        _circleArray = [WLcircleTypeModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.tableView reloadData];

    } failure:^(NSError *error) {
        
    }];
    
//    [WLFindDataHandle requestFindCircleListSuccess:^(id responseObject) {
//        
//        _circleArray = [WLcircleTypeModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
//        [self.tableView reloadData];
//    } failure:^(NSError *error) {
//        
//    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    return _circleArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WLcircleTypeModel *type = _circleArray[indexPath.section];
    
    return [WLCirCleCell heightWithCount:type.child.count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WLCirCleCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[WLCirCleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    WLcircleTypeModel *type = _circleArray[indexPath.section];
    cell.circlesArray = type.child;
    
    [cell setBlock:^(NSString *typeId, NSString *name) {
        
        WLCircleListViewController *listVC = [[WLCircleListViewController alloc] init];
        listVC.pid = typeId;
        listVC.title = name;
        [self.navigationController pushViewController:listVC animated:YES];
//        WLCirCleDetailViewController *detailVC = [[WLCirCleDetailViewController alloc] init];
//        detailVC.circleId = typeId;
//        detailVC.circleName = name;
//        [self.navigationController pushViewController:detailVC animated:YES];
    }];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.000001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *titleLbl = [[UILabel alloc] init];
    titleLbl.frame = CGRectMake(0, 0, WLScreenW, 40);
    titleLbl.font = [UIFont systemFontOfSize:14];
    titleLbl.textColor = COLOR_WORD_BLACK;
    
    WLcircleTypeModel *type = _circleArray[section];
    titleLbl.text = [NSString stringWithFormat:@"    %@",type.name];
    return titleLbl;
}


@end
