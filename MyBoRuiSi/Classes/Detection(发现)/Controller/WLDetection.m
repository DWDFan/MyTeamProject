//
//  WLDetection.m
//  MyBoRuiSi
//
//  Created by wsl on 16/7/30.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLDetection.h"
#import "WLDetectionTableViewCell.h"

#import "WLTestTableViewController.h"

#import "WLOrgViewController.h"
#import "WLLecturerViewController.h"
#import "WLfather2ViewController.h"



@interface WLDetection ()

@end

@implementation WLDetection

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"图层-47"] forBarMetrics:UIBarMetricsDefault];
    //设置标题图片
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
    btn.backgroundColor = [UIColor clearColor];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setImage:[UIImage imageNamed:@"图层-47"] forState:UIControlStateNormal];
    [btn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
    [btn setTitle:@"发现" forState:UIControlStateNormal];
    self.navigationItem.titleView = btn;
    
    
    
    [self.navigationController.navigationBar setBackgroundImage:[self createImageWithColor:RGBA(255, 255, 255, 1)] forBarMetrics:UIBarMetricsDefault];
    
    
    UIView *view = [UIView new];
    self.tableView.tableFooterView = view;
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    int i = 1;
    if (section == 1) {
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
        cell.imageVIew.image = [UIImage imageNamed:@"图层-57"];
        cell.lableView.text = @"在线考试";
    }else if (indexPath.section == 1){
        
        if (indexPath.row == 0) {
            cell.imageVIew.image = [UIImage imageNamed:@"组-2_94"];
            cell.lableView.text = @"讲师";

        }else{
            cell.imageVIew.image = [UIImage imageNamed:@"组-3_86"];
            cell.lableView.text = @"机构";

        }
    }else{
        cell.imageVIew.image = [UIImage imageNamed:@"组-4_39"];
        cell.lableView.text = @"论坛";
        

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



#pragma mark 点击tableViewcell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //在线考试
    if (indexPath.section == 0) {
        WLTestTableViewController *test = [[WLTestTableViewController alloc]init];
        test.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:test animated:YES];
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            //讲师
            WLLecturerViewController *lecturer = [[WLLecturerViewController alloc]init];
            lecturer.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:lecturer animated:YES];
            
        }else{
            //机构
            
            WLOrgViewController *organiztion = [[WLOrgViewController alloc]init];
            organiztion.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:organiztion animated:YES];
        }
    }else{
        //论坛
        
        WLfather2ViewController *forum = [[WLfather2ViewController alloc]init];
        //forum.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:forum animated:YES];
    }
    
}



@end
