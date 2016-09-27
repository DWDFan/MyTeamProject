//
//  WLIncomeViewController.m
//  MyBoRuiSi
//
//  Created by mo on 16/8/6.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLIncomeViewController.h"

@interface WLIncomeViewController ()

@end

@implementation WLIncomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
    btn.backgroundColor = [UIColor clearColor];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setImage:[UIImage imageNamed:@"图层-47"] forState:UIControlStateNormal];
    [btn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
    [btn setTitle:@"收入明细" forState:UIControlStateNormal];
    self.navigationItem.titleView = btn;
    
    
    //    [MOTool createImageWithColor:]
    [self.navigationController.navigationBar setBackgroundImage:[MOTool createImageWithColor:RGBA(255, 255, 255, 1)] forBarMetrics:UIBarMetricsDefault];
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
//MARK:tableView代理方法----------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    //隐藏点击cell的效果
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"推广奖金";
        }
        if (indexPath.row == 1) {
            cell.textLabel.text = @"充值";
        }
        if (indexPath.row == 2) {
            cell.textLabel.text = @"充值";
        }
    }
    //添加文本
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 44)];
    //设置靠右
    label.textAlignment = NSTextAlignmentRight;
    label.text = @"+¥500.00";
    label.textColor = [UIColor redColor];
    cell.accessoryView = label;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}

@end
