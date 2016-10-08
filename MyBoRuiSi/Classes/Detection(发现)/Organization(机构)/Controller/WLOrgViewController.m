//
//  WLOrgViewController.m
//  MyBoRuiSi
//
//  Created by wsl on 16/8/2.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLOrgViewController.h"
#import "WLFindInstitutioListCell.h"
#import "WLorganVC.h"
#import "WLSortSelectView.h"
#import "WLFindDataHandle.h"
#import "RecommendationModelll.h"
#import "KxMenu.h"

@interface WLOrgViewController ()<WLSortSelectViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) UIButton *levelBtn;
@property (nonatomic, strong) NSString *sort;
@property (nonatomic, strong) NSString *gsType;
@property (nonatomic, strong) NSArray *institutionsArray;
@property (nonatomic, strong) NSArray *filtersArray;

@end

@implementation WLOrgViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
    btn.backgroundColor = [UIColor clearColor];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setImage:[UIImage imageNamed:@"图层-47"] forState:UIControlStateNormal];
    [btn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
    [btn setTitle:@"机构" forState:UIControlStateNormal];
    self.navigationItem.titleView = btn;
    [self.navigationController.navigationBar setBackgroundImage:[MOTool createImageWithColor:RGBA(255, 255, 255, 1)] forBarMetrics:UIBarMetricsDefault];
    
    self.tableView.tableFooterView = [UIView new];
    
    WLSortSelectView *sortView = [[WLSortSelectView alloc] initWithFrame:CGRectMake(0, 0, WLScreenW, 40)];
    sortView.titlesArray = @[@"企业规模",@"企业性质",@"关注度"];
    sortView.delegate = self;
    [self.view addSubview:sortView];
    _filtersArray = @[@"私企",@"国企",@"其他"];

    [self requestData];
}

- (void)requestData
{
    [WLFindDataHandle requestFindInstitutionListWithSort:_sort gsType:_gsType success:^(id responseObject) {
        
        _institutionsArray = [RecommendationModelll mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

- (void)selectViewDidselectedItem:(UIButton *)button
{
    button.selected = YES;
    NSInteger index = button.tag - 1000;
    
    switch (index) {
        case 0:
        {
            _sort = @"member";
            [self requestData];
        }
            break;
        case 1:
        {
            _levelBtn = button;
            NSMutableArray *menus = [NSMutableArray arrayWithCapacity:0];
            for (NSInteger i = 0; i < _filtersArray.count; i ++) {
                
                KxMenuItem *item = [KxMenuItem menuItem:_filtersArray[i] image:nil target:self action:@selector(kxMenuAction:)];
                item.tag = i;
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
    _gsType = _filtersArray[index];
//    if (index == 2) {
//        _gsType = @"";
//    }
    [self requestData];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _institutionsArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *deteID = @"WLOrganizatioTableViewCell";
    
    WLFindInstitutioListCell *cell = [tableView dequeueReusableCellWithIdentifier:deteID];
    
    if (cell == nil) {
        cell = [[WLFindInstitutioListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:deteID];
    }
    cell.institution = _institutionsArray[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}



//点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //机构详情
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    WLorganVC *details = [[WLorganVC alloc]init];
    details.institutionId = [_institutionsArray[indexPath.row] id];
    [self.navigationController pushViewController:details animated:YES];
    
    
}



@end
