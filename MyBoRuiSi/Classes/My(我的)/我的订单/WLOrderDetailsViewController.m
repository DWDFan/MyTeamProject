//
//  WLOrderDetailsViewController.m
//  MyBoRuiSi
//
//  Created by 莫瑞伟 on 16/8/6.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLOrderDetailsViewController.h"
#import "WLOrderPayViewController.h"

#import "WLOrderDetailsCell.h"

#import "WLOrderDataHandle.h"
#import "WLOrderDetailModel.h"
@interface WLOrderDetailsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView_main;
@property (weak, nonatomic) IBOutlet UIButton *button_click;

@property (nonatomic,strong) NSMutableArray *arr_data;
@property (nonatomic,strong) NSArray *arr_details;
@property (nonatomic,strong) NSMutableArray *arr_title;
@property (nonatomic, strong) WLOrderDetailModel *orderDetailModel;
@end

@implementation WLOrderDetailsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self initSelf];
    
    if (self.orderDetailType == WLOrderDetailWaitPayType) {
        self.arr_title = [NSMutableArray arrayWithArray:@[@" 订单状态 : 未开始",@" 订单详情"]];
        [self.button_click setTitle:@"立即付款" forState:UIControlStateNormal];
    }else if(self.orderDetailType == WLOrderDetailPayedType){
        self.arr_title = [NSMutableArray arrayWithArray:@[@" 订单状态 : 未开始",@" 订单详情"]];
        [self.button_click setTitle:@"写评论" forState:UIControlStateNormal];
    }else{
        self.arr_title = [NSMutableArray arrayWithArray:@[@" 订单状态 : 已关闭",@" 订单详情"]];
        self.button_click.hidden = YES;
    }
    //request
    [self requestGetOrderDetailWithUid:self.oid];
}

- (void)initSelf{
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
    btn.backgroundColor = [UIColor clearColor];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setImage:[UIImage imageNamed:@"图层-47"] forState:UIControlStateNormal];
    [btn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
    [btn setTitle:@" 订单详情" forState:UIControlStateNormal];
    self.navigationItem.titleView = btn;
}

#pragma mark - Setter
- (NSMutableArray *)arr_data{
    if (!_arr_data) {
        _arr_data =  [NSMutableArray arrayWithArray:@[@[],@[@"订单号 :",@"付款时间 :",@"总价 :",@"积分抵扣 :",@"实际总价 :"]]];
    }
    return _arr_data;
}

#pragma mark - Event Response
- (IBAction)clickAction:(UIButton *)sender {
    if (self.orderDetailType == WLOrderDetailWaitPayType) {
        WLOrderPayViewController *vc = [[WLOrderPayViewController alloc]init];
        vc.amountStr = self.orderDetailModel.realPay;
        vc.orderId = self.oid;
        vc.needMoney = [self.orderDetailModel.realPay floatValue];
        [self.navigationController pushViewController:vc animated:YES];
    }
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
        cell.orderSourceModel = self.orderDetailModel.source[indexPath.row];
        return cell;
    }else{
        static NSString *reuseId = @"cellId";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseId];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            cell.textLabel.textColor = RGBA(51, 51, 51, 1);

            cell.detailTextLabel.textColor = RGBA(102, 102, 102, 1);
            cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
        }
        if (indexPath.row == 4) {
            cell.detailTextLabel.textColor = RGBA(347, 100, 59, 1);
        }
        cell.textLabel.text = self.arr_data[indexPath.section][indexPath.row];
        cell.detailTextLabel.text = self.arr_details[indexPath.row];
         return cell;
    }
   
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

#pragma mark - Request
- (void)requestGetOrderDetailWithUid:(NSString *)uid{
    [WLOrderDataHandle requestGetOrderDetailWithUid:[WLUserInfo share].userId oid:self.oid success:^(id responseObject) {
        NSDictionary *dict = responseObject;
        if ([dict[@"code"]integerValue] == 1) {
            _orderDetailModel = [WLOrderDetailModel mj_objectWithKeyValues:dict[@"data"]];
            NSMutableArray *array = [NSMutableArray arrayWithCapacity:_orderDetailModel.source.count];
            for (int i = 0; i < _orderDetailModel.source.count; i ++) {
                [array addObject:@""];
            }
            [self.arr_data replaceObjectAtIndex:0 withObject:array];
            self.arr_details = @[_orderDetailModel.orderno,
                                 _orderDetailModel.addtime,
                                 [NSString stringWithFormat:@"￥%@.00",_orderDetailModel.total],
                                 [NSString stringWithFormat:@"%@.00",_orderDetailModel.jifen],
                                 [NSString stringWithFormat:@"￥%@.00",_orderDetailModel.realPay]];
            [self.tableView_main reloadData];
        }else {
            [MOProgressHUD showErrorWithStatus:dict[@"msg"]];
        }
        
    } failure:^(NSError *error) {
        
    }];
}
@end
