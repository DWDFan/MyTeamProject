 //
//  WLTzViewController.m
//  MyBoRuiSi
//
//  Created by wsl on 16/8/8.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLTzViewController.h"
#import "WLCardxqViewController.h"

#import "ZGArticleCell.h"

#import "WLMyDataHandle.h"

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
    [self requestGetFavListWithPage:_page];

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
    
    WLCardxqViewController *ca  = [[WLCardxqViewController alloc]init];
    [self.navigationController pushViewController:ca animated:YES];
    
}


#pragma mark - Request
- (void)requestGetFavListWithPage:(NSInteger )page{
    [WLMyDataHandle requestGetFavListWithUid:[WLUserInfo share].userId page:@(page) type:@(1) success:^(id responseObject) {
        self.dataSource = responseObject;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

@end
