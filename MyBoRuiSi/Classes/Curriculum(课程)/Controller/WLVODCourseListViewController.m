//
//  WLVODCourseListViewController.m
//  MyBoRuiSi
//
//  Created by Catskiy on 16/9/27.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLVODCourseListViewController.h"
#import "WLCourseListCell.h"
#import "WLFilterView.h"
#import "WLHomeDataHandle.h"
#import "WLCourseDataHandle.h"
#import "WLCourceModel.h"
#import "KxMenu.h"

@interface WLVODCourseListViewController ()<WLFilterViewDelegate>

@property (nonatomic, strong) WLFilterView *filterView;
@property (nonatomic, strong) NSArray *courses;
@property (nonatomic, strong) NSArray *filterArray;
@property (nonatomic, strong) NSString *saleNumOrder;         // 销量
@property (nonatomic, strong) NSString *priceOrder;

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
    
    [self setNavigationBarStyleDefultWithTitle:@"在线点播"];
    
    _saleNumOrder = @"desc";
    _priceOrder = @"";
}

- (void)requestData
{
    [WLHomeDataHandle requestSearchCourseWithNum:@10 page:@1 key:@"" type:@0 ppid:@"" priceOrder:_priceOrder zbstatus:@1 saleNum:_saleNumOrder level:@0 success:^(id responseObject) {
        
        _courses = [WLCourceModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
    
    [WLCourseDataHandle requestCourseFilterSuccess:^(id responseObject) {
        
        _filterArray = responseObject[@"data"][@"sort"];
    } failure:^(NSError *error) {
        
    }];
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
        
    }else if (index == 1) {         // 价格
        
        _saleNumOrder = @"";
        if (isChange) {
            _priceOrder = @"asc";
        }else {
            [_priceOrder isEqualToString:@"desc"] ? (_priceOrder = @"asc") : (_priceOrder = @"desc");
            [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"sort_price_%@",_priceOrder]] forState:UIControlStateSelected];
        }
        
    }else {
        
        NSMutableArray *menus = [NSMutableArray arrayWithCapacity:0];
        for (int i = 0; i < _filterArray.count; i ++) {
            
            [menus addObject:[KxMenuItem menuItem:_filterArray[i][@"type"] image:nil target:self action:@selector(kxMenuAction:)]];
        }
        NSArray *menuItems = menus;
        [KxMenu setTitleFont:[UIFont systemFontOfSize:14]];
        [KxMenu showMenuInView:self.view fromRect:CGRectMake(WLScreenW-60, 45, 0, 0) menuItems:menuItems dismissBlock:^{
            
        }];
    }
    [self requestData];
}

- (void)kxMenuAction:(id)sender
{
    
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

@end
