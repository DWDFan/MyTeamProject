//
//  WLAddOrderViewController.m
//  MyBoRuiSi
//
//  Created by 莫瑞伟 on 16/8/6.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLAddOrderViewController.h"
#import "WLOrderPayViewController.h"

@interface WLAddOrderViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView_main;

@property (nonatomic,strong) NSMutableArray *arr_data;

@end

@implementation WLAddOrderViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    self.arr_data = [NSMutableArray arrayWithArray:@[@[@"充值",@"小计"],@[@"使用积分",@"总计"]]];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
    btn.backgroundColor = [UIColor clearColor];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setImage:[UIImage imageNamed:@"图层-47"] forState:UIControlStateNormal];
    [btn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
    [btn setTitle:@" 提交订单" forState:UIControlStateNormal];
    self.navigationItem.titleView = btn;
}

- (IBAction)clickButton:(id)sender {
    
    WLOrderPayViewController *vc = [[WLOrderPayViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

//MARK:tableView代理方法----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.arr_data.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arr_data[section] count];;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    //1 创建可重用cell对象
    //    static NSString *reuseId = @"MOBankCardCell";
    //    MOBankCardCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    //    if (cell == nil) {
    //        cell = [[[NSBundle mainBundle] loadNibNamed:@"MOBankCardCell" owner:nil options:nil] lastObject];
    //    }
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.arr_data[indexPath.section][indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.textColor = RGBA(51, 51, 51, 1);
    
    UILabel *label_details = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WLScreenW - 140, 48)];
    label_details.text = @"￥200.00";
    label_details.textAlignment = NSTextAlignmentRight;
    label_details.textColor = [UIColor orangeColor];
    label_details.font = [UIFont systemFontOfSize:16];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            label_details.textColor = RGBA(102, 102, 102, 1);
            label_details.font = [UIFont systemFontOfSize:13];
        }
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            
        }
    }
    cell.accessoryView = label_details;
    
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
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
    
    
}

@end
