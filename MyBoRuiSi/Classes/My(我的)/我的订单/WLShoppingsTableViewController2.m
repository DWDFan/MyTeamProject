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
@interface WLShoppingsTableViewController2 ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView_main;

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, copy) NSString *oid;
@end

@implementation WLShoppingsTableViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView_main.tableFooterView = [[UIView alloc] init];
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


#pragma mark - Delegate AlertView
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        //reqeust delete
        [self deleteOrderWithOid:self.oid];
    }
}

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
        vc.orderId = oid;
        vc.needMoney = amount;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    footerView.detailBlock = ^(NSString *oid){
            WLOrderDetailsViewController *vc = [[WLOrderDetailsViewController alloc]init];
        vc.orderDetailType = WLOrderDetailWaitPayType;
        vc.oid = oid;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    footerView.deleteBlock = ^(NSString *oid){
        weakSelf.oid = oid;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"是否确认删除订单" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
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
    //clean dataSource
    [self.dataSource removeAllObjects];
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
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"kReloadDataShopTableView" object:nil];
        }else {
            [MOProgressHUD showErrorWithStatus:dict[@"msg"]];
        }
    } failure:^(NSError *error) {
        
    }];
}
@end
