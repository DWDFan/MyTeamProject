//
//  WLnewsViewController.m
//  MyBoRuiSi
//
//  Created by wsl on 16/8/6.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLnewsViewController.h"
#import "WLnewsTableViewCell.h"

#import "WLXtnewsViewController.h"

#import "WLSystemMsgModel.h"
#import "WLMyDataHandle.h"

#import "MJRefresh.h"
@interface WLnewsViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation WLnewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _page = 1;
   
    __weak typeof(self) weakSelf = self;
    [self.tableView addHeaderWithCallback:^{
        weakSelf.page = 1;
        [weakSelf requestGetMsgWithPage:weakSelf.page];
    }];
    
    [self.tableView addFooterWithCallback:^{
        weakSelf.page += 1;
        [weakSelf requestGetMsgWithPage:weakSelf.page];

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
    return 65;
}

//返回组头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.1 ;
}
//返回cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *deteID = @"WLnewsTableViewCell";
    
    WLnewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:deteID];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:deteID owner:nil options:nil] lastObject];
    }
    
    cell.model = self.dataSource[indexPath.row];
    
    return cell;
}

#pragma mark 点击cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WLSystemMsgModel *model = self.dataSource[indexPath.row];
    //系统消息
    WLXtnewsViewController *xt = [[WLXtnewsViewController alloc]init];
    xt.infoId = model.id;
    [self.navigationController pushViewController:xt animated:YES];
    
    model.read = YES;
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}


#pragma mark - Request
- (void)requestGetMsgWithPage:(NSInteger)page{
    [WLMyDataHandle requestGetMsgWithUid:[WLUserInfo share].userId page:@(page) type:@"system" success:^(id responseObject) {
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
