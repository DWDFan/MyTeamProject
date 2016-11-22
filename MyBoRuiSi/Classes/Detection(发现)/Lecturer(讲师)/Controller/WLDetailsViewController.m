//
//  WLDetailsViewController.m
//  MyBoRuiSi
//
//  Created by wsl on 16/8/2.
//  Copyright © 2016年 itcast.com. All rights reserved.
//  讲师详情

#import "WLDetailsViewController.h"

#import "WLDetailsTableViewCell.h"
#import "WLDetailsHeardTableViewCell.h"
#import "WLLiveCourseDetailViewController.h"
#import "WLCourseDetailViewController.h"
#import "WLHomeDataHandle.h"
#import "WLUserInfo.h"
#import "WLLecturerModel.h"

@interface WLDetailsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView_main;
@property (nonatomic, weak) WLDetailsHeardTableViewCell *header;
@property (nonatomic, strong) WLLecturerModel *lecturer;

@end

@implementation WLDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
    btn.backgroundColor = [UIColor clearColor];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setImage:[UIImage imageNamed:@"图层-47"] forState:UIControlStateNormal];
    [btn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
    [btn setTitle:@"讲师详情" forState:UIControlStateNormal];
    self.navigationItem.titleView = btn;
    
    [self.navigationController.navigationBar setBackgroundImage:[MOTool createImageWithColor:RGBA(255, 255, 255, 1)] forBarMetrics:UIBarMetricsDefault];

    _header = [[[NSBundle mainBundle]loadNibNamed:@"WLDetailsHeardTableViewCell" owner:nil options:nil] lastObject];
    [_header setBlock:^(UIButton *sender) {
        
        if (![WLUserInfo share].isLogin) {
            
            [self alertLogin];
            return ;
        }
        
        NSNumber *type = sender.selected ? @0 : @1;
        [WLHomeDataHandle requestHomeFollowLectureWithUid:[WLUserInfo share].userId tid:_teacherId type:type Success:^(id responseObject) {
            
            sender.selected = !sender.selected;
        } failure:^(NSError *error) {
            
        }];
    }];
    self.tableView_main.tableHeaderView = _header;
    
    [self requestData];
}

- (void)requestData
{
    [WLHomeDataHandle requestTeacherDetailWithUid:[WLUserInfo share].userId jid:_teacherId success:^(id responseObject) {
        
        _lecturer = [WLLecturerModel mj_objectWithKeyValues:responseObject[@"data"]];
        _header.lecturer = _lecturer;
        [self.tableView_main reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)alertLogin
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"您需要登陆后才能进行操作！" delegate:self cancelButtonTitle:@"暂不登录" otherButtonTitles:@"去登陆", nil];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [MOTool pushLoginViewControllerWithController:self];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _lecturer.list.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *deteID = @"WLDetailsTableViewCell";
    
    WLDetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:deteID];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:deteID owner:nil options:nil] lastObject];
    }
    cell.course = _lecturer.list[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}
//返回组头view
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [UIView new];
    view.backgroundColor = KColorBackgroud;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, WLScreenW, 40)];
    label.backgroundColor = [UIColor whiteColor];
    label.text = @"  讲师课程";
    label.font = [UIFont systemFontOfSize:16];
    [view addSubview:label];
    return view;
}


#pragma mark 点击cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //课程详情
//    DirectViewController *dire = [[DirectViewController alloc]init];
//    WLCourseDetailViewController *vc = [[WLCourseDetailViewController alloc] init];
//    vc.courseId = [_lecturer.list[indexPath.row] id];
//    [self.navigationController pushViewController:vc animated:YES];
    
    WLCourseListModel *model = _lecturer.list[indexPath.row];
    if ([model.type isEqualToNumber:@1]) {
        WLCourseDetailViewController *detail = [[WLCourseDetailViewController alloc] init];
        detail.courseId = model.id;
        [self.navigationController pushViewController:detail animated:YES];
    }else {
        WLLiveCourseDetailViewController *vc = [[WLLiveCourseDetailViewController alloc] init];
        vc.courseId = model.id;
        [self.navigationController pushViewController:vc animated:YES];
    }

}



@end
