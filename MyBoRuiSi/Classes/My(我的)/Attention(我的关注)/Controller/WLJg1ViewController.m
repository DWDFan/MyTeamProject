//
//  WLJg1ViewController.m
//  MyBoRuiSi
//
//  Created by wsl on 16/8/7.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLJg1ViewController.h"
#import "WLjg1TableViewCell.h"

#import "WLorganVC.h"

#import "WLMyDataHandle.h"
#import "WLMyAttentionModel.h"
@interface WLJg1ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation WLJg1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _page = 1;
 
    __weak typeof(self) weakSelf = self;
    [self.tableView addHeaderWithCallback:^{
        weakSelf.page = 1;
        [self requestGetMyFollowJsWithPage:weakSelf.page];
        
    }];
    
    [self.tableView addFooterWithCallback:^{
        weakSelf.page += 1;
        [weakSelf requestGetMyFollowJsWithPage:weakSelf.page];
        
    }];
    
//    [self.tableView headerBeginRefreshing];
    weakSelf.page = 1;
    [self requestGetMyFollowJsWithPage:weakSelf.page];

    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.page = 1;
    [self requestGetMyFollowJsWithPage:self.page];
}


#pragma mark - Getter
- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}


//返回多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}


//cell高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

//返回组头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.1 ;
}
//返回cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *deteID = @"WLjg1TableViewCell";
    
    WLjg1TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:deteID];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:deteID owner:nil options:nil] lastObject];
    }
    cell.model = self.dataSource[indexPath.row];
    
    return cell;
}

#pragma mark 点击cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    //机构详情
    WLorganVC *vc = [[WLorganVC alloc]init];
    WLMyAttentionModel *model = self.dataSource[indexPath.row];
    vc.institutionId = model.tid;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Request
- (void)requestGetMyFollowJsWithPage:(NSInteger )page{
    [WLMyDataHandle requestGetMyFollowJgWithUid:[WLUserInfo share].userId page:@(page) success:^(id responseObject) {
        if (page == 1) {
            self.dataSource = responseObject;
            [self.tableView headerEndRefreshing];
        }else{
            [self.dataSource addObjectsFromArray:responseObject];
            [self.tableView footerEndRefreshing];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"refleshInstitutionNum"
                                                            object:nil
                                                          userInfo:@{@"num":@(self.dataSource.count)}];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        if (page == 1) {
            [self.tableView headerEndRefreshing];
        }else{
            [self.tableView footerEndRefreshing];
        }
        
    }];
}

@end
