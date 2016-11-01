//
//  WLJs1ViewController.m
//  MyBoRuiSi
//
//  Created by wsl on 16/8/7.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLJs1ViewController.h"
#import "WLDetailsViewController.h"

#import "WLjs1TableViewCell.h"

#import "WLMyDataHandle.h"
#import "WLMyAttentionModel.h"
@interface WLJs1ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation WLJs1ViewController

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
    
    [self.tableView headerBeginRefreshing];

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
    
    
    static NSString *deteID = @"WLjs1TableViewCell";
    
    WLjs1TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:deteID];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:deteID owner:nil options:nil] lastObject];
    }
    cell.model = self.dataSource[indexPath.row];
    
    return cell;
}

#pragma mark 点击cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    WLDetailsViewController *det = [[WLDetailsViewController alloc]init];
    WLMyAttentionModel *model = self.dataSource[indexPath.row];
    det.teacherId = model.tid;
    [self.navigationController pushViewController:det animated:YES];
}


#pragma mark - Request
- (void)requestGetMyFollowJsWithPage:(NSInteger )page{
    [WLMyDataHandle requestGetMyFollowJsWithUid:[WLUserInfo share].userId page:@(page) success:^(id responseObject) {
        if (page == 1) {
            self.dataSource = responseObject;
            [self.tableView headerEndRefreshing];
        }else{
            [self.dataSource addObjectsFromArray:responseObject];
            [self.tableView footerEndRefreshing];
        }
        
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
