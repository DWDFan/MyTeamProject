//
//  WLMyCircleViewController.m
//  MyBoRuiSi
//
//  Created by Catskiy on 2016/10/10.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLMyCircleViewController.h"
#import "WLCirCleDetailViewController.h"
#import "WLCirCleCell.h"
#import "WLFindDataHandle.h"
#import "WLCircleModel.h"

@interface WLMyCircleViewController ()

@property (nonatomic, strong) NSArray *circlesArray;

@end

@implementation WLMyCircleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setSubviews];
    
    [self requestData];
}

- (void)requestData
{
    [WLFindDataHandle requestFindMyCircleWithUid:[WLUserInfo share].userId success:^(id responseObject) {
        
        _circlesArray = [WLCircleModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

- (void)setSubviews
{
    self.tableViewStyle = UITableViewStyleGrouped;
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _circlesArray.count > 0 ? 1 : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    
    WLCirCleCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[WLCirCleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.circlesArray = _circlesArray;
    [cell setBlock:^(NSString *typeId, NSString *name) {
        
        WLCirCleDetailViewController *detailVC = [[WLCirCleDetailViewController alloc] init];
        detailVC.circleId = typeId;
        detailVC.circleName = name;
        [self.navigationController pushViewController:detailVC animated:YES];
    }];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [WLCirCleCell heightWithCount:_circlesArray.count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.00001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.00001;
}

@end
