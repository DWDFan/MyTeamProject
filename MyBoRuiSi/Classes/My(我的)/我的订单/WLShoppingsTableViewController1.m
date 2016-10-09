//
//  WLShoppingsTableViewController1.m
//  MyBoRuiSi
//
//  Created by 莫瑞伟 on 16/8/4.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLShoppingsTableViewController1.h"
#import "WLOrderCell.h"
#import "WLOrderDetailsViewController.h"
#import "WLAddOrderViewController.h"
#import "WLOrderPayViewController.h"

#import "WLOrderDataHandle.h"
#import "WLOrderModel.h"

#import "MJExtension.h"
@interface WLShoppingsTableViewController1 ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView_main;

@property (nonatomic,assign) BOOL isOpen;
@property (weak, nonatomic) IBOutlet UIButton *button_OptionAll;
@property (weak, nonatomic) IBOutlet UILabel *amount_lab;
@property (weak, nonatomic) IBOutlet UIButton *balance_btn;


@property (nonatomic, strong) WLOrderModel *orderModel;

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *arrayCid; //选中购物车ID 容器
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger amount;//总额
@property (nonatomic, assign) NSInteger sumSelect;//结算选中总数
@end

@implementation WLShoppingsTableViewController1

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _amount = 0;
    _sumSelect = 0;
    _page = 1;
    [self requestGetCarWithPage:@(self.page)];

}

#pragma mark - Getter
- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray array] init];
    }
    return _dataSource;
}
- (NSMutableArray *)arrayCid{
    if (!_arrayCid) {
        _arrayCid = [[NSMutableArray array] init];
    }
    return _arrayCid;
}

#pragma mark - Event Response
- (IBAction)clickOK:(id)sender {
    if (self.sumSelect <= 0) return;
    WLAddOrderViewController *vc = [[WLAddOrderViewController alloc]init];
    vc.money = [NSString stringWithFormat:@"%zd.00",self.amount];
    vc.cid = [self.arrayCid componentsJoinedByString:@"|"];
    vc.type = @"kecheng";
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)clickAll:(UIButton *)sender {
    //clean arraycid all cid
    [self.arrayCid removeAllObjects];
    
    if (!sender.selected) {
        sender.selected = YES;
        self.amount = 0;
        self.sumSelect = 0;
        self.sumSelect = self.dataSource.count;
        
        for (WLOrderModel *model in self.dataSource) {
            model.select = YES;
            self.amount += [model.price integerValue];
            
            //add all cid in arraycid
            [self.arrayCid addObject:model.id];
        }
        self.amount_lab.text = [NSString stringWithFormat:@"%zd",self.amount];
        [self.balance_btn setTitle:[NSString stringWithFormat:@"结算(%zd)",self.sumSelect] forState:UIControlStateNormal];
        self.balance_btn.backgroundColor = color_red;

    }
    else{
        sender.selected = NO;
        self.amount = 0;
        self.sumSelect = 0;
        for (WLOrderModel *model in self.dataSource) {
            model.select = NO;
        }
        self.amount_lab.text = [NSString stringWithFormat:@"%zd",self.amount];
        [self.balance_btn setTitle:@"结算" forState:UIControlStateNormal];
    }
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
    cell.orderModer = self.dataSource[indexPath.row];
    cell.isOpen = YES;
    
    //选中事件回调
    __weak typeof(self) weakSelf = self;
    cell.selectBalanceBlock = ^(NSInteger price,BOOL isSelect, NSString *cid){
        if (isSelect) {
            weakSelf.amount += price;
            weakSelf.amount_lab.text = [NSString stringWithFormat:@"%zd",weakSelf.amount];
            
            weakSelf.sumSelect += 1;
            [weakSelf.balance_btn setTitle:[NSString stringWithFormat:@"结算(%zd)",weakSelf.sumSelect] forState:UIControlStateNormal];
            weakSelf.balance_btn.backgroundColor = color_red;
            
            //购物id加入容器
            [self.arrayCid addObject:cid];
        }else{
            weakSelf.amount -= price;
            weakSelf.amount_lab.text = [NSString stringWithFormat:@"%zd",weakSelf.amount];
            
            weakSelf.sumSelect -= 1;
            if (weakSelf.sumSelect <= 0) {
                [weakSelf.balance_btn setTitle:@"结算" forState:UIControlStateNormal];
                weakSelf.balance_btn.backgroundColor = RGB(193, 193, 193);
            }else{
                [weakSelf.balance_btn setTitle:[NSString stringWithFormat:@"结算(%zd)",weakSelf.sumSelect] forState:UIControlStateNormal];
                weakSelf.balance_btn.backgroundColor = color_red;
            }
            //购物id移除容器
            [self.arrayCid removeObject:cid];
        }
    };
    
    //直接付款回调
    __weak typeof(WLOrderCell *) weakCell = cell;
    cell.payBlock = ^(NSInteger price){
        WLAddOrderViewController *vc = [[WLAddOrderViewController alloc]init];
        vc.money = [NSString stringWithFormat:@"%zd.00",price];
        vc.cid = weakCell.orderModer.id;
        vc.type = @"kecheng";
        [self.navigationController pushViewController:vc animated:YES];
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
    
    WLOrderDetailsViewController *vc = [[WLOrderDetailsViewController alloc]init];
    vc.arr_details = [NSMutableArray arrayWithArray:@[@"12345678",@"2015-0809",@"￥200.0",@"10.00",@"190.0"]];
    vc.arr_data = [NSMutableArray arrayWithArray:@[@[@""],@[@"订单号 :",@"付款时间 :",@"总价 :",@"积分抵扣 :",@"实际总价 :"]]];
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{//请求数据源提交的插入或删除指定行接收者。
    if (editingStyle ==UITableViewCellEditingStyleDelete) {//如果编辑样式为删除样式
#warning Beelin bug 请求删除
        [self.dataSource removeObjectAtIndex:indexPath.row];
        [self.tableView_main deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
}

#pragma mark - Request
- (void)requestGetCarWithPage:(NSNumber *)page{
    [WLOrderDataHandle requestGetCartWithUid:[WLUserInfo share].userId page:page success:^(id responseObject) {
        NSDictionary *dict = responseObject;
        if ([dict[@"code"]integerValue] == 1) {
            NSArray *arrayData = dict[@"data"];
            [arrayData enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSDictionary *dictData = arrayData[idx];
                _orderModel = [WLOrderModel mj_objectWithKeyValues:dictData];
                [self.dataSource addObject:self.orderModel];
            }];
            [self.tableView_main reloadData];
            
        }else {
            [MOProgressHUD showErrorWithStatus:dict[@"msg"]];
            [MOProgressHUD dismissWithDelay:1];
        }
    } failure:^(NSError *error) {
        
    }];
}


@end
