//
//  WLReportViewController.m
//  MyBoRuiSi
//
//  Created by Catski on 2016/10/10.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLReportViewController.h"
#import "WLFindDataHandle.h"

@interface WLReportViewController ()

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, assign) NSInteger selectIndex;

@end

@implementation WLReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBarStyleDefultWithTitle:@"举报"];
    
    self.titles = @[@"过期",@"与事实不符",@"政治敏感",@"其他问题"];
    self.tableView.rowHeight = 44;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确认" style:UIBarButtonItemStylePlain target:self action:@selector(rightBtnAction:)];
}

- (void)rightBtnAction:(id)sender
{
    [WLFindDataHandle requestFindArticleReportWithTid:_articleId uid:[WLUserInfo share].userId msg:_titles[_selectIndex] success:^(id responseObject) {
        
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor = COLOR_WORD_BLACK;
    cell.textLabel.text = self.titles[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _selectIndex = indexPath.row;
}

@end
