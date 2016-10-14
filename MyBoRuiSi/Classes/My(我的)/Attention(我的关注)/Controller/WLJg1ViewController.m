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
    [self requestGetMyFollowJsWithPage:_page];
    
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
    
    //机构详情
    WLorganVC *vc = [[WLorganVC alloc]init];
    WLMyAttentionModel *model = self.dataSource[indexPath.row];
    vc.institutionId = model.tid;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Request
- (void)requestGetMyFollowJsWithPage:(NSInteger )page{
    [WLMyDataHandle requestGetMyFollowJsWithUid:[WLUserInfo share].userId page:@(page) success:^(id responseObject) {
        self.dataSource = responseObject;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
    
}

@end
