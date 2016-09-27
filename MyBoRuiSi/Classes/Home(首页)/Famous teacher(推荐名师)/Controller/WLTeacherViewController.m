//
//  WLTeacherViewController.m
//  MyBoRuiSi
//
//  Created by wsl on 16/8/4.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLTeacherViewController.h"
#import "WLHometwoTableViewCell.h"

#import "WLDetailsViewController.h"


@interface WLTeacherViewController ()

@end

@implementation WLTeacherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
    
    [btn setBackgroundColor:[UIColor clearColor]];
    
    [btn setImage:[UIImage imageNamed:@"图层-47"] forState:UIControlStateNormal];
    [btn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
    [btn setTitle:@"推荐讲师" forState:UIControlStateNormal];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return 5;
}


//cell高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 262;
}



////返回组头的高度
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    
//    return 10 ;
//}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *deteID = @"WLHometwoTableViewCell";
    
    WLHometwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:deteID];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:deteID owner:nil options:nil] lastObject];
    }
    
    
    return cell;
}

#pragma mark 点击tableViewcell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //讲师详情
    WLDetailsViewController *det = [[WLDetailsViewController alloc]init];
    [self.navigationController pushViewController:det animated:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    

    
    
}



@end
