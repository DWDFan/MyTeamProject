//
//  WLFinallysViewController.m
//  MyBoRuiSi
//
//  Created by wsl on 16/8/6.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLFinallysViewController.h"
#import "ZGTextCell.h"

@interface WLFinallysViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *titlekeys;

@end

@implementation WLFinallysViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
    btn.backgroundColor = [UIColor clearColor];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setImage:[UIImage imageNamed:@"图层-47"] forState:UIControlStateNormal];
    [btn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
    [btn setTitle:@"查询结果" forState:UIControlStateNormal];
    self.navigationItem.titleView = btn;
    
    [self.navigationController.navigationBar setBackgroundImage:[MOTool createImageWithColor:RGBA(255, 255, 255, 1)] forBarMetrics:UIBarMetricsDefault];
    
    _titles = @[@"证书类别:",@"姓名:",@"出生日期:",@"文化程度:",@"培训时间:",@"证书编号:",@"身份证编号:",@"颁发机构:",@"理论成绩:",@"实操成绩:",@"评定成绩:"];
    _titlekeys = @[@"type",@"name",@"birthday",@"xueli",@"px_time",@"zs_num",@"card_id",@"jigou",@"score1",@"score2",@"result"];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WLScreenW, WLScreenH - 64 - 50) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.rowHeight = 50;
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, WLScreenH - 64 - 50, WLScreenW, 50);
    backBtn.backgroundColor = color_red;
    [backBtn setTitle:@"返回首页" forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnAcion:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
}

- (void)backBtnAcion:(UIButton *)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    ZGTextCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ZGTextCell" owner:nil options:nil] lastObject];
    }
    cell.titleLbl.text = _titles[indexPath.row];
    cell.contentLbl.text = [MOTool getNULLString:_dataDict[_titlekeys[indexPath.row]]];
    return cell;
}


@end
