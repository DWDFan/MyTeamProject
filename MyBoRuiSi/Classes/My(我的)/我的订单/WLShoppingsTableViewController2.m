//
//  WLShoppingsTableViewController2.m
//  MyBoRuiSi
//
//  Created by 莫瑞伟 on 16/8/4.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLShoppingsTableViewController2.h"
#import "WLOrderCell.h"
#import "WLOrderPayViewController.h"
#import "WLOrderDetailsViewController.h"


@interface WLShoppingsTableViewController2 ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView_main;
@property (nonatomic,assign) BOOL isOpen;

@end

@implementation WLShoppingsTableViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}
//- (void)openOption
//{
//    NSLog(@"打开 2");
//    self.isOpen = YES;
//    [self.tableView_main reloadData];
//}
//- (void)offOption
//{
//    NSLog(@"关闭 2");
//    self.isOpen = NO;
//    [self.tableView_main reloadData];
//}
//MARK:tableView代理方法----------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1 创建可重用cell对象
    static NSString *reuseId = @"WLOrderCell";
    WLOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"WLOrderCell" owner:nil options:nil] lastObject];
    }
    cell.isOpen = self.isOpen;
    __weak typeof(self) weakSelf = self;
    cell.action_pay = ^(){
        WLOrderPayViewController *vc = [[WLOrderPayViewController alloc]init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}
- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
- (CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WLOrderDetailsViewController *vc = [[WLOrderDetailsViewController alloc]init];
    vc.arr_details = [NSMutableArray arrayWithArray:@[@"12345678",@"2015-0809",@"￥200.0",@"10.00",@"190.0"]];
    vc.arr_data = [NSMutableArray arrayWithArray:@[@[@""],@[@"订单号 :",@"付款时间 :",@"总价 :",@"积分抵扣 :",@"实际总价 :"]]];
    vc.arr_title = [NSMutableArray arrayWithArray:@[@" 订单状态 : 未开始",@" 订单详情"]];
    vc.str_button = @"立即付款";
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{//请求数据源提交的插入或删除指定行接收者。
    if (editingStyle ==UITableViewCellEditingStyleDelete) {//如果编辑样式为删除样式
        
    }
}

@end
