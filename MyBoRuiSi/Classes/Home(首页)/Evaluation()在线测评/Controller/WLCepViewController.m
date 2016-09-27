//
//  WLCepViewController.m
//  MyBoRuiSi
//
//  Created by wsl on 16/8/5.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLCepViewController.h"
#import "WLDetectionTableViewCell.h"

#import "WLPhysiologyViewController.h"

@interface WLCepViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableviewtow;

@end

@implementation WLCepViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
    btn.backgroundColor = [UIColor clearColor];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setImage:[UIImage imageNamed:@"图层-47"] forState:UIControlStateNormal];
    [btn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
    [btn setTitle:@"阳光测评" forState:UIControlStateNormal];
    self.navigationItem.titleView = btn;
    
    
    
    [self.navigationController.navigationBar setBackgroundImage:[self createImageWithColor:RGBA(255, 255, 255, 1)] forBarMetrics:UIBarMetricsDefault];
    
    
    UIView *view  = [UIView new];
    
    self.tableviewtow.tableFooterView = view;
    
    
    
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return 3;
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
    
    WLDetectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:deteID];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:deteID owner:nil options:nil] lastObject];
    }
    
    if (indexPath.row == 0) {
        cell.imageView.image = [UIImage imageNamed:@"组-4"];
        cell.lableView.text = @"试卷A";
    }else if (indexPath.row ==1){
        cell.imageView.image = [UIImage imageNamed:@"组-4"];
        cell.lableView.text =@"试卷B";
    }else{
        cell.imageView.image = [UIImage imageNamed:@"组-4"];
        cell.lableView.text = @"试卷C";
    }
    
    
    return cell;
}
#pragma mark 点击tableViewcell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //生理测评
    WLPhysiologyViewController *cep  =[[WLPhysiologyViewController alloc]init];
    [self.navigationController pushViewController:cep animated:YES];
    
}
@end
