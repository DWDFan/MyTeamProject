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
#import "WLIssueArticleViewController.h"
#import "WLFindDataHandle.h"
#import "ZGArticleCell.h"
#import "WLCommetCell.h"
//#import "ZGArticleModel.h"
#import "WLCourceModel.h"
#import "KxMenu.h"

@interface WLArticleDetailViewController ()

@property (nonatomic, strong) UITextField *replyTF;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) NSMutableArray *commentsArray;
@property (nonatomic, assign) NSInteger page;

@end

@implementation WLArticleDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNavigationBarStyleDefultWithTitle:@"详情"];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageWithOriginalName:@"素彩网www.sc115.com-136"] style:UIBarButtonItemStyleDone target:self action:@selector(rightBtnAction:)];
    
    self.tableViewStyle = UITableViewStyleGrouped;
    [self.view addSubview:self.tableView];
    
    self.bottomView = [[UIView alloc] init];
    self.bottomView.frame = CGRectMake(0, WLScreenH - IOS7_TOP_Y, WLScreenW, 40);
    self.bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bottomView];
    
    self.replyTF = [[UITextField alloc] init];
    self.replyTF.frame = CGRectMake(ZGPaddingMax, 5, WLScreenW - 2 * ZGPaddingMax - 70, 30);
    self.replyTF.placeholder = @"发表评论";
    self.replyTF.font = [UIFont systemFontOfSize:14];
    self.replyTF.borderStyle = UITextBorderStyleRoundedRect;
    [self.bottomView addSubview:self.replyTF];
    
    UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sendBtn.frame = CGRectMake(self.replyTF.right + 10, 5, 60, 30);
    sendBtn.backgroundColor = color_red;
    [sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    [sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sendBtn.layer.cornerRadius = 4;
    sendBtn.layer.masksToBounds = YES;
    sendBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [sendBtn addTarget:self action:@selector(sendReply:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:sendBtn];
    
    UIView *topLine = [[UIView alloc] init];
    topLine.frame = CGRectMake(0, 0, WLScreenW, 0.5);
    topLine.backgroundColor = COLOR_tableView_separator;
    [self.bottomView addSubview:topLine];
    
    [self.tableView addFooterWithTarget:self action:@selector(requestCommentData)];
}


- (void)requestData
{
    _page = 1;
    
    // 帖子内容
    [WLFindDataHandle requestFindArticleDetailWithTid:_articleId success:^(id responseObject) {
        
        ZGArticleModel *article = [ZGArticleModel mj_objectWithKeyValues:responseObject[@"data"]];
        _articleViewModel = [[ZGArticleViewModel alloc] init];
        _articleViewModel.article = article;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
    
    // 评论列表
    [self requestCommentData];
    
    // 阅读
    [WLFindDataHandle requestFindArticleReadWithTid:_articleId uid:[WLUserInfo share].userId success:^(id responseObject) {
        
    } failure:^(NSError *error) {
    }];
}

- (void)requestCommentData
{
    // 评论列表
    [WLFindDataHandle requestFindArticleCommentListWithTid:_articleId page:@(_page) success:^(id responseObject) {
        
        _page == 1 ? [self.commentsArray removeAllObjects] : nil;
        NSMutableArray *mArray = [WLCommentModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.commentsArray addObjectsFromArray:mArray];
        [self.tableView footerEndRefreshing];
        [self.tableView reloadData];
        _page ++;
        
    } failure:^(NSError *error) {
        
    }];
}

- (NSMutableArray *)commentsArray
{
    if (!_commentsArray) {
        _commentsArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _commentsArray;
}

#pragma mark - 编辑

- (void)showMoreMenuInRect:(CGRect)rect
{
    NSArray *menuItems =
    @[[KxMenuItem menuItem:@"修改"
                     image:[UIImage imageNamed:@"icon_endit"]
                    target:self
                    action:@selector(editArticle)],
      [KxMenuItem menuItem:@"删除"
                     image:[UIImage imageNamed:@"icon_delete"]
                    target:self
                    action:@selector(deleteArticle)]
      ];
    [KxMenu showMenuInView:self.view
                  fromRect:rect
                 menuItems:menuItems];

}

- (void)editArticle
{
    WLIssueArticleViewController *VC = [[WLIssueArticleViewController alloc] init];
    VC.type = EditTypeEdit;
    VC.articleViewModel = _articleViewModel;
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)deleteArticle
{
    [WLFindDataHandle requestFindArticleDeleteWithUid:[WLUserInfo share].userId tid:_articleId success:^(id responseObject) {
        
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        [MOProgressHUD showErrorWithStatus:error.userInfo[@"msg"]];
    }];
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

- (void)sendReply:(UIButton *)sender
{
    if (_replyTF.text.length == 0) return;
    
    [WLFindDataHandle requestFindArticleAddReplyWithUid:[WLUserInfo share].userId pid:_articleId content:_replyTF.text success:^(id responseObject) {
        
        _replyTF.text = @"";
        [_replyTF resignFirstResponder];
        
        // 刷新
        [self requestData];
        
    } failure:^(NSError *error) {
        [MOProgressHUD showErrorWithStatus:error.userInfo[@"msg"]];
    }];
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
        __typeof(self) weakSelf = self;
        [cell setPraiseblock:^(UIButton *button) {
            
            if (!button.selected) { // 未点赞
                [WLFindDataHandle requestFindArticlePriseWithTid:_articleId uid:[WLUserInfo share].userId success:^(id responseObject) {
                    
                    button.selected = YES;
                    [weakCell addPraiseCount];
                } failure:^(NSError *error) {
                    [MOProgressHUD showErrorWithStatus:error.userInfo[@"msg"]];
                }];
            }else {
                [WLFindDataHandle requestFindArticleCanclePriseWithTid:_articleId uid:[WLUserInfo share].userId success:^(id responseObject) {
                    
                    button.selected = NO;
                    [weakCell subPraiseCount];
                } failure:^(NSError *error) {
                    [MOProgressHUD showErrorWithStatus:error.userInfo[@"msg"]];
                }];
            }
        }];
        
        [cell setCommentBlock:^(UIButton *button) {

            [self.replyTF becomeFirstResponder];
        }];
        
        [cell setMoreBlock:^(UIButton *button){
            
            CGRect frame = [button.superview convertRect:button.frame toView:self.view];
            frame.origin.x -= ZGPaddingMax;
            [weakSelf showMoreMenuInRect:frame];
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

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    [self requestData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardShow:(NSNotification *)notification
{
    NSValue *value = notification.userInfo[UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    CGFloat keyboardHeight = keyboardSize.height;
    [UIView animateWithDuration:0.3 animations:^{
        self.bottomView.y = WLScreenH - IOS7_TOP_Y - keyboardHeight - self.bottomView.height;
    }];
}

- (void)keyboardHide:(NSNotification *)notification
{
    [UIView animateWithDuration:0.3 animations:^{
        self.bottomView.y = WLScreenH - IOS7_TOP_Y;
    }];
}

@end
