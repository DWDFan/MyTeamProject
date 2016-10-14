//
//  WLCoursewareViewController.m
//  MyBoRuiSi
//
//  Created by Catski on 2016/10/12.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLCoursewareViewController.h"
#import "WLCourseWarePreViewController.h"
#import "WLCourseDataHandle.h"
#import "ZGDownLoadUtil.h"
#import "WLCourseWareCell.h"

@interface WLCoursewareViewController ()


@end

@implementation WLCoursewareViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNavigationBarStyleDefultWithTitle:@"相关课件"];
    
    self.tableView.rowHeight = 44;
    [self.view addSubview:self.tableView];
    
    [self requestData];
}

- (void)requestData
{
    [WLCourseDataHandle requestCoursewareWithCourseId:_courseId uid:[WLUserInfo share].userId success:^(id responseObject) {
        
        self.dataSoureArray = responseObject[@"data"];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSoureArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    WLCourseWareCell *cell = [self.tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"WLCourseWareCell" owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.indexPath = indexPath;
    cell.coursewareDic = self.dataSoureArray[indexPath.row];
    
    [cell setBlock:^(NSInteger type, NSInteger row) {
        
        if (type == 0) {
            
            WLCourseWarePreViewController *VC = [[WLCourseWarePreViewController alloc] init];
            VC.courseWareId = self.dataSoureArray[indexPath.row][@"kid"];
            [self.navigationController pushViewController:VC animated:YES];
        }else {
#warning testData -- fzg
            [MOProgressHUD showWithStatus:@"正在下载课件..."];
            NSURL *url = [NSURL URLWithString:self.dataSoureArray[indexPath.row][@"kjUrl"]];
            ZGDownLoadUtil *downloadUtil = [[ZGDownLoadUtil alloc] init];
            [downloadUtil downLoadFileWithUrl:url completion:^(BOOL isComplete) {
                [MOProgressHUD showSuccessWithStatus:@"下载完成!"];
            }];
        }
    }];
    return cell;
}


@end
