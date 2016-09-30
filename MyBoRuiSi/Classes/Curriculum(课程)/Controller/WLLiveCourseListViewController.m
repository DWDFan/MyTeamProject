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
    [WLHomeDataHandle requestSearchCourseWithNum:@10 page:@1 key:@"" type:@2 ppid:self.sortId priceOrder:self.priceOrder zbstatus:@1 saleNum:self.saleNumOrder level:@0 success:^(id responseObject) {
        
        self.courses = responseObject[@"data"];
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
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
