//
//  WLShoppingsTableViewController1.m
//  MyBoRuiSi
//
//  Created by 莫瑞伟 on 16/8/4.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLShoppingsTableViewController1.h"
#import "WLOrderCell.h"
#import "WLOrderDetailsViewController.h"
#import "WLAddOrderViewController.h"

@interface WLShoppingsTableViewController1 ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView_main;

@property (nonatomic,assign) BOOL isOpen;
@property (weak, nonatomic) IBOutlet UIButton *button_OptionAll;

@end

@implementation WLShoppingsTableViewController1

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    
}
- (IBAction)clickOK:(id)sender {
    WLAddOrderViewController *vc = [[WLAddOrderViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)clickAll:(UIButton *)sender {
    if (!sender.selected) {
//        sender.imageView.image = [UIImage imageNamed:@"2345"];
        sender.selected = YES;
    }
    else{
//        sender.imageView.image = [UIImage imageNamed:@"椭圆-2"];
        sender.selected = NO;
    }
    
}

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
    
    cell.isOpen = YES;
    
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
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{//请求数据源提交的插入或删除指定行接收者。
    if (editingStyle ==UITableViewCellEditingStyleDelete) {//如果编辑样式为删除样式
        
    }
}




@end
