//
//  WLIncomeViewController.m
//  MyBoRuiSi
//
//  Created by mo on 16/8/6.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLIncomeViewController.h"

#import "WLMyDataHandle.h"
#import "WLCostModel.h"

@interface WLIncomeViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) NSUInteger page;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation WLIncomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
    btn.backgroundColor = [UIColor clearColor];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setImage:[UIImage imageNamed:@"图层-47"] forState:UIControlStateNormal];
    [btn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
    [btn setTitle:@"收入明细" forState:UIControlStateNormal];
    self.navigationItem.titleView = btn;
    
    
    //    [MOTool createImageWithColor:]
    [self.navigationController.navigationBar setBackgroundImage:[MOTool createImageWithColor:RGBA(255, 255, 255, 1)] forBarMetrics:UIBarMetricsDefault];
    
    _page = 1;
    
    //获取支出数据
    [self requestGetMyInComeData];
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

//MARK:tableView代理方法----------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Id = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Id];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:Id];
        //隐藏点击cell的效果
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    
    WLCostModel *model = self.dataSource[indexPath.row];
    cell.textLabel.text = model.action;
    cell.detailTextLabel.text = model.addtime;
    
    UILabel *right_lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 21)];
    right_lab.textAlignment = NSTextAlignmentRight;
    right_lab.textColor = [UIColor greenColor];
    right_lab.font = [UIFont systemFontOfSize:15];
    right_lab.text = [NSString stringWithFormat:@"+%@.00",model.price];
    cell.accessoryView = right_lab;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}
- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}


#pragma mark - Request
- (void)requestGetMyInComeData{
    [WLMyDataHandle requestGetMyInComeWithUid:[WLUserInfo share].userId page:@(self.page) success:^(id responseObject) {
        self.dataSource = responseObject;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

@end
