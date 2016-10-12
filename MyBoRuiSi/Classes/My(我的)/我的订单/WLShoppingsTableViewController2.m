//
//  WLShoppingsTableViewController2.m
//  MyBoRuiSi
//
//  Created by 莫瑞伟 on 16/8/4.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLShoppingsTableViewController2.h"
#import "WLOrderPayViewController.h"
#import "WLOrderDetailsViewController.h"

#import "WLOrderCell.h"
#import "WLOrderFooterView.h"

#import "WLOrderDataHandle.h"
#import "WLOrderModel.h"
#import "WLShopCarModel.h"
@interface WLShoppingsTableViewController2 ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView_main;

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) NSInteger page;
@end

@implementation WLShoppingsTableViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _page = 1;
    [self requestGetWaitPayWithPage:@(self.page)];
    
    //监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadDataShopTalbeView:) name:@"kReloadDataShopTableView" object:nil];
    
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
    [self requestGetWaitPayWithPage:@(self.page)];
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     WLOrderModel *waitPayModel = self.dataSource[section];
    return waitPayModel.info.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1 创建可重用cell对象
    static NSString *reuseId = @"WLOrderCell";
    WLOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"WLOrderCell" owner:nil options:nil] lastObject];
    }
    WLOrderModel *waitPayModel = self.dataSource[indexPath.section];
    cell.shopCarModel = waitPayModel.info[indexPath.row];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    //1 创建可重用cell对象
    static NSString *reuseId = @"WLOrderFooterView";
    WLOrderFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:reuseId];
    if (footerView == nil) {
        footerView = [[[NSBundle mainBundle] loadNibNamed:@"WLOrderFooterView" owner:nil options:nil] lastObject];
    }
    footerView.orderModel = self.dataSource[section];
    
    //事件回调
    __weak typeof(self) weakSelf = self;
    footerView.payBlock = ^(NSString *oid, NSString *amount){
        WLOrderPayViewController *vc = [[WLOrderPayViewController alloc]init];
        vc.amountStr = amount;
//        vc.orderName = waitPayModel.info.name;
//        vc.needMoney = waitPayModel.info.disPrice ? [waitPayModel.info.disPrice stringValue] : [waitPayModel.info.price stringValue];
        vc.orderId = oid;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    footerView.detailBlock = ^(NSString *oid){
            WLOrderDetailsViewController *vc = [[WLOrderDetailsViewController alloc]init];
            vc.arr_details = [NSMutableArray arrayWithArray:@[@"12345678",@"2015-0809",@"￥200.0",@"10.00",@"190.0"]];
            vc.arr_data = [NSMutableArray arrayWithArray:@[@[@""],@[@"订单号 :",@"付款时间 :",@"总价 :",@"积分抵扣 :",@"实际总价 :"]]];
            vc.arr_title = [NSMutableArray arrayWithArray:@[@" 订单状态 : 未开始",@" 订单详情"]];
            vc.str_button = @"立即付款";
            [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    footerView.deleteBlock = ^(NSString *oid){
        [weakSelf deleteOrderWithOid:oid];
    };
    return footerView;
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
    return 44;
}



#pragma mark - Request
- (void)requestGetWaitPayWithPage:(NSNumber *)page{
    [WLOrderDataHandle requestGetWaitPayWithUid:[WLUserInfo share].userId page:page success:^(id responseObject) {
        NSDictionary *dict = responseObject;
        if ([dict[@"code"]integerValue] == 1) {
            NSArray *arrayData = dict[@"data"];
            [arrayData enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSDictionary *dictData = arrayData[idx];
                WLOrderModel *orderModel = [WLOrderModel mj_objectWithKeyValues:dictData];
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

- (void)deleteOrderWithOid:(NSString *)oid{
    [WLOrderDataHandle requestDelOrderWithUid:[WLUserInfo share].userId oid:oid success:^(id responseObject) {
        NSDictionary *dict = responseObject;
        if ([dict[@"code"]integerValue] == 1) {
            //刷新
            self.page = 1;
            [self requestGetWaitPayWithPage:@(self.page)];
        }else {
            [MOProgressHUD showErrorWithStatus:dict[@"msg"]];
        }
    } failure:^(NSError *error) {
        
    }];
}
@end
