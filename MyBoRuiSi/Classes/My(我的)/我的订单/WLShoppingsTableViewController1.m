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
#import "WLCourseDetailViewController.h"

#import "WLOrderDataHandle.h"
#import "WLShopCarModel.h"

#import "MJExtension.h"
@interface WLShoppingsTableViewController1 ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView_main;

@property (nonatomic,assign) BOOL isOpen;
@property (weak, nonatomic) IBOutlet UIButton *button_OptionAll;
@property (weak, nonatomic) IBOutlet UILabel *amount_lab;
@property (weak, nonatomic) IBOutlet UIButton *balance_btn;


//@property (nonatomic, strong) WLShopCarModel *shopCarModel;

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *selectDataArray; //选中购物车数据
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
- (NSMutableArray *)selectDataArray{
    if (!_selectDataArray) {
        _selectDataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _selectDataArray;
}


#pragma mark - Event Response
- (IBAction)clickOK:(id)sender {
    if (self.sumSelect <= 0) return;
    WLAddOrderViewController *vc = [[WLAddOrderViewController alloc]init];
    vc.dataSource = self.selectDataArray;
    vc.money = (float)self.amount;
    vc.type = @"kecheng";
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)clickAll:(UIButton *)sender {
    if (!self.dataSource.count) return;
    
    //clean selectDataArray all
    [self.selectDataArray removeAllObjects];
    
    if (!sender.selected) {
        sender.selected = YES;
        self.amount = 0;
        self.sumSelect = 0;
        self.sumSelect = self.dataSource.count;
        
        for (WLShopCarModel *model in self.dataSource) {
            model.select = YES;
            if ([model.vipFree isEqualToNumber:@1] && [WLUserInfo share].vip) {
                 self.amount += 0;
            }else{
                self.amount += model.disPrice ? [model.disPrice integerValue] : [model.price integerValue];
            }
            
            //add all model in selectDataArray
            [self.selectDataArray addObject:model];
        }
        self.amount_lab.text = [NSString stringWithFormat:@"%zd",self.amount];
        [self.balance_btn setTitle:[NSString stringWithFormat:@"结算(%zd)",self.sumSelect] forState:UIControlStateNormal];
        self.balance_btn.backgroundColor = color_red;

    }
    else{
        sender.selected = NO;
        self.amount = 0;
        self.sumSelect = 0;
        for (WLShopCarModel *model in self.dataSource) {
            model.select = NO;
        }
        self.amount_lab.text = [NSString stringWithFormat:@"%zd",self.amount];
        [self.balance_btn setTitle:@"结算" forState:UIControlStateNormal];
         self.balance_btn.backgroundColor = RGB(193, 193, 193);
    }
    [self.tableView_main reloadData];
    
}

#pragma mark - Implementation Notification
- (void)reloadDataShopTalbeView:(NSNotification *)noti{
    _amount = 0;
    _sumSelect = 0;
    _page = 1;
    [self requestGetCarWithPage:@(self.page)];
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
    cell.isOpen = YES;
    cell.shopCarModel = self.dataSource[indexPath.row];
    
    //选中事件回调
    __weak typeof(self) weakSelf = self;
    cell.selectBalanceBlock = ^(NSInteger price,BOOL isSelect, WLShopCarModel *shopCarModel){
        if (isSelect) {
            weakSelf.amount += price;
            weakSelf.amount_lab.text = [NSString stringWithFormat:@"%zd",weakSelf.amount];
            
            weakSelf.sumSelect += 1;
            [weakSelf.balance_btn setTitle:[NSString stringWithFormat:@"结算(%zd)",weakSelf.sumSelect] forState:UIControlStateNormal];
            weakSelf.balance_btn.backgroundColor = color_red;
            
            //购物id加入容器
            [self.selectDataArray addObject:shopCarModel];
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
            [self.selectDataArray removeObject:shopCarModel];
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
    /*
    WLShopCarModel *model = self.dataSource[indexPath.row];
    WLCourseDetailViewController *vc = [[WLCourseDetailViewController alloc] init];
    vc.courseId = model.id;
    [self.navigationController pushViewController:vc animated:YES];
     */
    
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{//请求数据源提交的插入或删除指定行接收者。
    if (editingStyle ==UITableViewCellEditingStyleDelete) {//如果编辑样式为删除样式
        //request delete shopcar
        WLShopCarModel *model = self.dataSource[indexPath.row];
        [self requestDeleteShopCarWithCid:model.id indexPath:indexPath];
    }
}

#pragma mark - Request
- (void)requestGetCarWithPage:(NSNumber *)page{
    //clean dataSource
    [self.dataSource removeAllObjects];
    [WLOrderDataHandle requestGetCartWithUid:[WLUserInfo share].userId page:page success:^(id responseObject) {
        NSDictionary *dict = responseObject;
        if ([dict[@"code"]integerValue] == 1) {
            NSArray *arrayData = dict[@"data"];
            [arrayData enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSDictionary *dictData = arrayData[idx];
                WLShopCarModel *shopCarModel = [WLShopCarModel mj_objectWithKeyValues:dictData];
                [self.dataSource addObject:shopCarModel];
            }];
            [self.tableView_main reloadData];
            
        }else {
            [MOProgressHUD showErrorWithStatus:dict[@"msg"]];
            [MOProgressHUD dismissWithDelay:1];
        }
    } failure:^(NSError *error) {
        [MOProgressHUD showErrorWithStatus:error.localizedFailureReason];
    }];
}

- (void)requestDeleteShopCarWithCid:(NSString *)cid indexPath:(NSIndexPath *)indexPath{
    [WLOrderDataHandle requestDelCarWithUid:[WLUserInfo share].userId cid:cid success:^(id responseObject) {
        NSDictionary *dict = responseObject;
        if ([dict[@"code"]integerValue] == 1) {
            [self.dataSource removeObjectAtIndex:indexPath.row];
            [self.tableView_main deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"kReloadDataShopTableView" object:nil];
        }else {
           [MOProgressHUD showErrorWithStatus:dict[@"msg"]];
        }

    } failure:^(NSError *error) {
        [MOProgressHUD showErrorWithStatus:error.localizedFailureReason];
    }];
}
@end
