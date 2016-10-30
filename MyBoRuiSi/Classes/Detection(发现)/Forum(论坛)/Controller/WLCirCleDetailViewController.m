//
//  WLCirCleDetailViewController.m
//  MyBoRuiSi
//
//  Created by Catskiy on 2016/10/10.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLCirCleDetailViewController.h"
#import "WLArticleDetailViewController.h"
#import "WLIssueArticleViewController.h"
#import "WLFindDataHandle.h"
#import "ZGArticleCell.h"
#import "WLCircleInfoCell.h"
#import "ZGArticleModel.h"
#import "WLCircleModel.h"

@interface WLCirCleDetailViewController ()

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) WLCircleInfoModel *infoModel;
@property (nonatomic, strong) UIButton *issueBtn;

@end

@implementation WLCirCleDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBarStyleDefultWithTitle:self.circleName];
    [self.view addSubview:self.tableView];
    
    UIButton *issueBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    issueBtn.frame = CGRectMake(0, WLScreenH - IOS7_TOP_Y - 49, WLScreenW, 49);
    issueBtn.backgroundColor = color_red;
    issueBtn.hidden = YES;
    issueBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [issueBtn setTitle:@"发帖" forState:UIControlStateNormal];
    [issueBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [issueBtn addTarget:self action:@selector(issueBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:issueBtn];
    _issueBtn = issueBtn;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _page = 1;
    [self requestData];
}

- (void)requestData
{
    [WLFindDataHandle requestFindCircleInfoWithQid:_circleId uid:[WLUserInfo share].userId success:^(id responseObject) {
        
        _infoModel = [WLCircleInfoModel mj_objectWithKeyValues:responseObject[@"data"]];
        if (_infoModel.isFollow) {
            _issueBtn.hidden = NO;
            self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
        }
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
    
    [WLFindDataHandle requestFindCircleArticleWithQid:_circleId page:@(_page) success:^(id responseObject) {
        _page == 1 ? [self.dataSoureArray removeAllObjects] : nil;
        NSArray *articles = [ZGArticleModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        for (ZGArticleModel *art in articles) {
            ZGArticleViewModel *artVM = [[ZGArticleViewModel alloc] init];
            artVM.article = art;
            [self.dataSoureArray addObject:artVM];
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

- (void)issueBtnAction:(UIButton *)sender
{
    WLIssueArticleViewController *issueVC = [[WLIssueArticleViewController alloc] init];
    issueVC.circleId = _circleId;
    [self.navigationController pushViewController:issueVC animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    }else {
        return self.dataSoureArray.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 100;
    }else {
        ZGArticleViewModel *vModel = [self.dataSoureArray objectAtIndex:indexPath.row];
        return  vModel.cellHeight;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section == 0) {
        
        static NSString *ID = @"WLCircleInfoCell";
        WLCircleInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:ID owner:nil options:nil] firstObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.circleInfo = _infoModel;
        
        __typeof (self)weakSelf = self;
        [cell setBlock:^(UIButton *sender) {
            
            if (![WLUserInfo share].isLogin) {
                
                [self alertLogin];
                return ;
            }

            
            NSNumber *type = sender.selected ? @2 : @1;
            [WLFindDataHandle requestFindCircleFollowWithQid:_circleId uid:[WLUserInfo share].userId type:type success:^(id responseObject) {
                sender.selected = !sender.selected;
                _infoModel.isFollow = sender.selected;
                [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshMyCircle" object:nil];
                if (sender.selected) {
                    weakSelf.issueBtn.hidden = NO;
                    weakSelf.tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
                }else {
                    weakSelf.issueBtn.hidden = YES;
                    weakSelf.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
                }
            } failure:^(NSError *error) {
                [MOProgressHUD showErrorWithStatus:error.userInfo[@"msg"]];
            }];
        }];
        return cell;
        
    }else {
        
        static NSString *ID = @"ZGArticleCell";
        ZGArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        
        if (cell == nil) {
            cell = [[ZGArticleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            cell.type = ZGArticleCellTypeList;
        }
        cell.articleViewModel = self.dataSoureArray[indexPath.row];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        WLArticleDetailViewController *detailVC = [[WLArticleDetailViewController alloc] init];
        ZGArticleViewModel *vModel = self.dataSoureArray[indexPath.row];
        detailVC.articleId = vModel.article.tid;
        detailVC.articleViewModel = vModel;
        [self.navigationController pushViewController:detailVC animated:YES];
    }
}

@end
