//
//  WLAddOrderViewController.m
//  MyBoRuiSi
//
//  Created by 莫瑞伟 on 16/8/6.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLAddOrderViewController.h"
#import "WLOrderPayViewController.h"

#import "WLOrderDataHandle.h"
@interface WLAddOrderViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView_main;
@property (nonatomic, strong) UILabel *amount_lab;//总计

@property (nonatomic,strong) NSMutableArray *arr_data;
@property (nonatomic, assign) NSInteger userScore;

@end

@implementation WLAddOrderViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _userScore = 0;
    self.arr_data = [NSMutableArray arrayWithArray:@[@[self.type == orderPayType ? @"商品" : @"充值",@"小计"],@[@"使用积分",@"总计"]]];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
    btn.backgroundColor = [UIColor clearColor];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setImage:[UIImage imageNamed:@"图层-47"] forState:UIControlStateNormal];
    [btn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
    [btn setTitle:@" 提交订单" forState:UIControlStateNormal];
    self.navigationItem.titleView = btn;
}

#pragma mark - Event Response
- (void)userJiFen:(UIButton* )sender{
    sender.selected = !sender.selected;
    
    if (sender.selected) {
       self.userScore = [[WLUserInfo share].score integerValue] / 100;
        NSInteger amount = [self.money floatValue] - self.userScore;
        self.amount_lab.text = [NSString stringWithFormat:@"￥%zd",amount];
    }else{
        self.userScore = 0;
        self.amount_lab.text = [NSString stringWithFormat:@"￥%@",self.money];

    }
    
}
- (IBAction)clickButton:(id)sender {
    //request
    [self requestCommitOrder];
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
    label_details.textAlignment = NSTextAlignmentRight;
    label_details.textColor = [UIColor orangeColor];
    label_details.font = [UIFont systemFontOfSize:16];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            label_details.textColor = RGBA(102, 102, 102, 1);
            label_details.font = [UIFont systemFontOfSize:13];
        }
        label_details.text = [NSString stringWithFormat:@"￥%@",self.money];
        cell.accessoryView = label_details;
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            UIView *accessoryView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 140, 60)];
            cell.accessoryView = accessoryView;
            
            [accessoryView addSubview:({
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame = CGRectMake(10, 15, 30, 30);
                [btn setImage:[UIImage imageNamed:@"椭圆-2"] forState:UIControlStateNormal];
                [btn setImage:[UIImage imageNamed:@"tick"] forState:UIControlStateSelected];
                [btn addTarget:self action:@selector(userJiFen:) forControlEvents:UIControlEventTouchUpInside];
                if([[WLUserInfo share].score isEqualToNumber:@0]) btn.userInteractionEnabled = NO;
                btn;
            })];
            
            [accessoryView addSubview:({
                UILabel *lab_1 = [[UILabel alloc] initWithFrame:CGRectMake(40, 8, 100, 15)];
                lab_1.textAlignment = NSTextAlignmentRight;
                lab_1.text = @"500积分抵5元";
                lab_1.font = [UIFont systemFontOfSize:13];
                lab_1.textColor = RGB(51, 51, 51);
                lab_1;
            })];
            
            [accessoryView addSubview:({
                UILabel *jiFen_lab = [[UILabel alloc] initWithFrame:CGRectMake(40, 28, 100, 15)];
                 jiFen_lab.textAlignment = NSTextAlignmentRight;
                jiFen_lab.text = [NSString stringWithFormat:@"现有积分%@",[WLUserInfo share].score];
                jiFen_lab.font = [UIFont systemFontOfSize:11];
                jiFen_lab.textColor = RGB(102, 102, 102);
                jiFen_lab;
            })];
        }else if(indexPath.row ==1){
            _amount_lab = label_details;
            label_details.text = [NSString stringWithFormat:@"￥%@",self.money];
            cell.accessoryView = label_details;
        }
    }
    
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && indexPath.row == 0) {
        return 60;
    }
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

#pragma mark - Request
- (void)requestCommitOrder{
    [WLOrderDataHandle requestCommitOrderWithUid:[WLUserInfo share].userId cid:self.cid type:self.type jifen:nil success:^(id responseObject) {
        NSDictionary *dict = responseObject;
        if ([dict[@"code"]integerValue] == 1) {
            WLOrderPayViewController *vc = [[WLOrderPayViewController alloc]init];
            vc.amountStr = self.money;
            vc.needMoney = self.amount_lab.text;
            vc.orderId = dict[@"id"];
#warning Beelin bug 订单名称
//            vc.orderName = dict
            vc.type = rechargeType;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            [MOProgressHUD showErrorWithStatus:dict[@"msg"]];
        }
    } failure:^(NSError *error) {
         [MOProgressHUD showErrorWithStatus:error.localizedFailureReason];
    }];
}
@end
