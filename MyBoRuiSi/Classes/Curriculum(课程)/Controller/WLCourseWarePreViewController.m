//
//  WLCourseWarePreViewController.m
//  MyBoRuiSi
//
//  Created by Catskiy on 2016/10/14.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLCourseWarePreViewController.h"
#import "WLCourseDataHandle.h"
#import "WLCourseWareCell.h"
#import "ZGDownLoadUtil.h"

@interface WLCourseWarePreViewController ()

@property (nonatomic, strong) UIButton *downloadBtn;


@end

@implementation WLCourseWarePreViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNavigationBarStyleDefultWithTitle:@"相关课件"];
    
    self.tableView.rowHeight = 250;
    [self.view addSubview:self.tableView];
    
    self.downloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.downloadBtn.frame = CGRectMake(0, WLScreenH - IOS7_TOP_Y - 49, WLScreenW, 49);
    self.downloadBtn.backgroundColor = color_red;
    [self.downloadBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.downloadBtn addTarget:self action:@selector(downloadBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.downloadBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    self.downloadBtn.titleEdgeInsets = UIEdgeInsetsMake(20, 0, 0, 0);
    [self.downloadBtn setTitle:@"大小:0M   格式:PDF" forState:UIControlStateNormal];
    [self.view addSubview:self.downloadBtn];
    
    UILabel *downLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 7, WLScreenW, 16)];
    downLbl.font = [UIFont systemFontOfSize:16];
    downLbl.textColor = [UIColor whiteColor];
    downLbl.textAlignment = NSTextAlignmentCenter;
    downLbl.text = @"下载";
    [self.downloadBtn addSubview:downLbl];
    
    [self requestData];
}

- (void)requestData
{
    [WLCourseDataHandle requestCoursewarePreVWithUserId:[WLUserInfo share].userId kid:_courseWareId success:^(id responseObject) {
        
        self.dataSoureDic = responseObject[@"data"];
        [self.downloadBtn setTitle:[NSString stringWithFormat:@"大小:%@M   格式:%@",self.dataSoureDic[@"size"],self.dataSoureDic[@"type"]] forState:UIControlStateNormal];
        self.dataSoureArray = responseObject[@"data"][@"image"];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

- (void)downloadBtnAction:(UIButton *)sender
{
    #warning testData -- fzg
    sender.enabled = NO;
    [MOProgressHUD showWithStatus:@"正在下载课件..."];
    NSURL *url = [NSURL URLWithString:@"http://4493bz.1985t.com/uploads/allimg/141204/4-141204095J8.jpg"];
    ZGDownLoadUtil *downloadUtil = [[ZGDownLoadUtil alloc] init];
    [downloadUtil downLoadFileWithUrl:url completion:^(BOOL isComplete) {
        [MOProgressHUD showSuccessWithStatus:@"下载完成!"];
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSoureArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIImageView *imageV = [[UIImageView alloc] init];
        imageV.frame = CGRectMake(0, 0, WLScreenW, 240);
        [cell addSubview:imageV];
        imageV.tag = 888;
    }
    UIImageView *imageV = [cell viewWithTag:888];
    [imageV sd_setImageWithURL:[NSURL URLWithString:self.dataSoureArray[indexPath.row][@"image"]] placeholderImage:PHOTO_PLACE];
    return cell;
}

@end
