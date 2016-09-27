//
//  WLEvaluationViewController.m
//  MyBoRuiSi
//
//  Created by wsl on 16/8/4.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLEvaluationViewController.h"
#import "WLDetectionTableViewCell.h"

#import "WLRecordViewController.h"
#import "WLCepViewController.h"

@interface WLEvaluationViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableview_main;
@end

@implementation WLEvaluationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
    btn.backgroundColor = [UIColor clearColor];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setImage:[UIImage imageNamed:@"图层-47"] forState:UIControlStateNormal];
    [btn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
    [btn setTitle:@"在线测评" forState:UIControlStateNormal];
    self.navigationItem.titleView = btn;
    
    
    
    [self.navigationController.navigationBar setBackgroundImage:[self createImageWithColor:RGBA(255, 255, 255, 1)] forBarMetrics:UIBarMetricsDefault];
    
    
    UIView *view = [UIView new];
    
    self.tableview_main.tableFooterView = view;
    
    
    
    
    //导航栏右边按钮
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"测评记录" style:UIBarButtonItemStyleDone target:self action:@selector(Test)];
    
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor colorWithRed:164 /255.0 green:30/255.0 blue:59/255.0 alpha:1];

    
    
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

//测评记录
-(void)Test{
    
    
    WLRecordViewController *recor = [[WLRecordViewController alloc]init];
    [self.navigationController pushViewController:recor animated:YES];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        cell.lableView.text = @"xxxx测评";
    }else if (indexPath.row ==1){
        cell.imageView.image = [UIImage imageNamed:@"组-4"];
        cell.lableView.text =@"xxxx测评";
    }else{
        cell.imageView.image = [UIImage imageNamed:@"组-4"];
        cell.lableView.text = @"xxxx测评";
    }
    
    return cell;
}


#pragma mark 点击tableViewcell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //xx测评
    WLCepViewController *cep  =[[WLCepViewController alloc]init];
    [self.navigationController pushViewController:cep animated:YES];
    
}






@end
