//
//  WLVODCourseListViewController.m
//  MyBoRuiSi
//
//  Created by Catskiy on 16/9/27.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLVODCourseListViewController.h"
#import "WLCourseDetailViewController.h"
#import "WLCourseListCell.h"
#import "WLHomeDataHandle.h"
#import "WLCourseDataHandle.h"
#import "WLCourceModel.h"
#import "KxMenu.h"

@interface WLVODCourseListViewController ()<WLFilterViewDelegate>

@end

@implementation WLVODCourseListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setSubviews];
    
    [self requestData];
}

- (void)setSubviews
{
    self.filterView = [[WLFilterView alloc] initWithFrame:CGRectMake(0, 0, WLScreenW, 45)];
    self.filterView.delegate = self;
    [self.view addSubview:self.filterView];
    
    self.tableViewStyle = UITableViewStylePlain;
    
    self.tableView.frame = CGRectMake(0, 45, WLScreenW, WLScreenH - IOS7_TOP_Y - 45);
    self.tableView.rowHeight = 100;
    
    [self.tableView addFooterWithTarget:self action:@selector(requestListData)];
    [self setNavigationBarStyleDefultWithTitle:@"在线点播"];
    
    _saleNumOrder = @"desc";
    _priceOrder = @"";
}

- (void)requestData
{
    _page = 1;

    [WLHomeDataHandle requestSearchCourseWithNum:@10 page:@(_page) key:@"" type:@1 ppid:_sortId priceOrder:_priceOrder zbstatus:nil saleNum:_saleNumOrder level:@0 success:^(id responseObject) {
        
        _page == 1 ? [self.courses removeAllObjects] : nil;
        
        NSArray *mArray = [WLCourceModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.courses addObjectsFromArray:mArray];
        [self.tableView footerEndRefreshing];
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
    
    [WLCourseDataHandle requestCourseFilterSuccess:^(id responseObject) {
        
        _filterArray = responseObject[@"data"][@"sort"];
    } failure:^(NSError *error) {
        
    }];
}

- (void)requestListData
{
    _page ++;
    [WLHomeDataHandle requestSearchCourseWithNum:@10 page:@(_page) key:@"" type:@1 ppid:_sortId priceOrder:_priceOrder zbstatus:nil saleNum:_saleNumOrder level:@0 success:^(id responseObject) {
        
        NSArray *mArray = [WLCourceModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.courses addObjectsFromArray:mArray];
        [self.tableView footerEndRefreshing];
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}

- (NSMutableArray *)courses
{
    if (!_courses) {
        _courses = [NSMutableArray arrayWithCapacity:0];
    }
    return _courses;
}

#pragma mark - filterViewDelegate

- (void)filerViewDidselectedButton:(UIButton *)button Index:(NSInteger)index isChange:(BOOL)isChange
{
    WLLog(@"%ld",index);
    
    if (index == 0) {               // 销量
        
        _priceOrder = @"";
        if (isChange) {
            _saleNumOrder = @"desc";
        }else {
            [_saleNumOrder isEqualToString:@"desc"] ? (_saleNumOrder = @"asc") : (_saleNumOrder = @"desc");
        }
        [self requestData];
        
    }else if (index == 1) {         // 价格
        
        _saleNumOrder = @"";
        if (isChange) {
            _priceOrder = @"asc";
        }else {
            [_priceOrder isEqualToString:@"desc"] ? (_priceOrder = @"asc") : (_priceOrder = @"desc");
            [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"sort_price_%@",_priceOrder]] forState:UIControlStateSelected];
        }
        [self requestData];
        
    }else {
        
        if (_filterArray.count == 0) return;
        NSMutableArray *menus = [NSMutableArray arrayWithCapacity:0];
        for (NSInteger i = 0; i < _filterArray.count; i ++) {
            
            KxMenuItem *item = [KxMenuItem menuItem:_filterArray[i][@"type"] image:nil target:self action:@selector(kxMenuAction:)];
            item.tag = i;
            item.foreColor = COLOR_WORD_BLACK;
            [menus addObject:item];
        }
        NSArray *menuItems = menus;
        [KxMenu setTitleFont:[UIFont systemFontOfSize:14]];
        [KxMenu showMenuInView:self.view fromRect:CGRectMake(WLScreenW-60, 45, 0, 0) menuItems:menuItems dismissBlock:^{
            [_filterView setFilterButtonNormal];
        }];
    }
}

- (void)kxMenuAction:(id)sender
{
    [_filterView setFilterButtonNormal];
    KxMenuItem *item = (KxMenuItem *)sender;
    NSInteger index = item.tag;
    _sortId = _filterArray[index][@"id"];
    [self requestData];
}

#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _courses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    WLCourseListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[WLCourseListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.course = _courses[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    WLCourseDetailViewController *vc = [[WLCourseDetailViewController alloc] init];
    vc.courseId = [_courses[indexPath.row] id];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
