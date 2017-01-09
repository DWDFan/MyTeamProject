//
//  WLTestTableViewController.m
//  MyBoRuiSi
//
//  Created by wsl on 16/8/1.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLTestTableViewController.h"

#import "WLTestTableViewCell.h"

#import "UIView+Frame.h"

#import "WLNameViewController.h"
#import "WLHomeDataHandle.h"
#import "WLExaminationHelper.h"

@interface WLTestTableViewController ()

/** 存放所有的标题按钮 */
@property (nonatomic, strong) NSMutableArray *titleButtons;

@property (nonatomic,strong)UIView *view_main;

@property (nonatomic,strong)UIView *backgroundView;
@property (nonatomic, strong) UILabel *tipLbl;
@property (nonatomic, strong) NSArray *paperArray;

@property (nonatomic, strong) NSString *paperId;
@property (nonatomic, strong) NSString *paperName;
@property (nonatomic, assign) NSInteger index;
@end

@implementation WLTestTableViewController

-(NSMutableArray *)titleButtons{
    if (_titleButtons == nil) {
        _titleButtons = [NSMutableArray array];
    }
    return _titleButtons;
}

- (UIView *)view_main{
    if (!_view_main) {
        _view_main = [[UIView alloc] init];
    }
    return _view_main;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addView];
    
    [self.navigationController.navigationBar setBackgroundImage:[self createImageWithColor:RGBA(255, 255, 255, 1)] forBarMetrics:UIBarMetricsDefault];

    [self requestData];
}



- (void)requestData
{
    [WLHomeDataHandle requestExaminationWithUid:[WLUserInfo share].userId success:^(id responseObject) {
        
        _paperArray = responseObject[@"data"];
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
    }];
}

- (void)addView{
    
    
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake((WLScreenW - 50)/ 2, ([UIScreen mainScreen].bounds.size.height - 50) / 2, 50, 50)];
    
    _backgroundView = backgroundView;
    
    [self.view addSubview:_backgroundView];
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake((WLScreenW - 50)/ 2, ([UIScreen mainScreen].bounds.size.height - 50) / 2, 50, 50)];
    
    _view_main = view;
    
    
    UILabel *labelOne  = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 260, 20)];
    labelOne.text = @"考试规则";
    labelOne.font = [UIFont systemFontOfSize:16];
    labelOne.textColor = [UIColor colorWithRed:82 / 250.0 green:82 / 250.0  blue:82 / 250.0  alpha:1];
    [_view_main addSubview:labelOne];
    
    
    UILabel *lableTwo = [[UILabel alloc] initWithFrame:CGRectMake(20, 40, 260, 60)];
    lableTwo.font = [UIFont systemFontOfSize:14.0];
    lableTwo.textColor = [UIColor colorWithRed:82 / 250.0 green:82 / 250.0  blue:82 / 250.0  alpha:1];
    lableTwo.numberOfLines = 0;
    _tipLbl = lableTwo;
    [_view_main addSubview:lableTwo];
    
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(20, 100, 260 ,1)];
    lineView.backgroundColor = [UIColor redColor];
    [_view_main addSubview:lineView];
    
    _view_main.hidden = YES;
    
    
    
    UIButton *buttonOne = [[UIButton alloc] initWithFrame:CGRectMake(25, 110, 120, 45)];
    buttonOne.backgroundColor = [UIColor colorWithRed:177 /250.0 green:5 / 250.0 blue:59 / 250.0 alpha:1];
    [buttonOne setTitle:@"稍后开始" forState:UIControlStateNormal];
    [buttonOne.layer setMasksToBounds:YES];
    [buttonOne.layer setCornerRadius:5.0];
    
    
    [buttonOne addTarget:self action:@selector(buttonOne:) forControlEvents:UIControlEventTouchDown];
    
    [_view_main addSubview:buttonOne];
    
    
    UIButton *buttonTwo = [[UIButton alloc] initWithFrame:CGRectMake(155, 110, 120, 45)];
    buttonTwo.backgroundColor = [UIColor colorWithRed:177 /250.0 green:5 / 250.0 blue:59 / 250.0 alpha:1];
    [buttonTwo setTitle:@"开始考试" forState:UIControlStateNormal];
    [buttonTwo.layer setMasksToBounds:YES];
    [buttonTwo.layer setCornerRadius:5.0];
    
    [buttonTwo addTarget:self action:@selector(buttonTwo:) forControlEvents:UIControlEventTouchDown];
    
    
    [_view_main addSubview:buttonTwo];
    
    
    [_backgroundView addSubview:view];
    
    
    //tableView偏移量
    // self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
    btn.backgroundColor = [UIColor clearColor];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setImage:[UIImage imageNamed:@"图层-47"] forState:UIControlStateNormal];
    [btn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
    [btn setTitle:@"在线考试" forState:UIControlStateNormal];
    self.navigationItem.titleView = btn;

    
    self.tableView.tableFooterView = [UIView new];
    
}

