//
//  ThePersonalDataTableViewController.m
//  MyBoRuiSi
//
//  Created by 莫 on 16/8/2.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "ThePersonalDataTableViewController.h"
#import "ThePersonalDataTableViewCell.h"
#import "WLThePersonalDataTableViewCellTwo.h"

#import "WLLoginDataHandle.h"
@interface ThePersonalDataTableViewController ()

@end

@implementation ThePersonalDataTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"个人资料";
    
    //获取用户信息
    //[self requestGetUserInfo];
}



#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    id cell;
    
    
    
    if (indexPath.row == 0) {
        
        NSString *ID = @"WLThePersonalDataTableViewCellTwo";
        WLThePersonalDataTableViewCellTwo *cells = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cells) {
            cells = [[[NSBundle mainBundle] loadNibNamed:ID owner:nil options:nil] lastObject];
        }
        
        cells.describeLabel.text = @"头像:";
//        cells.imageName sd_setImageWithURL:[NSURL URLWithString:[WLUserInfo share].photo];
        
        cell = cells;
        
    }else{
        
        
        NSString *ID = @"ThePersonalDataTableViewCell";
        ThePersonalDataTableViewCell *cells = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cells) {
            cells = [[[NSBundle mainBundle] loadNibNamed:ID owner:nil options:nil] lastObject];
        }
        
        if (indexPath.row == 1) {
            cells.describeLabel.text = @"昵称:";
            cells.contentLabel.text = [WLUserInfo share].nickname ? [WLUserInfo share].nickname : @"";
            
        }else if (indexPath.row == 2) {
            
            cells.describeLabel.text = @"性别:";
            cells.contentLabel.text = [WLUserInfo share].sex ? [WLUserInfo share].sex : @"";
            
            
        }else if (indexPath.row == 3) {
            
            cells.describeLabel.text = @"生日:";
//            cells.contentLabel.text = [WLUserInfo share].nickname ? [WLUserInfo share].nickname : @"";
            
            
        }else if (indexPath.row == 4) {
            
            cells.describeLabel.text = @"所在公司:";
            cells.contentLabel.text = [WLUserInfo share].company ? [WLUserInfo share].company : @"";
            
            
        }else if (indexPath.row == 5) {
            
            cells.describeLabel.text = @"职业:";
            cells.contentLabel.text = [WLUserInfo share].job ? [WLUserInfo share].job : @"";
            
            
        }else{
            
            cells.describeLabel.text = @"地址:";
            cells.contentLabel.text = [WLUserInfo share].address ? [WLUserInfo share].address : @"";
            
            
            
        }
        
        cell = cells;
        
        
    }
    
    
   
    
    
    return  cell;
    
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    int a = 45;
    if (indexPath.row == 0) {
        
        a = 60;
    }
    
    return 60;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return  0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    
}


#pragma mark - Request
//- (void)requestGetUserInfo
//{
//    [WLLoginDataHandle requestGetUserInfoWithUid:[WLUserInfo share].userId success:^(id responseObject) {
//        
//    } failure:^(NSError *error) {
//        
//    }];
//}

@end
