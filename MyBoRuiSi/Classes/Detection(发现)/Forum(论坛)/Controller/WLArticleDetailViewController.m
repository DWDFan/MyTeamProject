//
//  WLArticleDetailViewController.m
//  MyBoRuiSi
//
//  Created by Catskiy on 2016/10/9.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLArticleDetailViewController.h"
#import "WLSharetowViewController.h"
#import "WLReportViewController.h"
#import "WLFindDataHandle.h"
#import "ZGArticleCell.h"
#import "WLCommetCell.h"
//#import "ZGArticleModel.h"
#import "WLCourceModel.h"
#import "KxMenu.h"

@interface WLArticleDetailViewController ()

@property (nonatomic, strong) NSArray *commentsArray;
@property (nonatomic, assign) NSNumber *page;

@end

@implementation WLArticleDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNavigationBarStyleDefultWithTitle:@"详情"];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageWithOriginalName:@"素彩网www.sc115.com-136"] style:UIBarButtonItemStyleDone target:self action:@selector(rightBtnAction:)];
    
    self.tableViewStyle = UITableViewStyleGrouped;
    [self.view addSubview:self.tableView];
    
    _page = @0;
    
    [self requestData];
}

- (void)requestData
{
    // 帖子内容
    [WLFindDataHandle requestFindArticleDetailWithTid:_articleId success:^(id responseObject) {
        
        ZGArticleModel *article = [ZGArticleModel mj_objectWithKeyValues:responseObject[@"data"]];
        _articleViewModel = [[ZGArticleViewModel alloc] init];
        _articleViewModel.article = article;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
    
    // 评论列表
    [WLFindDataHandle requestFindArticleCommentListWithTid:_articleId page:_page success:^(id responseObject) {
        
        _commentsArray = [WLCommentModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
    
    // 阅读
    [WLFindDataHandle requestFindArticleReadWithTid:_articleId uid:[WLUserInfo share].userId success:^(id responseObject) {
        
        
    } failure:^(NSError *error) {
        
    }];
}


- (void)showMoreMenuInRect:(CGRect)rect
{
    NSArray *menuItems =
    @[[KxMenuItem menuItem:@"分享"
                     image:[UIImage imageNamed:@"图层-48346"]
                    target:self
                    action:@selector(share)],
      [KxMenuItem menuItem:@"收藏"
                     image:[UIImage imageNamed:@"icon_collect_select"]
                    target:self
                    action:@selector(collect)]
      ];
    KxMenuItem *first = menuItems[0];
    first.foreColor = [UIColor colorWithRed:136/255.0f green:136/255.0f blue:136/255.0f alpha:1.0];
    first.alignment = NSTextAlignmentCenter;
    [KxMenu showMenuInView:self.view
                  fromRect:rect
                 menuItems:menuItems];

}

#pragma mark - 导航栏右按钮

- (void)rightBtnAction:(id)sender
{    
    NSArray *menuItems =
    @[[KxMenuItem menuItem:@"分享"
                     image:[UIImage imageNamed:@"图层-48346"]
                    target:self
                    action:@selector(share)],
      [KxMenuItem menuItem:@"收藏"
                     image:[UIImage imageNamed:@"icon_collect_select"]
                    target:self
                    action:@selector(collect)],
      [KxMenuItem menuItem:@"举报"
                     image:[UIImage imageNamed:@"article_report"]
                    target:self
                    action:@selector(report)]];
    
    KxMenuItem *first = menuItems[0];
    first.foreColor = [UIColor colorWithRed:136/255.0f green:136/255.0f blue:136/255.0f alpha:1.0];
    first.alignment = NSTextAlignmentCenter;
    [KxMenu showMenuInView:self.view
                  fromRect:CGRectMake(WLScreenW - 50, -40, 40, 40)
                 menuItems:menuItems];
}

- (void)share
{
    WLSharetowViewController *share = [[WLSharetowViewController alloc]init];
    
    share.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    
    [self presentViewController:share animated:YES completion:^{
        // NSLog(@"展示完毕");
    }];

}

- (void)collect
{
    [WLFindDataHandle requestFindArticleCollectWithTid:_articleId uid:[WLUserInfo share].userId success:^(id responseObject) {
        [MOProgressHUD showSuccessWithStatus:@"收藏成功"];
    } failure:^(NSError *error) {
        [MOProgressHUD showSuccessWithStatus:error.userInfo[@"msg"]];
    }];
}

- (void)report
{
    WLReportViewController *reportVC = [[WLReportViewController alloc] init];
    [self.navigationController pushViewController:reportVC animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else {
        return _commentsArray.count + 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *ID = @"ZGArticleCell";
        
        ZGArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        
        if (cell == nil) {
            cell = [[ZGArticleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.articleViewModel = _articleViewModel;
        // 点赞
        __typeof(cell) weakCell = cell;
        
        [cell setPraiseblock:^(UIButton *button) {
            [WLFindDataHandle requestFindArticlePriseWithTid:_articleId uid:[WLUserInfo share].userId success:^(id responseObject) {
                
                button.selected = YES;
                [weakCell addPraiseCount];
            } failure:^(NSError *error) {
                [MOProgressHUD showErrorWithStatus:error.userInfo[@"msg"]];
            }];
        }];
        
        [cell setMoreBlock:^(UIButton *button){
            
            CGRect frame = [button.superview convertRect:button.frame toView:self.view];
            frame.origin.x -= ZGPaddingMax;
            [self showMoreMenuInRect:frame];
        }];
        
        return cell;

    }else if (indexPath.section == 1 && indexPath.row == 0) {
        
        static NSString *ID = @"cell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = COLOR_WORD_BLACK;
        cell.textLabel.text = [NSString stringWithFormat:@"评价(%ld)",_commentsArray.count];
        return cell;
    }else {
        static NSString *ID = @"commentCell";
        
        WLCommetCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        
        if (cell == nil) {
            cell = [[WLCommetCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        cell.comment = _commentsArray[indexPath.row - 1];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return _articleViewModel.cellHeight;
    }else if (indexPath.row == 0){
        return 44;
    }else {
        return [MOTool MOtextSizeH:[_commentsArray[indexPath.row - 1] content] WithWidth:WLScreenW - 30 WithFount:[UIFont systemFontOfSize:12]] + 15 * 3 + 12;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return ZGPadding;
    }else {
        return 0.000001;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.000001;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
