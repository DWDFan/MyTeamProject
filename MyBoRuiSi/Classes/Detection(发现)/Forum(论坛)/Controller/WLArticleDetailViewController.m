//
//  WLArticleDetailViewController.m
//  MyBoRuiSi
//
//  Created by Catskiy on 2016/10/9.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLArticleDetailViewController.h"
#import "WLFindDataHandle.h"
#import "ZGArticleCell.h"
#import "ZGArticleModel.h"

@interface WLArticleDetailViewController ()

@property (nonatomic, strong) ZGArticleViewModel *articleViewModel;

@end

@implementation WLArticleDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNavigationBarStyleDefultWithTitle:@"详情"];
    
    self.tableViewStyle = UITableViewStyleGrouped;
    [self.view addSubview:self.tableView];
    
    [self requestData];
}

- (void)requestData
{
    [WLFindDataHandle requestFindArticleDetailWithTid:_articleId success:^(id responseObject) {
        
        ZGArticleModel *article = [ZGArticleModel mj_objectWithKeyValues:responseObject[@"data"]];
        _articleViewModel = [[ZGArticleViewModel alloc] init];
        _articleViewModel.article = article;
    } failure:^(NSError *error) {
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *deteID = @"ZGArticleCell";
    
    ZGArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:deteID];
    
    if (cell == nil) {
        cell = [[ZGArticleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:deteID];
    }
    return cell;
}



@end
