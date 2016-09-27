//
//  WLxqusViewController.m
//  MyBoRuiSi
//
//  Created by wsl on 16/8/10.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLxqusViewController.h"
#import "WLCurriculumTableViewCell.h"

@interface WLxqusViewController ()

@end

@implementation WLxqusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 190;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *deteID = @"WLCurriculumTableViewCell";
    
    WLCurriculumTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:deteID];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:deteID owner:nil options:nil] lastObject];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *str;
    
    if (section == 0) {
        str = @"一级分类";
    }else {
        str = @"分类名称";
    }
    return str;
}

@end
