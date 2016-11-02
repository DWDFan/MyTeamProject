//
//  WLReplyViewController.m
//  MyBoRuiSi
//
//  Created by wsl on 16/8/6.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLReplyViewController.h"
#import "WLreplTableViewCell.h"
#import "WLArticleDetailViewController.h"


#import "WLMyDataHandle.h"
#import "WLReplyModel.h"

#import "MJRefresh.h"
@interface WLReplyViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation WLReplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _page = 1;
    
    __weak typeof(self) weakSelf = self;
    [self.tableView addHeaderWithCallback:^{
        weakSelf.page = 1;
        [weakSelf requestGetReplyWithPage:weakSelf.page];
    }];
    
    [self.tableView addFooterWithCallback:^{
        weakSelf.page += 1;
        [weakSelf requestGetReplyWithPage:weakSelf.page];
        
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
//返回多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //#warning Incomplete implementation, return the number of sections
    return 1;
}
//返回多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return self.dataSource.count;
}


//cell高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 135;
}

//返回组头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.1 ;
}
//返回cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *deteID = @"WLreplTableViewCell";
    
    WLreplTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:deteID];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:deteID owner:nil options:nil] lastObject];
    }
    cell.model = self.dataSource[indexPath.row];
    
    return cell;
}

#pragma mark 点击cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //帖子详情
    WLArticleDetailViewController *car = [[WLArticleDetailViewController alloc]init];
    WLReplyModel *model = self.dataSource[indexPath.row];
    car.articleId = model.id;
    [self.navigationController pushViewController:car animated:YES];
    
    
}

#pragma mark - Request
- (void)requestGetReplyWithPage:(NSInteger)page{
    [WLMyDataHandle requestGetReplyWithUid:[WLUserInfo share].userId page:@(page) success:^(id responseObject) {
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
