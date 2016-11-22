 //
//  WLTzViewController.m
//  MyBoRuiSi
//
//  Created by wsl on 16/8/8.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLTzViewController.h"
#import "WLArticleDetailViewController.h"

#import "ZGArticleCell.h"

#import "WLMyDataHandle.h"
#import "ZGArticleModel.h"


@interface WLTzViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation WLTzViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    _page = 1;
  
    __weak typeof(self) weakSelf = self;
    [self.tableView addHeaderWithCallback:^{
        weakSelf.page = 1;
        [weakSelf requestGetFavListWithPage:weakSelf.page];
        
    }];
    
    [self.tableView addFooterWithCallback:^{
        weakSelf.page += 1;
        [weakSelf requestGetFavListWithPage:weakSelf.page];
        
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
    ZGArticleViewModel *vModel = [self.dataSource objectAtIndex:indexPath.row];
    return  vModel.cellHeight;

}

//返回组头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.1 ;
}
//返回cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *deteID = @"ZGArticleCell";
    ZGArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:deteID];
    if (cell == nil) {
        cell = [[ZGArticleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:deteID];
    }
    cell.articleViewModel = self.dataSource[indexPath.row];
    
    return cell;
}

#pragma mark 点击cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ZGArticleViewModel *articleViewModel = self.dataSource[indexPath.row];
    WLArticleDetailViewController *vc  = [[WLArticleDetailViewController alloc]init];
    vc.articleId = articleViewModel.article.id;
    [self.navigationController pushViewController:vc animated:YES];
    
}


#pragma mark - Request
- (void)requestGetFavListWithPage:(NSInteger )page{
    [WLMyDataHandle requestGetFavListWithUid:[WLUserInfo share].userId page:@(page) type:@(1) success:^(id responseObject) {
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