- (void)buttonOne:(UIButton *)button{    
    [UIView animateWithDuration:0.32  animations:^{
        
        _view_main.hidden = YES;
        _backgroundView.frame = CGRectMake(0, 0, 0, 0);
    } completion:^(BOOL finished) {
        
          _backgroundView.hidden = YES;
        
        _backgroundView.frame = CGRectMake((WLScreenW - 50)/ 2, ([UIScreen mainScreen].bounds.size.height - 50) / 2, 50, 50);
        _view_main.frame = CGRectMake((WLScreenW - 50)/ 2, ([UIScreen mainScreen].bounds.size.height - 50) / 2, 50, 50);
    }];
}

// 开始考试
- (void)buttonTwo:(UIButton *)button{
    
    _backgroundView.hidden = YES;
    
    NSString *kid = self.paperArray[self.index][@"kid"];
    NSString *cid = self.paperArray[self.index][@"cid"];
    
    [WLHomeDataHandle requestStartExaminationWithUid:[WLUserInfo share].userId kid:kid mid:cid success:^(id responseObject) {
        
        NSString *timeLongStr = self.paperArray[self.index][@"timelong"];
        NSInteger timelong = [timeLongStr integerValue] * 60;
        [WLExaminationHelper sharedInstance].timelong = timelong;
        [WLExaminationHelper sharedInstance].kid = kid;
        
        WLNameViewController *name = [[WLNameViewController alloc]init];
        name.title = _paperName;
        name.paperId = _paperId;
        name.kid = kid;
        [self.navigationController pushViewController:name animated:YES];
        
    } failure:^(NSError *error) {
        
    }];
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
//
//- (void)titleButtonClick:(WLTitlebutton *)titleButton{
//    
//}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.paperArray.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *deteID = @"WLTestTableViewCell";
    
    WLTestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:deteID];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:deteID owner:nil options:nil] lastObject];
    }
    NSDictionary *dic = _paperArray[indexPath.row];
    cell.nameLbl.text = [MOTool getNULLString:dic[@"name"]];
    cell.timeLbl.text = [NSString stringWithFormat:@"考试时长:%@分钟",[MOTool getNULLString:dic[@"timelong"]]];
    cell.testNumLbl.text = [NSString stringWithFormat:@"剩余考试次数:%@",[MOTool getNULLString:dic[@"times"]]];
    [cell.photoImgV sd_setImageWithURL:[NSURL URLWithString:dic[@"photo"]] placeholderImage:nil];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}



//点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    _view_main.hidden = NO;
    _backgroundView.hidden = NO;
    _paperId = _paperArray[indexPath.row][@"id"];
    _paperName = _paperArray[indexPath.row][@"name"];
    _index = indexPath.row;
    
    NSString *tipStr = [NSString stringWithFormat:@"考试时间为%@分钟,考试过程中不得退出程序,将视为放弃,请把握考试时间!",_paperArray[_index][@"timelong"]];
    _tipLbl.text = tipStr;
    

    [UIView animateWithDuration:0.32 animations:^{
        
      CGRect  frame =  CGRectMake((WLScreenW - 300) / 2, ([UIScreen mainScreen].bounds.size.height - 170) / 2 - 64, 300, 170);
        
        _backgroundView.backgroundColor = [UIColor colorWithRed:136 / 250.0 green:136 / 250.0 blue:136 / 250.0 alpha:0.5];
        _backgroundView.frame = tableView.bounds;
        
        
        _view_main.frame = frame;
        _view_main.backgroundColor = [UIColor whiteColor];
        
        
    }];
    
    
    
    
}


@end
