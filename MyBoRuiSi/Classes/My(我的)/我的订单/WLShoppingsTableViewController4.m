//
//  WLShoppingsTableViewController4.m
//  MyBoRuiSi
//
//  Created by 莫瑞伟 on 16/8/4.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLShoppingsTableViewController4.h"
#import "WLOrderCell.h"
@interface WLShoppingsTableViewController4 ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView_main;
@property (nonatomic,assign) BOOL isOpen;

@end

@implementation WLShoppingsTableViewController4

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
//MARK:tableView代理方法----------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1 创建可重用cell对象
    static NSString *reuseId = @"WLOrderCell";
    WLOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"WLOrderCell" owner:nil options:nil] lastObject];
    }
    cell.isOpen = YES;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}
- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
- (CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{//请求数据源提交的插入或删除指定行接收者。
    if (editingStyle ==UITableViewCellEditingStyleDelete) {//如果编辑样式为删除样式
        
    }
}

@end
