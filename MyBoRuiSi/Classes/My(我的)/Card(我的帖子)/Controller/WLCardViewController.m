//
//  WLCardViewController.m
//  MyBoRuiSi
//
//  Created by wsl on 16/8/3.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLCardViewController.h"
#import "WLArticleDetailViewController.h"

#import "ZGArticleCell.h"

#import "WLMyDataHandle.h"
@interface WLCardViewController ()<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSString  *tid;
@property (nonatomic, strong) NSIndexPath *indexPath;
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
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    _page = 1;
    [self requestGetMyPost];
    
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
#pragma mark - Getter
- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

#pragma mark - Delegate AlertView
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        //reqeust delete
        [self requestDeleteMyPostWithTid:self.tid indexPath:self.indexPath];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}


//cell高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZGArticleViewModel *vModel = [self.dataSource objectAtIndex:indexPath.row];
    return  vModel.cellHeight;
}

//返回组头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.1 ;
}
//返回cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *deteID = @"ZGArticleCell";
    ZGArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:deteID];
    if (cell == nil) {
        cell = [[ZGArticleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:deteID];
    }
    cell.articleViewModel = self.dataSource[indexPath.row];
    
    return cell;

}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{//请求数据源提交的插入或删除指定行接收者。
    if (editingStyle ==UITableViewCellEditingStyleDelete) {//如果编辑样式为删除样式
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"是否确认删除" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
        
        ZGArticleViewModel *model = self.dataSource[indexPath.row];
        self.tid = model.article.id;
        self.indexPath = indexPath;
    }
}

#pragma mark 点击cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //帖子详情
    WLArticleDetailViewController *cadr = [[WLArticleDetailViewController alloc]init];
    ZGArticleViewModel *model = self.dataSource[indexPath.row];
    cadr.articleId = model.article.id;
    [self.navigationController pushViewController:cadr animated:YES];
}

#pragma mark - Request
- (void)requestGetMyPost{
    [WLMyDataHandle requestGetMyPostWithUid:[WLUserInfo share].userId success:^(id responseObject) {
        self.dataSource = responseObject;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
    
}

- (void)requestDeleteMyPostWithTid:(NSString *)tid indexPath:(NSIndexPath *)indexPath{
    [WLMyDataHandle requestDeleteMyPostWithUid:[WLUserInfo share].userId tid:self.tid success:^(id responseObject) {
        [self.dataSource removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];

    } failure:^(NSError *error) {
        
    }];
    
}
@end
