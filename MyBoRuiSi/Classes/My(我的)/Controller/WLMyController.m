//
//  WLMyController.m
//  MyBoRuiSi
//
//  Created by wsl on 16/7/30.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLMyController.h"
#import "WLDetectionTableViewCell.h"

#import "WLMyTableViewCell.h"
#import "ThePersonalDataTableViewController.h"
#import "WLRegisteringViewController.h"

#import "WLShoppingsTableViewController.h"

#import "WLAttentionViewController.h"//关注
#import "WLCardViewController.h"//帖子
#import "WLMyCurriculumViewController.h"//课程
#import "WLRecomViewController.h"//推荐好友
#import "WLSettingViewController.h"//设置
#import "WLTestViewController.h"//考试
#import "WLWalletViewController.h"//钱包
#import "WLNoticesViewController.h"//通知

#import "UIImage+Image.h"

#import "WLheadsViewController.h"


@interface WLMyController ()

@end

@implementation WLMyController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([WLUserInfo share].isLogin) {
        [self userLoginStatusLogin];
    }else{
        [self userLoginStatusNotLgoin];
    }
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
    btn.backgroundColor = [UIColor clearColor];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setImage:[UIImage imageNamed:@"图层-47"] forState:UIControlStateNormal];
    [btn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
    [btn setTitle:@"我的" forState:UIControlStateNormal];
    self.navigationItem.titleView = btn;
    
    [self.navigationController.navigationBar setBackgroundImage:[self createImageWithColor:RGBA(255, 255, 255, 1)] forBarMetrics:UIBarMetricsDefault];
    
    //设置右边的按钮图片没有渲染
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageWithOriginalName:@"通知"] style:UIBarButtonItemStyleDone target:self action:@selector(Notice)];
    
    //监听是否登录
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadLoginStatus:) name:@"changeLoginStatus" object:nil];
}


//颜色转图片
- (UIImage*) createImageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage*theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    return theImage;
}
//导航栏右边按钮
-(void)Notice{
    //通知
    WLNoticesViewController *notice = [[WLNoticesViewController alloc]init];
    [self.navigationController pushViewController:notice animated:YES];
    
}

#pragma mark - Private Method
//未登录状态
- (void)userLoginStatusNotLgoin{
    WLMyTableViewCell *header = [[[NSBundle mainBundle]loadNibNamed:@"WLMyTableViewCell" owner:nil options:nil] firstObject];
    
    __weak typeof(self) weakSelf = self;
    header.tapHeaderBlock = ^(){
        WLRegisteringViewController *loginVC = [[WLRegisteringViewController alloc] init];
        [weakSelf.navigationController pushViewController:loginVC animated:YES];
    };
    header.colletionActionBlock = ^(){
        WLRegisteringViewController *loginVC = [[WLRegisteringViewController alloc] init];
        [weakSelf.navigationController pushViewController:loginVC animated:YES];
    };
    self.tableView.tableHeaderView = header;
 
}

//登录状态
- (void)userLoginStatusLogin{
    WLUserLoginstatusCell *header = [[NSBundle mainBundle]loadNibNamed:@"WLMyTableViewCell" owner:nil options:nil][1];
    
    __weak typeof(self) weakSelf = self;
    header.tapHeaderBlock = ^(){
        ThePersonalDataTableViewController *PersonalData = [[ThePersonalDataTableViewController alloc] init];
        [weakSelf.navigationController pushViewController:PersonalData animated:YES];
    };
    header.colletionActionBlock = ^(){
        //我的收藏
        WLheadsViewController *head = [[WLheadsViewController alloc]init];
        [weakSelf.navigationController pushViewController:head animated:YES];
    };
    self.tableView.tableHeaderView = header;
}


#pragma mark - Notification implementation
/** 刷新用户登录状态 */
- (void)reloadLoginStatus:(NSNotification *)noti{
    //加载用户数据
    [[WLUserInfo share] loadUserInfo];
    if ([WLUserInfo share].isLogin) {
        [self userLoginStatusLogin];
    }else{
        [self userLoginStatusNotLgoin];
    }
}

#pragma mark - Table view data source
//点击cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            //订单
            //WLShoppingsTableViewController
            WLShoppingsTableViewController *order = [[WLShoppingsTableViewController alloc]init];
            [self.navigationController pushViewController:order animated:YES];
        }else if (indexPath.row == 1){
            //课程
            WLMyCurriculumViewController *mycurriculum = [[WLMyCurriculumViewController alloc]init];
            [self.navigationController pushViewController:mycurriculum animated:YES];
            
        }else{
            //考试
            WLTestViewController *test = [[WLTestViewController alloc]init];
            [self.navigationController pushViewController:test animated:YES];
        }
    }else if (indexPath.section == 1){
        //钱包
        WLWalletViewController *wall = [[WLWalletViewController alloc]init];
        [self.navigationController pushViewController:wall animated:YES];
        
    }else if (indexPath.section == 2){
        if (indexPath.row == 0) {
            //帖子
            WLCardViewController *card = [[WLCardViewController alloc]init];
            [self.navigationController pushViewController:card animated:YES];
        }else{
            //关注
            WLAttentionViewController *atten = [[WLAttentionViewController alloc]init];
            [self.navigationController pushViewController:atten animated:YES];
        }
        
    }else if (indexPath.section == 3){
        //设置
        WLSettingViewController *setting = [[WLSettingViewController alloc]init];
        [self.navigationController pushViewController:setting animated:YES];
        
    }else if (indexPath.section == 4){
        
        //推荐好友
        WLRecomViewController *recomment = [[WLRecomViewController alloc]init];
        [self.navigationController pushViewController:recomment animated:YES];
        
    }

}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    int i = 1;
    if (section == 0) {
        i = 3;
    }else if (section == 2){
        i = 2;
    }
    
    return i;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *deteID = @"WLDetectionTableViewCell";
    WLDetectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:deteID];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:deteID owner:nil options:nil] lastObject];
    }
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.imageView.image = [UIImage imageNamed:@"icon-订单"];
            cell.lableView.text = @"我的订单";

        }else if (indexPath.row == 1){
            cell.imageView.image = [UIImage imageNamed:@"icon-课程"];
            cell.lableView.text = @"我的课程";
            
        }else if (indexPath.row == 2){
            
            cell.imageView.image = [UIImage imageNamed:@"icon-考试"];
            cell.lableView.text = @"我的考试";
        }
        
    }else if (indexPath.section == 1){
        //钱包
        cell.imageView.image = [UIImage imageNamed:@"icon-我的钱包"];
        cell.lableView.text = @"我的钱包";
        
    }else if (indexPath.section == 2){
        
        if (indexPath.row == 0) {
            cell.imageView.image = [UIImage imageNamed:@"icon-帖子"];
            cell.lableView.text = @"我的帖子";
        }else{
            cell.imageView.image = [UIImage imageNamed:@"icon-关注"];
            cell.lableView.text = @"我的关注";
        }
    }else if (indexPath.section == 3){
        
        cell.imageView.image = [UIImage imageNamed:@"icon-设置"];
        cell.lableView.text = @"设置";
    }else{
        cell.imageView.image = [UIImage imageNamed:@"icon-推荐"];
        cell.lableView.text = @"推荐好友";
    }
    
    
    return cell;
}



//返回组头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

//cell高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}

@end
