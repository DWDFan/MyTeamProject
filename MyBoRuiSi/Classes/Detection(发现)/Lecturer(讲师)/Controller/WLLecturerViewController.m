//
//  WLLecturerViewController.m
//  MyBoRuiSi
//
//  Created by wsl on 16/8/2.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLLecturerViewController.h"

#import "WLLecturerTableViewCell.h"

#import "WLDetailsViewController.h"

@interface WLLecturerViewController ()

@end

@implementation WLLecturerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
    btn.backgroundColor = [UIColor clearColor];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setImage:[UIImage imageNamed:@"图层-47"] forState:UIControlStateNormal];
    [btn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
    [btn setTitle:@"讲师" forState:UIControlStateNormal];
    self.navigationItem.titleView = btn;
    
    
    
    [self.navigationController.navigationBar setBackgroundImage:[self createImageWithColor:RGBA(255, 255, 255, 1)] forBarMetrics:UIBarMetricsDefault];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUptitlevie{
    
    
    CGFloat btnY = 0;
    CGFloat btnW = WLScreenW / 3;
    CGFloat btnH = 40;
    
    
    
    for (int i = 0; i < 3; i++) {
        
        //添加view
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(i * btnW, btnY, btnW, btnH)];
        //添加button
        UIButton *btn = [[UIButton alloc] initWithFrame:view.bounds];
        
//        
//        if (i != 0) {
//            //间隔线view
//            UIView *view_main = [[UIView alloc] initWithFrame:CGRectMake(i * btnW, 0, 1, btnH)];
//            view_main.backgroundColor = [UIColor colorWithRed:136 / 250.0 green:136 / 250.0 blue:136 / 250.0 alpha:1];
//            [self.view addSubview:view_main];
//        }
        
        if (i == 0) {
            
        }else{
            //间隔线view
                        UIView *view_main = [[UIView alloc] initWithFrame:CGRectMake(i * btnW, 0, 1, btnH)];
                        view_main.backgroundColor = [UIColor colorWithRed:136 / 250.0 green:136 / 250.0 blue:136 / 250.0 alpha:0.5];
                        [self.view addSubview:view_main];
        }
        
        
        
        NSString *str;
        if (i == 0) {
            str = @"好评度";
        }else if (i == 1) {
            str = @"讲师等级";
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
    
    //底部view
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
//点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //教师详情
    WLDetailsViewController *details = [[WLDetailsViewController alloc]init];
    [self.navigationController pushViewController:details animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *deteID = @"WLLecturerTableViewCell";
    
    WLLecturerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:deteID];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:deteID owner:nil options:nil] lastObject];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}


@end
