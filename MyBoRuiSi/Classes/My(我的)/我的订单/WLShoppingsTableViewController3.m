//
//  WLShoppingsTableViewController3.m
//  MyBoRuiSi
//
//  Created by 莫瑞伟 on 16/8/4.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLShoppingsTableViewController3.h"
#import "WLOrderCell.h"
#import "WLOrderDetailsViewController.h"

#import "WLOrderDataHandle.h"
#import "WLOrderModel.h"
#import "WLShopCarModel.h"
@interface WLShoppingsTableViewController3 ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView_main;
@property (nonatomic,assign) BOOL isOpen;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) NSInteger page;
@end

@implementation WLShoppingsTableViewController3

- (void)viewDidLoad {
    [super viewDidLoad];
    //监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadDataShopTalbeView:) name:@"kReloadDataShopTableView" object:nil];
    
    //request
    _page = 1;
    [self requestGePayedWithPage:@(self.page)];
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Getter
- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray array] init];
    }
    return _dataSource;
}

#pragma mark - Implementation Notification
- (void)reloadDataShopTalbeView:(NSNotification *)noti{
    _page = 1;
    [self requestGePayedWithPage:@(self.page)];
}

//- (void)openOption
//{
//    NSLog(@"打开 3");
//    self.isOpen = YES;
//    [self.tableView_main reloadData];
//}
//- (void)offOption
//{
//    NSLog(@"关闭 3");
//    self.isOpen = NO;
//    [self.tableView_main reloadData];
//}
//MARK:tableView代理方法----------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
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
    
    WLOrderModel *payModel = self.dataSource[indexPath.row];
    cell.shopCarModel = payModel.info;
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
    vc.arr_title = [NSMutableArray arrayWithArray:@[@" 订单状态 : 待评价",@" 订单详情"]];
    vc.str_button = @"写评论";
    
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{//请求数据源提交的插入或删除指定行接收者。
    if (editingStyle ==UITableViewCellEditingStyleDelete) {//如果编辑样式为删除样式
        //request delete order
        WLOrderModel *model = self.dataSource[indexPath.row];
        [self deleteOrderWithOid:model.id indexPath:indexPath];
    }
}


#pragma mark - Request
- (void)requestGePayedWithPage:(NSNumber *)page{
    [WLOrderDataHandle requestGetPayedWithUid:[WLUserInfo share].userId page:page success:^(id responseObject) {
        NSDictionary *dict = responseObject;
        if ([dict[@"code"]integerValue] == 1) {
            NSArray *arrayData = dict[@"data"];
            [arrayData enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSDictionary *dictData = arrayData[idx];
                WLOrderModel *orderModel = [WLOrderModel mj_objectWithKeyValues:dictData];
                WLShopCarModel *shopCarModel = [WLShopCarModel mj_objectWithKeyValues:dictData[@"info"][0]];
                orderModel.info = shopCarModel;
                [self.dataSource addObject:orderModel];
            }];
            [self.tableView_main reloadData];
            
        }else {
            [MOProgressHUD showErrorWithStatus:dict[@"msg"]];
            [MOProgressHUD dismissWithDelay:1];
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)deleteOrderWithOid:(NSString *)oid indexPath:(NSIndexPath *)indexPath{
    [WLOrderDataHandle requestDelOrderWithUid:[WLUserInfo share].userId oid:oid success:^(id responseObject) {
        NSDictionary *dict = responseObject;
        if ([dict[@"code"]integerValue] == 1) {
            [self.dataSource removeObjectAtIndex:indexPath.row];
            [self.tableView_main deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }else {
            [MOProgressHUD showErrorWithStatus:dict[@"msg"]];
        }
    } failure:^(NSError *error) {
        
    }];
}
@end
