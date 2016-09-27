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
#import "WLCourceModel.h"

@interface WLVODCourseListViewController ()<WLFilterViewDelegate>

@property (nonatomic, strong) WLFilterView *filterView;
@property (nonatomic, strong) NSArray *courses;

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
}

- (void)requestData
{
    [WLHomeDataHandle requestSearchCourseWithNum:@10 page:@1 key:@"" type:@0 ppid:@"" priceOrder:@"asc" zbstatus:@1 success:^(id responseObject) {
        
        _courses = [WLCourceModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

- (void)filerViewDidselectedIndex:(NSInteger)index
{
    WLLog(@"%ld",index);
}

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
