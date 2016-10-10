//
//  WLShoppingsTableViewController4.m
//  MyBoRuiSi
//
//  Created by 莫瑞伟 on 16/8/4.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLShoppingsTableViewController4.h"
#import "WLOrderCell.h"

#import "WLOrderDataHandle.h"
#import "WLOrderModel.h"
#import "WLShopCarModel.h"
@interface WLShoppingsTableViewController4 ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView_main;
@property (nonatomic,assign) BOOL isOpen;

@property (nonatomic, strong) WLShopCarModel *shopCarModer;

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) NSInteger page;
@end

@implementation WLShoppingsTableViewController4

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _isOpen = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(editeRowAction:) name:@"kEditingColseOrderNotification" object:nil];
    _page = 1;
    [self requestGetClosePayWithPage:@(self.page)];
    
}

#pragma mark - Getter
- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray array] init];
    }
    return _dataSource;
}

#pragma mark - Implementation Notifiction
- (void)editeRowAction:(NSNotification *)noti{
    NSDictionary *dict = noti.userInfo;
    self.isOpen = [dict[@"selectState"] boolValue];
    [self.tableView_main reloadData];
}
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
    WLOrderModel *model = self.dataSource[indexPath.row];
    cell.shopCarModel = model.info;
    
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
    
    
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{//请求数据源提交的插入或删除指定行接收者。
    if (editingStyle ==UITableViewCellEditingStyleDelete) {//如果编辑样式为删除样式
        //request delete order
        WLOrderModel *model = self.dataSource[indexPath.row];
        [self requestCutOrderWithOid:model.id indexPath:indexPath];
    }
}


#pragma mark - Request
- (void)requestGetClosePayWithPage:(NSNumber *)page{
    [WLOrderDataHandle requestGetClosePayWithUid:[WLUserInfo share].userId page:page success:^(id responseObject) {
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
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)requestCutOrderWithOid:(NSString *)oid indexPath:(NSIndexPath *)indexPath{
    [WLOrderDataHandle requestCutOrderWithUid:[WLUserInfo share].userId oid:oid success:^(id responseObject) {
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
