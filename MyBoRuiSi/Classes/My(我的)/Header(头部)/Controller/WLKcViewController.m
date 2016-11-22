//
//  WLKcViewController.m
//  MyBoRuiSi
//
//  Created by wsl on 16/8/8.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLKcViewController.h"
#import "WLCourseDetailViewController.h"
#import "WLLiveCourseDetailViewController.h"

#import "WLkc2TableViewCell.h"
#import "WLke1TableViewCell.h"

#import "WLMyDataHandle.h"

#import "WLCourseFavModel.h"
@interface WLKcViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation WLKcViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    _page = 1;
    [self requestGetFavListWithPage:_page];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Getter
- (NSMutableArray *)dataSource{
    if(!_dataSource){
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
//返回多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //#warning Incomplete implementation, return the number of sections
    return self.dataSource.count;
}
//返回多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSArray *array = self.dataSource[section];
    return array.count;
}


//cell高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

//返回组头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40 ;
}
//返回cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    id cell;
    
    static NSString *ID = @"WLke1TableViewCell";
    static NSString *deteID = @"WLkc2TableViewCell";
    
    if (indexPath.section == 0) {
    
        WLke1TableViewCell *cells = [tableView dequeueReusableCellWithIdentifier:ID];
        
        if (cells == nil) {
            cells = [[[NSBundle mainBundle] loadNibNamed:ID owner:nil options:nil] lastObject];
        }
       cells.model = self.dataSource[indexPath.section][indexPath.row];
        cell = cells;
        

    }else{
        WLkc2TableViewCell *cells = [tableView dequeueReusableCellWithIdentifier:deteID];
        if (cells == nil) {
            cells = [[[NSBundle mainBundle] loadNibNamed:deteID owner:nil options:nil] lastObject];
        }
         cells.model = self.dataSource[indexPath.section][indexPath.row];
        cell = cells;
    }
    
    
    return cell;
}


//返回组头view

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [UIView new];
    view.backgroundColor = RGBA(237, 237, 237, 1);
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 20)];
    
    if (section == 0) {
        label.text = @"点播课程";
    }else if (section==1){
        label.text = @"直播课程";
    }
    
    label.font = [UIFont systemFontOfSize:16];
    [view addSubview:label];
    
    
    
    return view;
}





#pragma mark 点击cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    WLCourseFavModel *model = self.dataSource[indexPath.section][indexPath.row];
    if (indexPath.section == 0) {
        WLCourseDetailViewController *vc = [[WLCourseDetailViewController alloc] init];
        vc.courseId = model.id;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.section==1){
        WLLiveCourseDetailViewController *vc = [[WLLiveCourseDetailViewController alloc] init];
        vc.courseId = model.id;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

#pragma mark - Request
- (void)requestGetFavListWithPage:(NSInteger )page{
    [WLMyDataHandle requestGetFavListWithUid:[WLUserInfo share].userId page:@(page) type:@(2) success:^(id responseObject) {
        self.dataSource = responseObject;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}
@end
