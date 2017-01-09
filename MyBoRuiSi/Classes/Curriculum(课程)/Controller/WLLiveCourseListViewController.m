//
//  WLLiveCourseListViewController.m
//  MyBoRuiSi
//
//  Created by Catskiy on 2016/9/29.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLLiveCourseListViewController.h"
#import "WLCourseDetailViewController.h"
#import "WLLiveCourseDetailViewController.h"
#import "WLFilterView.h"
#import "WLHomeDataHandle.h"
#import "WLCourseDataHandle.h"
#import "WLCourceModel.h"
#import "WLZnewsTableViewCell.h"

@interface WLLiveCourseListViewController ()

@end

@implementation WLLiveCourseListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavigationBarStyleDefultWithTitle:@"在线直播"];
}


- (void)requestData
{
    self.page = 1;

    [WLHomeDataHandle requestSearchCourseWithNum:@10 page:@1 key:@"" type:@2 ppid:self.sortId priceOrder:self.priceOrder zbstatus:nil saleNum:self.saleNumOrder level:@0 success:^(id responseObject) {
        
        self.page == 1 ? [self.courses removeAllObjects] : nil;
        
        NSArray *mArray = [WLCourceModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.courses addObjectsFromArray:mArray];
        [self.tableView footerEndRefreshing];
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
    
    [WLCourseDataHandle requestCourseFilterSuccess:^(id responseObject) {
        
        self.filterArray = responseObject[@"data"][@"sort"];
    } failure:^(NSError *error) {
        
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    WLZnewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"WLZnewsTableViewCell" owner:nil options:nil] lastObject];
    }
    cell.course = self.courses[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    WLLiveCourseDetailViewController *vc = [[WLLiveCourseDetailViewController alloc] init];
    vc.courseId = [self.courses[indexPath.row] id];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
