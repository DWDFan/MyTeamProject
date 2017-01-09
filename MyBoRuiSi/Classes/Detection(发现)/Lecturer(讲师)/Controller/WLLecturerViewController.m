//
//  WLLecturerViewController.m
//  MyBoRuiSi
//
//  Created by wsl on 16/8/2.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLLecturerViewController.h"
#import "WLDetailsViewController.h"
#import "WLFindLecturerListCell.h"
#import "WLSortSelectView.h"
#import "WLFindDataHandle.h"
#import "RecommendModell.h"
#import "KxMenu.h"

@interface WLLecturerViewController ()<WLSortSelectViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) WLSortSelectView *sortView;
@property (weak, nonatomic) UIButton *levelBtn;
@property (nonatomic, strong) NSArray *lecturesArray;
@property (nonatomic, strong) NSString *sort;
@property (nonatomic, strong) NSNumber *level;

@end

@implementation WLLecturerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
    btn.backgroundColor = [UIColor clearColor];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setImage:[UIImage imageNamed:@"图层-47"] forState:UIControlStateNormal];
    [btn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
    [btn setTitle:@"讲师" forState:UIControlStateNormal];
    self.navigationItem.titleView = btn;
    
    [self.navigationController.navigationBar setBackgroundImage:[MOTool createImageWithColor:RGBA(255, 255, 255, 1)] forBarMetrics:UIBarMetricsDefault];
    
    self.tableView.tableFooterView = [UIView new];
    [self.tableView addHeaderWithCallback:^{
        [self requestData];
    }];
    
    WLSortSelectView *sortView = [[WLSortSelectView alloc] initWithFrame:CGRectMake(0, 0, WLScreenW, 40)];
    sortView.titlesArray = @[@"好评度",@"讲师等级",@"关注度"];
    sortView.delegate = self;
    [self.view addSubview:sortView];
    _sortView = sortView;
    
    _sort = @"";
//    [self requestData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self requestData];
}

- (void)requestData
{
    [WLFindDataHandle requestFindLectureListWithSort:_sort level:_level success:^(id responseObject) {
        
        _lecturesArray = [RecommendModell mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.tableView headerEndRefreshing];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [self.tableView headerEndRefreshing];
    }];
}


- (void)selectViewDidselectedItem:(UIButton *)button
{
    button.selected = YES;
    NSInteger index = button.tag - 1000;
    
    switch (index) {
        case 0:
        {
            _sort = @"star";
            [self requestData];
        }
            break;
        case 1:
        {
            _levelBtn = button;
            NSArray *filters = @[@"特级讲师",@"高级讲师",@"中级讲师",@"初级讲师"];
            NSMutableArray *menus = [NSMutableArray arrayWithCapacity:0];
            for (NSInteger i = 0; i < filters.count; i ++) {
                
                KxMenuItem *item = [KxMenuItem menuItem:filters[i] image:nil target:self action:@selector(kxMenuAction:)];
                item.tag = 4 - i;
                item.foreColor = COLOR_WORD_BLACK;
                [menus addObject:item];
            }
            NSArray *menuItems = menus;
            [KxMenu setTitleFont:[UIFont systemFontOfSize:14]];
            [KxMenu showMenuInView:self.view fromRect:CGRectMake(WLScreenW/2, 45, 0, 0) menuItems:menuItems dismissBlock:^{
                button.selected = NO;
            }];
        }
            break;
        case 2:
        {
            _sort = @"follow";
            [self requestData];
        }
            break;
        default:
            break;
    }
}

- (void)kxMenuAction:(id)sender
{
    _levelBtn.selected = NO;
    KxMenuItem *item = (KxMenuItem *)sender;
    NSInteger index = item.tag;
    _level = [NSNumber numberWithInteger:index];
    [self requestData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _lecturesArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *deteID = @"WLFindLecturerListCell";
    
    WLFindLecturerListCell *cell = [tableView dequeueReusableCellWithIdentifier:deteID];
    
    if (cell == nil) {
        cell = [[WLFindLecturerListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:deteID];
    }
    cell.lecturer = _lecturesArray[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //教师详情
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    WLDetailsViewController *detailVC = [[WLDetailsViewController alloc]init];
    detailVC.teacherId = [_lecturesArray[indexPath.row] id];
    [self.navigationController pushViewController:detailVC animated:YES];
}

@end
