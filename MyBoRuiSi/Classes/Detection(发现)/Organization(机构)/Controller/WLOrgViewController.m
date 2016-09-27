//
//  WLOrgViewController.m
//  MyBoRuiSi
//
//  Created by wsl on 16/8/2.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLOrgViewController.h"
#import "WLOrganizatioTableViewCell.h"

#import "WLorganVC.h"

@interface WLOrgViewController ()

@end

@implementation WLOrgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
    btn.backgroundColor = [UIColor clearColor];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setImage:[UIImage imageNamed:@"图层-47"] forState:UIControlStateNormal];
    [btn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
    [btn setTitle:@"机构" forState:UIControlStateNormal];
    self.navigationItem.titleView = btn;
    
    
    
    [self.navigationController.navigationBar setBackgroundImage:[self createImageWithColor:RGBA(255, 255, 255, 1)] forBarMetrics:UIBarMetricsDefault];
    
    //添加view
    [self setUptitlevie];
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
-(void)setUptitlevie{
    

    CGFloat btnY = 0;
    CGFloat btnW = WLScreenW / 3;
    CGFloat btnH = 40;
    
    //九宫格生成代码
    
    for (int i = 0; i < 3; i++) {
        
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(i * btnW, btnY, btnW, btnH)];

        UIButton *btn = [[UIButton alloc] initWithFrame:view.bounds];
        
        
        if (i != 0) {
            
            UIView *view_main = [[UIView alloc] initWithFrame:CGRectMake(i * btnW, 0, 1, btnH)];
            view_main.backgroundColor = [UIColor colorWithRed:136 / 250.0 green:136 / 250.0 blue:136 / 250.0 alpha:1];
            [self.view addSubview:view_main];
        }
        

        
        NSString *str;
        if (i == 0) {
            str = @"企业规模";
        }else if (i == 1) {
            str = @"企业性质";
        }else{
            str = @"关注度";
        }
        btn.tag = i;
        [btn setTitle:str forState:UIControlStateNormal];
        [btn setTitleColor:RGBA(82, 82, 82, 1) forState:UIControlStateNormal];
  
        
        
        [btn addTarget:self action:@selector(button_main:) forControlEvents:UIControlEventTouchDown];
        
        [view addSubview:btn];
        
        [self.view addSubview:view];

        
        
    }
    
    
    UIView *view_num = [[UIView alloc] initWithFrame:CGRectMake(0, 40, WLScreenW, 1)];
    view_num.backgroundColor = [UIColor colorWithRed:237 / 250.0 green:237 / 250.0 blue:237 / 250.0 alpha:1];

    [self.view addSubview:view_num];
    
    
    
}

- (void)button_main:(UIButton *)button{
    
    
    if (button.tag == 0) {
        NSLog(@"1");
        
    }else if (button.tag == 1) {
        NSLog(@"2");
        
    }else{
        NSLog(@"3");
        
    }
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 9;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *deteID = @"WLOrganizatioTableViewCell";
    
    WLOrganizatioTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:deteID];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:deteID owner:nil options:nil] lastObject];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}



//点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //机构详情
    WLorganVC *details = [[WLorganVC alloc]init];
    
    [self.navigationController pushViewController:details animated:YES];
    
    
}



@end
