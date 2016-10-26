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

#import "WLShopCarModel.h"
@interface WLAddOrderViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView_main;
@property (nonatomic, strong) UIButton *select_btn;//总计

@property (nonatomic, assign) float amount; //总计
@property (nonatomic,strong) NSMutableArray *arr_data;
@property (nonatomic,strong) NSMutableArray *money_array;
@property (nonatomic, copy) NSString *cid; //购物车id
@property (nonatomic, assign) float userScore;

@end

@implementation WLAddOrderViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _userScore = 0;
    _amount = self.money;
    
    NSMutableArray *title_array = [NSMutableArray arrayWithCapacity:1];
    NSMutableArray *cid_array = [NSMutableArray arrayWithCapacity:1];
    NSMutableArray *money_array = [NSMutableArray arrayWithCapacity:1];
    
    for (WLShopCarModel *model in self.dataSource) {
        [title_array addObject:model.name];
        [cid_array addObject:model.gid];
        if ([model.vipFree isEqualToNumber:@1] && [WLUserInfo share].vip) {
            [money_array addObject:@0];
        }else{
            [money_array addObject:model.disPrice ? model.disPrice : model.price];
        }
    }
    
    self.cid = [cid_array componentsJoinedByString:@"|"];
    
    [title_array addObject:@"小计"];
    float scoreMoney = [[WLUserInfo share].score floatValue] / 100.0;
    if (scoreMoney > self.money) {
        NSString *scoreTitle = [NSString stringWithFormat:@"可用%.0f积分抵扣￥%.2f元",self.money * 100,self.money];
        self.arr_data = [NSMutableArray arrayWithArray:@[title_array,@[scoreTitle,@"总计"]]];
    }else{
        NSString *scoreTitle = [NSString stringWithFormat:@"可用%@积分抵扣￥%.2f元",[WLUserInfo share].score,scoreMoney];
        self.arr_data = [NSMutableArray arrayWithArray:@[title_array,@[scoreTitle,@"总计"]]];
    }
    

    [money_array addObject:@(self.money)];
    self.money_array = [NSMutableArray arrayWithArray:@[money_array,@[@(0),@(self.amount)]]];
    
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
    btn.backgroundColor = [UIColor clearColor];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setImage:[UIImage imageNamed:@"图层-47"] forState:UIControlStateNormal];
    [btn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
    [btn setTitle:@" 提交订单" forState:UIControlStateNormal];
    self.navigationItem.titleView = btn;
}


#pragma mark - Getter
- (UIButton *)select_btn{
    if (!_select_btn) {
        _select_btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _select_btn.frame = CGRectMake(0, 0, 44, 44);
        [_select_btn setImage:[UIImage imageNamed:@"椭圆-2"] forState:UIControlStateNormal];
        [_select_btn setImage:[UIImage imageNamed:@"tick"] forState:UIControlStateSelected];
        NSString *score = [NSString stringWithFormat:@"%@",[WLUserInfo share].score];
        [_select_btn addTarget:self action:@selector(userJiFen:) forControlEvents:UIControlEventTouchUpInside];
        if([score isEqualToString:@"0"] || score.length == 0) _select_btn.userInteractionEnabled = NO;
    }
    return _select_btn;
}
#pragma mark - Event Response
- (void)userJiFen:(UIButton* )sender{
    sender.selected = !sender.selected;
    
    if (sender.selected) {
       self.userScore = (float)[[WLUserInfo share].score integerValue] / 100;
        self.amount -= self.userScore;
    }else{
        self.userScore = 0;
        self.amount = self.money;
    }
    
    [self.money_array removeLastObject];
    [self.money_array addObject:@[@(0),@(self.amount)]];
   
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:1];
    [self.tableView_main reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
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
    static NSString *reuseId = @"CardCellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseId];
        cell.textLabel.textColor = RGB(51, 51, 51);
        cell.detailTextLabel.textColor = RGBA(102, 102, 102, 1);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.textLabel.text = self.arr_data[indexPath.section][indexPath.row];
    NSNumber *money = self.money_array[indexPath.section][indexPath.row];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"￥%.2f",[money floatValue]];
    
    if (indexPath.section == 0 && indexPath.row == self.arr_data.count - 1){
        cell.detailTextLabel.textColor = [UIColor orangeColor];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:20];
    }else if (indexPath.section == 1 && indexPath.row == 0) {
        cell.detailTextLabel.text = nil;
        cell.accessoryView = self.select_btn;
    }else if (indexPath.section == 1 && indexPath.row == 1){
        cell.detailTextLabel.textColor = [UIColor orangeColor];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:20];
    }
    
    return cell;
}

- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
- (CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}


#pragma mark - Request
- (void)requestCommitOrder{
    
    [WLOrderDataHandle requestCommitOrderWithUid:[WLUserInfo share].userId cid:self.cid type:self.type jifen:self.userScore != 0 ? @(self.userScore) : nil success:^(id responseObject) {
        NSDictionary *dict = responseObject;
        if ([dict[@"code"]integerValue] == 1) {
            WLOrderPayViewController *vc = [[WLOrderPayViewController alloc]init];
            vc.amountStr = [NSString stringWithFormat:@"%.2f",self.money];
            vc.needMoney = self.amount;
            vc.orderId = dict[@"id"];
            vc.type = orderPayType;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            [MOProgressHUD showErrorWithStatus:dict[@"msg"]];
        }
    } failure:^(NSError *error) {
         [MOProgressHUD showErrorWithStatus:error.userInfo[@"msg"]];
    }];
}
@end
