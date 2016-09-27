//
//  WLOrderDetailsViewController.m
//  MyBoRuiSi
//
//  Created by 莫瑞伟 on 16/8/6.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLOrderDetailsViewController.h"
#import "WLOrderDetailsCell.h"

@interface WLOrderDetailsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView_main;

@property (weak, nonatomic) IBOutlet UIButton *button_click;


@end

@implementation WLOrderDetailsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self initSelf];
    
    
}

- (void)initSelf{
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
    btn.backgroundColor = [UIColor clearColor];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setImage:[UIImage imageNamed:@"图层-47"] forState:UIControlStateNormal];
    [btn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
    [btn setTitle:@" 订单详情" forState:UIControlStateNormal];
    self.navigationItem.titleView = btn;
    
    [self.button_click setTitle:self.str_button forState:UIControlStateNormal];
}
//MARK:tableView代理方法----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.arr_data.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arr_data[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        //1 创建可重用cell对象
        static NSString *reuseId = @"WLOrderDetailsCell";
        WLOrderDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"WLOrderDetailsCell" owner:nil options:nil] lastObject];
        }
        return cell;
    }
    
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.arr_data[indexPath.section][indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.textColor = RGBA(51, 51, 51, 1);
    
    UILabel *label_details = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WLScreenW - 140, 48)];
    label_details.text = self.arr_details[indexPath.row];
    label_details.textColor = RGBA(102, 102, 102, 1);
    label_details.font = [UIFont systemFontOfSize:15];
    if (indexPath.section == 1 && indexPath.row == 4) {
        label_details.textColor = RGBA(347, 100, 59, 1);
    }
    cell.accessoryView = label_details;
    
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view_title = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WLScreenW, 44)];
    UILabel *label_title = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, WLScreenW-15, 44)];
    [view_title addSubview:label_title];
    
    label_title.font = [UIFont systemFontOfSize:15];
    if (section == 0) {
        label_title.textColor = RGBA(153, 153, 153, 1);
        label_title.text = self.arr_title[section];//@" 订单状态 : 待评价";
        view_title.backgroundColor = [UIColor whiteColor];
    }
    else{
        label_title.textColor = RGBA(51, 51, 51, 1);
        label_title.text = self.arr_title[section];//@" 订单详情";
        view_title.backgroundColor = RGBA(245, 245, 245, 1);
    }
    return view_title;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 102;
    }
    return 48;
}
- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}
- (CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}
@end
