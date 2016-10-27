//
//  WLnewsViewController.m
//  MyBoRuiSi
//
//  Created by wsl on 16/8/6.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLnewsViewController.h"
#import "WLnewsTableViewCell.h"

#import "WLXtnewsViewController.h"

#import "WLMyDataHandle.h"
@interface WLnewsViewController ()
@property (nonatomic, assign) NSInteger page;
@end

@implementation WLnewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _page = 1;
   
    //request
    [self requestGetMsg];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
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
    return 65;
}

//返回组头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.1 ;
}
//返回cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *deteID = @"WLnewsTableViewCell";
    
    WLnewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:deteID];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:deteID owner:nil options:nil] lastObject];
    }
    
    
    return cell;
}

#pragma mark 点击cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //系统消息
    WLXtnewsViewController *xt = [[WLXtnewsViewController alloc]init];
    [self.navigationController pushViewController:xt animated:YES];
}


#pragma mark - Request
- (void)requestGetMsg{
    [WLMyDataHandle requestGetMsgWithUid:[WLUserInfo share].userId page:@(self.page) type:@"system" success:^(id responseObject) {
        
    } failure:^(NSError *error) {
        
    }];
}
@end
