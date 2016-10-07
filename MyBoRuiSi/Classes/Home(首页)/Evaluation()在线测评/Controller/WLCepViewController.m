//
//  WLCepViewController.m
//  MyBoRuiSi
//
//  Created by wsl on 16/8/5.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLCepViewController.h"
#import "WLPaperTypeCell.h"
#import "WLHomeDataHandle.h"
#import "WLPhysiologyViewController.h"

@interface WLCepViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableviewtow;
@property (nonatomic, strong) NSArray *paperArray;
@property (nonatomic, strong) UIButton *titleView;

@end

@implementation WLCepViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
    btn.backgroundColor = [UIColor clearColor];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setImage:[UIImage imageNamed:@"图层-47"] forState:UIControlStateNormal];
    [btn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
    [btn setTitle:_paperTypeName forState:UIControlStateNormal];
    self.navigationItem.titleView = btn;
    _titleView = btn;
    
    
    [self.navigationController.navigationBar setBackgroundImage:[MOTool createImageWithColor:RGBA(255, 255, 255, 1)] forBarMetrics:UIBarMetricsDefault];
    
    
    UIView *view  = [UIView new];
    
    self.tableviewtow.tableFooterView = view;
    
    
    [self requestData];
}

- (void)requestData
{
    [WLHomeDataHandle requestPaperListWithType:_paperType page:@1 success:^(id responseObject) {
        
        self.paperArray = responseObject[@"data"];
        [self.tableviewtow reloadData];
    } failure:^(NSError *error) {
        
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return _paperArray.count;
}


//cell高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

//返回组头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10 ;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *deteID = @"WLDetectionTableViewCell";
    
    WLPaperTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:deteID];
    
    if (cell == nil) {
        cell = [[WLPaperTypeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:deteID];
    }
    
    cell.photoImgV.image = [UIImage imageNamed:@"组-4"];
    cell.nameLbl.text = _paperArray[indexPath.row][@"name"];
    return cell;
}
#pragma mark 点击tableViewcell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //生理测评
    WLPhysiologyViewController *cep  =[[WLPhysiologyViewController alloc]init];
    [self.navigationController pushViewController:cep animated:YES];
    
}
@end
