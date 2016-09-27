//
//  WLQuViewController.m
//  MyBoRuiSi
//
//  Created by wsl on 16/8/2.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLQuViewController.h"
#import "WLCurriculumTableViewCell.h"
#import "WLq1ViewController.h"
@interface WLQuViewController ()

@end

@implementation WLQuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    
       //尾部
    UIView *view = [UIView new];
    self.tableView.tableFooterView = view;
    
}
//
//-(void)buttonSix:(UIImage *)iamge{
//    NSLog(@"3456");
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 190;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *deteID = @"WLCurriculumTableViewCell";
    
    WLCurriculumTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:deteID];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:deteID owner:nil options:nil] lastObject];
    }
    //bolck
    cell.WLCurriculumTableViewCellBlcok = ^(){
        
        WLq1ViewController *q = [[WLq1ViewController alloc]init];
        [self.navigationController pushViewController:q animated:YES];
        
    };
    
    return cell;
}



#pragma mark 点击cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}

@end
