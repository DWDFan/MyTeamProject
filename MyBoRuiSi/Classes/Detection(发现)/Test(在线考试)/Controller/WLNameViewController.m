//
//  WLNameViewController.m
//  MyBoRuiSi
//
//  Created by wsl on 16/8/5.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLNameViewController.h"
#import "WLnameTableViewCell.h"

#import "WLfillingViewController.h"
#import "WLChoiceViewController.h"
#import "WLJudgmentsViewController.h"
#import "WLQuestionViewController.h"

@interface WLNameViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableviewt;

@end

@implementation WLNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
    btn.backgroundColor = [UIColor clearColor];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setImage:[UIImage imageNamed:@"图层-47"] forState:UIControlStateNormal];
    [btn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
    [btn setTitle:@"试卷名称" forState:UIControlStateNormal];
    self.navigationItem.titleView = btn;
    
    
    
    [self.navigationController.navigationBar setBackgroundImage:[self createImageWithColor:RGBA(255, 255, 255, 1)] forBarMetrics:UIBarMetricsDefault];
    
    UIView *view = [UIView new];
    self.tableviewt.tableFooterView = view;
    
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
    
    
    return 4;
}


//cell高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

////返回组头的高度
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    
//    return 10 ;
//}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *deteID = @"WLnameTableViewCell";
    
    WLnameTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:deteID];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:deteID owner:nil options:nil] lastObject];
    }
    
    if (indexPath.row == 0) {
       
        cell.labelone.text = @"填空题";
    }else if (indexPath.row ==1){
      
        cell.labelone.text =@"选择题";
    }else if (indexPath.row == 2){
          cell.labelone.text =@"判断题";
    }else{
          cell.labelone.text =@"问答题";
    }
    
    return cell;
}



#pragma mark 点击tableViewcell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //填空题
      if (indexPath.row == 0) {
         WLfillingViewController *cep  =[[WLfillingViewController alloc]init];
        [self.navigationController pushViewController:cep animated:YES];

      }else if (indexPath.row == 1){
          //选择
          WLChoiceViewController *cep  =[[WLChoiceViewController alloc]init];
          [self.navigationController pushViewController:cep animated:YES];
          
      }else if (indexPath.row == 2){
          //判断
          WLJudgmentsViewController *cep  =[[WLJudgmentsViewController alloc]init];
          [self.navigationController pushViewController:cep animated:YES];
          
      }else{
          //问答
          WLQuestionViewController *cep  =[[WLQuestionViewController alloc]init];
          [self.navigationController pushViewController:cep animated:YES];
      }
    
}




@end
