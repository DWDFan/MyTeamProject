//
//  WLForumTableViewController.m
//  MyBoRuiSi
//
//  Created by wsl on 16/8/1.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLForumTableViewController.h"
#import "WLArticleDetailViewController.h"
#import "SDCycleScrollView.h"
#import "SDCollectionViewCell.h"

#import "WLCurriculumTableViewCell.h"
#import "ZGArticleCell.h"
#import "WLFindDataHandle.h"

#import "WLBBSAdModel.h"
#import "ZGArticleModel.h"

@interface WLForumTableViewController ()<SDCycleScrollViewDelegate>

@property (nonatomic, strong) NSArray *adsArray;
@property (nonatomic, strong) NSMutableArray *hotsArray;
@property (nonatomic, strong) SDCycleScrollView *sycleView;

@end

@implementation WLForumTableViewController

- (NSMutableArray *)hotsArray{
    
    if (!_hotsArray) {
        _hotsArray = [NSMutableArray array];
    }
    return _hotsArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //图片轮播器
    SDCycleScrollView *sycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, Swidth, 210) delegate:self placeholderImage:PHOTO_PLACE];
    _sycleView = sycleView;
    self.tableView.tableHeaderView = _sycleView;

    [self requestData];
}

- (void)requestData
{
    [WLFindDataHandle requestFindBBSAdsSuccess:^(id responseObject) {
        
        _adsArray = [WLBBSAdModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        NSMutableArray *images = [NSMutableArray arrayWithCapacity:0];
        for (WLBBSAdModel *ad in _adsArray) {
            [images addObject:ad.image ? ad.image : @""];
        }
        _sycleView.imageURLStringsGroup = images;
        
    } failure:^(NSError *error) {
        
    }];
    
    [WLFindDataHandle requestFindBBSHotsSuccess:^(id responseObject) {
        
        NSArray *articles = [ZGArticleModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        for (ZGArticleModel *art in articles) {
            ZGArticleViewModel *artVM = [[ZGArticleViewModel alloc] init];
            artVM.article = art;
            [self.hotsArray addObject:artVM];
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - Table view data source

//返回多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _hotsArray.count;
}


//cell高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZGArticleViewModel *article = _hotsArray[indexPath.row];
    return article.cellHeight;
}

//返回组头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10 ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.000001;
}
//返回cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *deteID = @"ZGArticleCell";
    
    ZGArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:deteID];
    
    if (cell == nil) {
        cell = [[ZGArticleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:deteID];
        cell.type = ZGArticleCellTypeList;
    }
    cell.articleViewModel = _hotsArray[indexPath.row];
    return cell;
}

#pragma mark 点击cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    WLArticleDetailViewController *detailVC = [[WLArticleDetailViewController alloc] init];
    ZGArticleViewModel *artVM = _hotsArray[indexPath.row];
    detailVC.articleViewModel = artVM;
    detailVC.articleId = artVM.article.tid;
    [self.navigationController pushViewController:detailVC animated:YES];
}




@end
