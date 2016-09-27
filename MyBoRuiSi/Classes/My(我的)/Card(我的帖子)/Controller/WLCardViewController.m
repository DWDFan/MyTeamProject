//
//  WLCardViewController.m
//  MyBoRuiSi
//
//  Created by wsl on 16/8/3.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLCardViewController.h"
#import "WLcardTableViewCell.h"

#import "WLCardxqViewController.h"

@interface WLCardViewController ()

@end

@implementation WLCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
    btn.backgroundColor = [UIColor clearColor];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setImage:[UIImage imageNamed:@"图层-47"] forState:UIControlStateNormal];
    [btn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
    [btn setTitle:@"我的帖子" forState:UIControlStateNormal];
    self.navigationItem.titleView = btn;
    
    
    
    [self.navigationController.navigationBar setBackgroundImage:[self createImageWithColor:RGBA(255, 255, 255, 1)] forBarMetrics:UIBarMetricsDefault];
    
    
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

//返回多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //#warning Incomplete implementation, return the number of sections
    return 1;
}
//返回多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return 3;
}


//cell高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 310;
}

//返回组头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.1 ;
}
//返回cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *deteID = @"WLcardTableViewCell";
    
    WLcardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:deteID];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:deteID owner:nil options:nil] lastObject];
    }
    
    
    return cell;
}

#pragma mark 点击cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //帖子详情
    WLCardxqViewController *cadr = [[WLCardxqViewController alloc]init];
    [self.navigationController pushViewController:cadr animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
