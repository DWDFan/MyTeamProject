//
//  WLCircleListViewController.m
//  MyBoRuiSi
//
//  Created by Magician on 2017/2/16.
//  Copyright © 2017年 itcast.com. All rights reserved.
//

#import "WLCircleListViewController.h"
#import "WLCirCleDetailViewController.h"
#import "WLFindDataHandle.h"
#import "WLCirCleCell.h"
#import "WLCircleModel.h"

@interface WLCircleListViewController ()

@end

@implementation WLCircleListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableViewStyle = UITableViewStyleGrouped;
    [self.view addSubview:self.tableView];
    
    [self requestData];
}

- (void)requestData
{
    [WLFindDataHandle requestFindCircleListWithPid:_pid success:^(id responseObject) {
        
        NSArray *circles = [WLCircleInfoModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][0][@"data"]];
        [self.dataSoureArray addObjectsFromArray:circles];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WLCirCleCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[WLCirCleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.circlesArray = self.dataSoureArray;
    
    [cell setBlock:^(NSString *typeId, NSString *name) {
        
        WLCirCleDetailViewController *detailVC = [[WLCirCleDetailViewController alloc] init];
        detailVC.circleId = typeId;
        detailVC.circleName = name;
        [self.navigationController pushViewController:detailVC animated:YES];
    }];
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.000001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.000001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return [WLCirCleCell heightWithCount:self.dataSoureArray.count];
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
