//
//  WLTestViewController.m
//  MyBoRuiSi
//
//  Created by mo on 16/8/4.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLTestViewController.h"
#import "WLExamsTableViewCell.h"
#import "WLAnswerTableViewController.h"
#import "WLAnswerViewController.h"

#import "WLHomeDataHandle.h"
#import "WLMyDataHandle.h"
#import "WLMyTestModel.h"

@interface WLTestViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *TestTabble;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation WLTestViewController

-(UITableView *)TestTabble{
    if (_TestTabble == nil) {
        _TestTabble = [[UITableView alloc]init];
    }
    return _TestTabble;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    btn.backgroundColor = [UIColor clearColor];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setImage:[UIImage imageNamed:@"图层-47"] forState:UIControlStateNormal];
    [btn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
    [btn setTitle:@"我的考试" forState:UIControlStateNormal];
    self.navigationItem.titleView = btn;
    
    
    [self.navigationController.navigationBar setBackgroundImage:[self createImageWithColor:RGBA(255, 255, 255, 1)] forBarMetrics:UIBarMetricsDefault];
    
    self.TestTabble.delegate = self;
    self.TestTabble.dataSource = self;
    self.TestTabble.showsHorizontalScrollIndicator = NO;
    self.TestTabble.rowHeight =100;
    self.TestTabble.tableFooterView = [UIView new];
    
    WEAKSELF;
    [self.TestTabble addFooterWithCallback:^{
        weakSelf.page ++;
        [weakSelf requestGetMyTestWithPage:weakSelf.page];
    }];
    
    _page = 1;
    [self requestGetMyTestWithPage:self.page];
    
}

#pragma mark - Getter
- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

//返回多少组
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}

//返回多少行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}



// 返回每行显示内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuseId = @"WLExamsTableViewCell";
    WLExamsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"WLExamsTableViewCell" owner:nil options:nil] lastObject];
    }
    cell.model = self.dataSource[indexPath.row];
    cell.lookAnswerBlock = ^(){
        //查看答案
        WLAnswerViewController *vc = [[WLAnswerViewController alloc] init];
        vc.kid = [self.dataSource[indexPath.row] kid];
        [self.navigationController pushViewController:vc animated:YES];
    };
    return cell;
}

//设置点击跳转到下一个界面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

//    NSLog(@"%ld",indexPath.row);
//    WLAnswerTableViewController *vc = [[WLAnswerTableViewController alloc]init];
//    [self.navigationController pushViewController:vc animated:YES];
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


#pragma mark - Request
- (void)requestGetMyTestWithPage:(NSUInteger)page
{    
    [WLHomeDataHandle  requestMyExaminationWithUid:[WLUserInfo share].userId page:@(page) num:@10 success:^(id responseObject) {
        NSArray *dataArray = [WLMyTestModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.dataSource addObjectsFromArray:dataArray];
        
        [self.TestTabble footerEndRefreshing];
        [self.TestTabble reloadData];
    } failure:^(NSError *error) {
        [self.TestTabble footerEndRefreshing];
        [MOProgressHUD showErrorWithStatus:error.userInfo[@"msg"]];
    }];
}

@end
