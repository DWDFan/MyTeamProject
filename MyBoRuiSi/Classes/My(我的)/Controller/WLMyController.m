//
//  WLMyController.m
//  MyBoRuiSi
//
//  Created by wsl on 16/7/30.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLMyController.h"

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
#import "WLheadsViewController.h"

#import "WLDetectionTableViewCell.h"
#import "WLMyTableViewCell.h"
#import "WLVipPriceListView.h"
#import "WLVipDateView.h"

#import "WLMyDataHandle.h"
#import "WLLoginDataHandle.h"

#import "UIImage+Image.h"
#import "WLAddOrderViewController.h"
#import "WLForgetViewController.h"
#import "WLInputBagPwdView.h"

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
    
    if ([WLUserInfo share].isLogin) {
        //设置右边的按钮图片没有渲染
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageWithOriginalName:@"通知"] style:UIBarButtonItemStyleDone target:self action:@selector(Notice)];
    }
    self.tableView.showsVerticalScrollIndicator = NO;
    //监听是否登录
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloaWLLoginStatus:) name:@"changeLoginStatus" object:nil];
    
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
  
    //设置右边的按钮图片没有渲染
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageWithOriginalName:@"通知"] style:UIBarButtonItemStyleDone target:self action:@selector(Notice)];
    
    
    WLUserLoginstatusCell *header = [[NSBundle mainBundle]loadNibNamed:@"WLMyTableViewCell" owner:nil options:nil][1];
    
    __weak typeof(self) weakSelf = self;
    __weak typeof(WLUserLoginstatusCell*) weakHeader = header;
    header.tapHeaderBlock = ^(){
        ThePersonalDataTableViewController *personalData = [[ThePersonalDataTableViewController alloc] init];
        personalData.reloadDataBlock = ^(){
            [weakHeader reloadData];
        };
        [weakSelf.navigationController pushViewController:personalData animated:YES];
    };
    header.colletionActionBlock = ^(){
        //我的收藏
        WLheadsViewController *head = [[WLheadsViewController alloc]init];
        [weakSelf.navigationController pushViewController:head animated:YES];
    };
    
    header.openVipBlock = ^(){
        if([WLUserInfo share].vip){//续费
            
            WLVipDateView *view = [[WLVipDateView alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
            view.date = [WLUserInfo share].vipEndtm;
            [[UIApplication sharedApplication].keyWindow addSubview:view];
            __weak typeof(view) weakView = view;
            view.cancleBlock = ^(){
                [weakView removeFromSuperview];
            };
            view.keepBlock = ^(){
                [weakView removeFromSuperview];
                [weakSelf requestVipList];
            };
            
        }else{//开通
            [self requestVipList];
        }
    };
    [header reloadData];
    self.tableView.tableHeaderView = header;
}


#pragma mark - Notification implementation
/** 刷新用户登录状态 */
- (void)reloaWLLoginStatus:(NSNotification *)noti{
    if ([WLUserInfo share].isLogin) {
        //获取用户信息
        [self requestGetUserInfo];
        
       
    }else{
        [self userLoginStatusNotLgoin];
    }
}

#pragma mark - Table view data source
//点击cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (![WLUserInfo share].isLogin) {
        WLRegisteringViewController *loginVC = [[WLRegisteringViewController alloc] init];
        [self.navigationController pushViewController:loginVC animated:YES];
        return;
    }
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


#pragma mark - Request
- (void)requestGetUserInfo
{
    [WLLoginDataHandle requestGetUserInfoWithUid:[WLUserInfo share].userId success:^(id responseObject) {
        //归档
        [[WLUserInfo share] archivWithDict:responseObject];
        //加载用户信息
        [[WLUserInfo share] loadUserInfo];
        
         [self userLoginStatusLogin];
    } failure:^(NSError *error) {
         [self userLoginStatusLogin];
    }];
}
/** 会员列表 */
- (void)requestVipList{
    [WLMyDataHandle requestGetVipFeeWithUid:[WLUserInfo share].userId success:^(id responseObject) {
        WLVipPriceListView *view = [[WLVipPriceListView alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
        view.dataSource = responseObject;
        [[UIApplication sharedApplication].keyWindow addSubview:view];
        __weak typeof(view) weakView = view;
        view.cancleBlock = ^(){
            [weakView removeFromSuperview];
        };
        view.buyVipBlock = ^(NSNumber *year){
            //会员购买
            
//            WLAddOrderViewController *vc = [[WLAddOrderViewController alloc]init];
////            vc.dataSource = self.selectDataArray;
////            vc.money = (float)self.amount;
//            vc.type = @"vip";
//            [self.navigationController pushViewController:vc animated:YES];

//            [self.navigationController pushViewController:vc animated:YES];
            //验证钱包密码
            WLInputBagPwdView *pwdView = [WLInputBagPwdView inputBagPawdView];
            pwdView.frame = [UIApplication sharedApplication].keyWindow.bounds;
            [[UIApplication sharedApplication].keyWindow addSubview:pwdView];
            
            __weak typeof(pwdView) weakPwdView = pwdView;
            __weak typeof(self) weakSelf = self;
            pwdView.closeBlock = ^(){
                [weakPwdView removeFromSuperview];
            };
            pwdView.completeBlock = ^(NSString *pwd){
                [weakPwdView removeFromSuperview];
                [WLMyDataHandle requestBuyVipWithUid:[WLUserInfo share].userId year:year pwd:pwd success:^(id responseObject) {
                    //刷新有效日期值
                    [self requestGetUserInfo];
                    [weakView removeFromSuperview];
                } failure:^(NSError *error) {
                    [weakView removeFromSuperview];
                }];
            };
            pwdView.forgetPwdBlock = ^(){
                WLForgetViewController *Forget = [[WLForgetViewController alloc]init];
                [weakSelf.navigationController pushViewController:Forget animated:YES];
            };
        };
    } failure:^(NSError *error) {
        
    }];
}
@end
