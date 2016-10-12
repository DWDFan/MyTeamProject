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
@interface WLShoppingsTableViewController4 ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView_main;
@property (weak, nonatomic) IBOutlet UIButton *delete_btn;
@property (weak, nonatomic) IBOutlet UIButton *allSelect_btn;

@property (nonatomic,assign) BOOL isOpen;

@property (nonatomic, strong) WLShopCarModel *shopCarModer;

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *arrayOid; //选中关闭订单ID 容器
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger selectCount;//选中个数
@end

@implementation WLShoppingsTableViewController4

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _isOpen = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(editeRowAction:) name:@"kEditingColseOrderNotification" object:nil];
    _page = 1;
    [self requestGetClosePayWithPage:@(self.page)];
    
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
- (NSMutableArray *)arrayOid{
    if (!_arrayOid) {
        _arrayOid = [[NSMutableArray array] init];
    }
    return _arrayOid;
}

#pragma mark - Event Response
- (IBAction)allSelectAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    //clean arraycid all cid
    [self.arrayOid removeAllObjects];

    //控制 right_item 编辑与取消状态
    if (self.allSelectBlock) {
        self.allSelectBlock();
    }
    
    if(sender.selected){ //全选状态
        for (WLOrderModel *model in self.dataSource) {
          
            //add all cid in arraycid
            [self.arrayOid addObject:model.id];
        }
        self.selectCount = self.dataSource.count;
        [self.delete_btn setTitle:[NSString stringWithFormat:@"删除(%zd)",self.selectCount] forState:UIControlStateNormal];
        self.delete_btn.backgroundColor = color_red;
    }else{//全选取消状态
        for (WLOrderModel *model in self.dataSource) {
          
        }
        self.selectCount = 0;
        [self.delete_btn setTitle:@"删除" forState:UIControlStateNormal];
        self.delete_btn.backgroundColor = RGB(193, 193, 193);
    }
    [self.tableView_main reloadData];
}

- (IBAction)deleteAction:(UIButton *)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"是否确认删除订单" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}


#pragma mark - Implementation Notifiction
- (void)editeRowAction:(NSNotification *)noti{
    NSDictionary *dict = noti.userInfo;
    self.isOpen = [dict[@"selectState"] boolValue];
    
    //判断通知传参 来控制 全选与删除按钮状态
    if(!self.isOpen){
        //right itme 取消编辑 全选与删除按钮都就置为原始状态
        for (WLOrderModel *model in self.dataSource) {
                  }
        self.selectCount = 0;
        self.allSelect_btn.selected = NO;
        [self.delete_btn setTitle:@"删除" forState:UIControlStateNormal];
        self.delete_btn.backgroundColor = RGB(193, 193, 193);
        
        //clean arraycid all cid
        [self.arrayOid removeAllObjects];
    }
    [self.tableView_main reloadData];
}

#pragma mark - Delegate AlertView
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        //reqeust delete
        NSString *oid = [self.arrayOid componentsJoinedByString:@"|"];
        [self requestCutOrderWithOid:oid];
    }
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
    cell.oid = model.id; //非常有必要，订单id
    //选中事件回调
    __weak typeof(self) weakSelf = self;
    cell.selectDeleteBlock = ^(BOOL isSelect, NSString *oid){
        if (isSelect) {
            weakSelf.selectCount += 1;
            [weakSelf.delete_btn setTitle:[NSString stringWithFormat:@"删除(%zd)",weakSelf.selectCount] forState:UIControlStateNormal];
            weakSelf.delete_btn.backgroundColor = color_red;
            
            //判断是否相等
            if(weakSelf.selectCount == weakSelf.dataSource.count){
                weakSelf.allSelect_btn.selected = YES;
            }
            //购物id加入容器
            [self.arrayOid addObject:oid];
        }else{
            weakSelf.selectCount -= 1;
            weakSelf.allSelect_btn.selected = NO;
            if (weakSelf.selectCount <= 0) {
                [weakSelf.delete_btn setTitle:@"删除" forState:UIControlStateNormal];
                weakSelf.delete_btn.backgroundColor = RGB(193, 193, 193);
            }else{
                [weakSelf.delete_btn setTitle:[NSString stringWithFormat:@"删除(%zd)",weakSelf.selectCount] forState:UIControlStateNormal];
                weakSelf.delete_btn.backgroundColor = color_red;
            }
            //购物id移除容器
            [self.arrayOid removeObject:oid];
        }
    };

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
/* 单行删除
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{//请求数据源提交的插入或删除指定行接收者。
    if (editingStyle ==UITableViewCellEditingStyleDelete) {//如果编辑样式为删除样式
        //request delete order
        WLOrderModel *model = self.dataSource[indexPath.row];
        [self requestCutOrderWithOid:model.id indexPath:indexPath];
    }
}
*/


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

- (void)requestCutOrderWithOid:(NSString *)oid{
    [WLOrderDataHandle requestCutOrderWithUid:[WLUserInfo share].userId oid:oid success:^(id responseObject) {
        NSDictionary *dict = responseObject;
        if ([dict[@"code"]integerValue] == 1) {
            [self requestGetClosePayWithPage:@1];
        }else {
            [MOProgressHUD showErrorWithStatus:dict[@"msg"]];
        }
    } failure:^(NSError *error) {
        
    }];
}
@end
