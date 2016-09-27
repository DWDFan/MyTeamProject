//
//  AppraisalViewController.m
//  MyBoRuiSi
//
//  Created by wsl on 16/8/7.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "AppraisalViewController.h"
#import "DirectTableViewCellThree.h"
#import "WLCourseDataHandle.h"
#import "WLCommetCell.h"
#import "WLCourceModel.h"

@interface AppraisalViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSArray *comments;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation AppraisalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
    btn.backgroundColor = [UIColor clearColor];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setImage:[UIImage imageNamed:@"图层-47"] forState:UIControlStateNormal];
    [btn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
    [btn setTitle:@"所有评论" forState:UIControlStateNormal];
    self.navigationItem.titleView = btn;
    
    [self.navigationController.navigationBar setBackgroundImage:[MOTool createImageWithColor:RGBA(255, 255, 255, 1)] forBarMetrics:UIBarMetricsDefault];
    
    [self requestData];
}

- (void)requestData
{
    [WLCourseDataHandle requestCourceAllCommentWithCourseId:_courseId success:^(id responseObject) {
        
        NSArray *array = responseObject[@"data"][@"list"];
        _comments = [WLCommentModel mj_objectArrayWithKeyValuesArray:array];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return _comments.count + 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        static NSString *ID = @"titleCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        cell.textLabel.text = [NSString stringWithFormat:@"评价(%ld)",_comments.count];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = COLOR_BLACK;
        return cell;
    }else {
        static NSString *ID_main = @"DirectTableViewCellThree";
        WLCommetCell *commentCell = [tableView dequeueReusableCellWithIdentifier:ID_main];
        if (!commentCell) {
            commentCell = [[WLCommetCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID_main];
            commentCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        commentCell.comment = _comments[indexPath.row - 1];
        return commentCell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 44;
    }else {
        return [MOTool MOtextSizeH:[_comments[indexPath.row - 1] msg] WithWidth:WLScreenW - 30 WithFount:[UIFont systemFontOfSize:12]] + 15 * 3 + 12;

    }
}


@end
