//
//  WLOrderPayViewController.m
//  MyBoRuiSi
//
//  Created by 莫瑞伟 on 16/8/4.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLOrderPayViewController.h"
#import "WLOrderPayOKViewController.h"

@interface WLOrderPayViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView_main;
@property (nonatomic,strong) NSMutableArray *arr_str;

@end

@implementation WLOrderPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSelf];
    
    
    self.arr_str = [NSMutableArray arrayWithArray:@[@[@"订单名称:  xx课程",@"订单总价:  $200.00",@"账户余额:  $400.00"],
                                                    @[@"还需支付: $99.00"],
                                                    @[@"支付宝支付",@"微信支付",@"银联支付"]]];
    
}
- (void)clickBalancePay:(UIButton *)button
{
    button.selected = !button.selected;
}
- (IBAction)clickOKPay:(UIButton *)sender {
    
    WLOrderPayOKViewController *vc = [[WLOrderPayOKViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

//MARK:tableView代理方法----------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arr_str[section] count];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.arr_str.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSString *str_title = self.arr_str[indexPath.section][indexPath.row];
    cell.textLabel.text = str_title;
    
    if (indexPath.section == 0) {
        if (indexPath.row == 2) {
            UIButton *button_option = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 44)];
            [button_option addTarget:self action:@selector(clickBalancePay:) forControlEvents:UIControlEventTouchUpInside];
            [button_option setImage:[UIImage imageNamed:@"椭圆-2"] forState:UIControlStateNormal];
            [button_option setImage:[UIImage imageNamed:@"支付订单组-3"] forState:UIControlStateSelected];
            cell.accessoryView = button_option;
        }
    }
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            cell.imageView.image = [UIImage imageNamed:@"支付宝组-4"];
        }
        if (indexPath.row == 1) {
            cell.imageView.image = [UIImage imageNamed:@"微信组-5"];
        }
        if (indexPath.row == 2) {
            cell.imageView.image = [UIImage imageNamed:@"银联"];
        }
        UIButton *button_option = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 44)];
        [button_option addTarget:self action:@selector(clickBalancePay:) forControlEvents:UIControlEventTouchUpInside];
        [button_option setImage:[UIImage imageNamed:@"椭圆-2"] forState:UIControlStateNormal];
        [button_option setImage:[UIImage imageNamed:@"支付订单组-3"] forState:UIControlStateSelected];
        cell.accessoryView = button_option;
    }
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 2) {
        return @"支付方式";
    }
    else{
        return @"";
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 2) {
        return 30;
    }
    return 0.01;
}
- (CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 1){
        return 0.01;
    }
    return 10;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}
- (void)initSelf{
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
    btn.backgroundColor = [UIColor clearColor];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setImage:[UIImage imageNamed:@"图层-47"] forState:UIControlStateNormal];
    [btn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
    [btn setTitle:@" 支付订单" forState:UIControlStateNormal];
    self.navigationItem.titleView = btn;
}

@end
