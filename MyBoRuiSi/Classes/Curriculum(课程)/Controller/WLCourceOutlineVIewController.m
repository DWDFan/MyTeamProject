//
//  WLCourceOutlineVIewController.m
//  MyBoRuiSi
//
//  Created by Catski on 16/9/24.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLCourceOutlineVIewController.h"
#import "ZGLivePlayerViewController.h"
#import "WLCourseDataHandle.h"

@interface WLCourceOutlineVIewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *outLineArray;

@end

@implementation WLCourceOutlineVIewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setSubviews];
    
    [self requestData];
}

- (void)setSubviews
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WLScreenW, WLScreenH - 64) style:UITableViewStyleGrouped];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];

    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
    btn.backgroundColor = [UIColor clearColor];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setImage:[UIImage imageNamed:@"图层-47"] forState:UIControlStateNormal];
    [btn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
    [btn setTitle:@"教学大纲" forState:UIControlStateNormal];
    self.navigationItem.titleView = btn;
    
    [self.navigationController.navigationBar setBackgroundImage:[MOTool createImageWithColor:RGBA(255, 255, 255, 1)] forBarMetrics:UIBarMetricsDefault];

}

- (void)requestData
{
    [WLCourseDataHandle requestCourceOutLineWithCourseId:_courseId success:^(id responseObject) {
        
        _outLineArray = responseObject[@"data"];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger section = _outLineArray.count;
    return section;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row = [_outLineArray[section][@"kc"] count] + 1;

    
    return row;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return [MOTool MOtextSizeH:_outLineArray[indexPath.section][@"info"] WithWidth:WLScreenW - 30 WithFount:[UIFont systemFontOfSize:12]] + 15 * 3 + 14;
    }
    return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        static NSString *ID = @"descCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            UILabel *titleLbl =[[UILabel alloc] init];
            titleLbl.frame = CGRectMake(15, 15, WLScreenW - 30, 14);
            titleLbl.font = [UIFont systemFontOfSize:14];
            titleLbl.textColor = color_red;
            titleLbl.tag = 8888;
            [cell addSubview:titleLbl];
            
            UILabel *descLbl =[[UILabel alloc] init];
            descLbl.frame = CGRectMake(15, CGRectGetMaxY(titleLbl.frame) + 15, WLScreenW - 30, 14);
            descLbl.font = [UIFont systemFontOfSize:12];
            descLbl.textColor = COLOR_WORD_GRAY_1;
            descLbl.numberOfLines = 0;
            descLbl.tag = 9999;
            [cell addSubview:descLbl];

        }
        
        UILabel *titleLbl = (UILabel *)[cell viewWithTag:8888];
        UILabel *descLbl = (UILabel *)[cell viewWithTag:9999];
        titleLbl.text = _outLineArray[indexPath.section][@"name"];
        descLbl.text = _outLineArray[indexPath.section][@"info"];
        descLbl.height = [MOTool MOtextSizeH:_outLineArray[indexPath.section][@"info"] WithWidth:WLScreenW - 30 WithFount:[UIFont systemFontOfSize:12]];
        return cell;
    }else {
        
        static NSString *ID = @"photoCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            UIImageView *imgV = [[UIImageView alloc] init];
            imgV.frame = CGRectMake(0, 0, WLScreenW, 200);
            imgV.contentMode = UIViewContentModeScaleAspectFill;
            imgV.layer.masksToBounds = YES;
            imgV.tag = 6666;
            [cell addSubview:imgV];
            
            UILabel *titleLbl =[[UILabel alloc] init];
            titleLbl.frame = CGRectMake(15, imgV.height - 14 - 15, WLScreenW - 30, 14);
            titleLbl.font = [UIFont systemFontOfSize:14];
            titleLbl.textColor = [UIColor whiteColor];
            titleLbl.tag = 7777;
            [cell addSubview:titleLbl];
        }
        
        UIImageView *imgV = (UIImageView *)[cell viewWithTag:6666];
        UILabel *titleLbl = (UILabel *)[cell viewWithTag:7777];
        id kc = _outLineArray[indexPath.section][@"kc"][indexPath.row - 1];
        if (![kc isKindOfClass:[NSNull class]]) {
            titleLbl.text = _outLineArray[indexPath.section][@"kc"][indexPath.row - 1][@"name"];
            NSString *photo = _outLineArray[indexPath.section][@"kc"][indexPath.row - 1][@"photo"];
            [imgV sd_setImageWithURL:[NSURL URLWithString:photo] placeholderImage:nil];

        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.000001;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row != 0) {
        
        NSMutableArray *decodeParm = [[NSMutableArray alloc] init];
        [decodeParm addObject:@"software"];
        [decodeParm addObject:@"videoOnDemand"];
        NSURL *url = [NSURL URLWithString:_outLineArray[indexPath.section][@"kc"][indexPath.row - 1][@"video"]];
        
        ZGLivePlayerViewController *playerVC = [[ZGLivePlayerViewController alloc] initWithURL:url andDecodeParm:decodeParm];
        playerVC.courseId = _outLineArray[indexPath.section][@"kc"][indexPath.row - 1][@"id"];
        [self.navigationController pushViewController:playerVC animated:YES];
    }
}

@end
