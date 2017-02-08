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
#import "DWDProgressHUD.h"

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
    BOOL hadDownload = [ZGDownLoadUtil hadDownloadFile:cell.coursewareDic[@"kjUrl"]];
    if (hadDownload) {  // 已下载
        cell.downloadBtn.enabled = NO;
        [cell.downloadBtn setImage:nil forState:UIControlStateNormal];
    }
    
    __weak typeof(cell) weakCell = cell;
    [cell setBlock:^(NSInteger type, NSInteger row) {
        
        if (type == 0) {
            
            WLCourseWarePreViewController *VC = [[WLCourseWarePreViewController alloc] init];
            VC.courseWareId = self.dataSoureArray[indexPath.row][@"kid"];
            VC.fileUrl = self.dataSoureArray[indexPath.row][@"kjUrl"];
            [self.navigationController pushViewController:VC animated:YES];
        }else {

            DWDProgressHUD *hud = [DWDProgressHUD showHUDAddedTo:self.view animated:YES];
            [hud showText:@"正在下载课件..."];
            NSURL *url = [NSURL URLWithString:self.dataSoureArray[indexPath.row][@"kjUrl"]];
            ZGDownLoadUtil *downloadUtil = [[ZGDownLoadUtil alloc] init];
            [downloadUtil downLoadFileWithUrl:url completion:^(BOOL isComplete) {
                [hud showText:@"下载完成" afterDelay:0.3];
                weakCell.downloadBtn.enabled = NO;
            }];
        }
    }];
    return cell;
}



@end
