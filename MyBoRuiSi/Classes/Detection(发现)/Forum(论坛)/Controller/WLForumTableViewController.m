//
//  WLForumTableViewController.m
//  MyBoRuiSi
//
//  Created by wsl on 16/8/1.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLForumTableViewController.h"
#import "SDCycleScrollView.h"
#import "SDCollectionViewCell.h"

#import "WLCurriculumTableViewCell.h"
#import "WLcardTableViewCell.h"

@interface WLForumTableViewController ()<SDCycleScrollViewDelegate>

@end

@implementation WLForumTableViewController

//懒加载
- (NSMutableArray *)array{
    
    if (!_array) {
        _array = [NSMutableArray array];
    }
    return _array;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
        
    
   
    
    //图片轮播器
    SDCycleScrollView *scrollview = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, Swidth, 210) delegate:self placeholderImage:[UIImage imageNamed:@"图层-50_88"]];
    
    scrollview.imageURLStringsGroup = @[  @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                          @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                          @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"];
    
    
    
    self.tableView.tableHeaderView = scrollview;
    
    //tableView偏移量
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);


}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


//返回多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //#warning Incomplete implementation, return the number of sections
    return 1;
}
//返回多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return 4;
}


//cell高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 310;
}

//返回组头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10 ;
}
//返回cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *deteID = @"WLcardTableViewCell";
    
    WLcardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:deteID];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:deteID owner:nil options:nil] lastObject];
    }
    
    
    return cell;
}

#pragma mark 点击cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}




@end
