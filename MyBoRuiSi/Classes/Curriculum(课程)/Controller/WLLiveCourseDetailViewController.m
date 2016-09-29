//
//  WLLiveCourseDetailViewController.m
//  MyBoRuiSi
//
//  Created by Catskiy on 2016/9/29.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLLiveCourseDetailViewController.h"
#import "WLLookTableViewCell.h"
#import "WLPurchaseBottomView.h"
#import "WLHomeDataHandle.h"

@interface WLLiveCourseDetailViewController ()

@property (nonatomic, strong) UIImageView *headerImgV;


@end

@implementation WLLiveCourseDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setSubviews];
}

- (void)setSubviews
{
    self.tableViewStyle = UITableViewStyleGrouped;
    
    [self.view addSubview:self.tableView];
    
    _headerImgV = [[UIImageView alloc] init];
    _headerImgV.frame = CGRectMake(0, 0, WLScreenW, 200);
    _headerImgV.layer.masksToBounds = YES;
    _headerImgV.contentMode = UIViewContentModeScaleAspectFill;
    self.tableView.tableHeaderView = _headerImgV;
    
    WLLookTableViewCell *footer = [[[NSBundle mainBundle]loadNibNamed:@"WLLookTableViewCell" owner:nil options:nil]lastObject];
    footer.courseId = _courseId;
    footer.nvc = self.navigationController;
    self.tableView.tableFooterView = footer;
    
    WLPurchaseBottomView *bottomView = [[WLPurchaseBottomView alloc] initWithFrame:CGRectMake(0, WLScreenH - 64 - 50, WLScreenW, 50)];
    [self.view addSubview:bottomView];
    
    [self setNavigationBarStyleDefultWithTitle:@"课程详情"];
    
    //设置右边的按钮图片没有渲染
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageWithOriginalName:@"素彩网www.sc115.com-136"] style:UIBarButtonItemStyleDone target:self action:@selector(rightBtnAction:)];
}

- (void)requestData
{
    [WLHomeDataHandle requestHomeClassDetailWithCourseId:_courseId success:^(id responseObject) {
        
//        _course = [WLCourceModel mj_objectWithKeyValues:responseObject[@"data"]];
//        [_headerImgV sd_setImageWithURL:[NSURL URLWithString:_course.photo] placeholderImage:[UIImage imageNamed:@"icon"]];
//        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)rightBtnAction:(id)sender
{
    
}


@end
