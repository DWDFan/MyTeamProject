//
//  WLPhysiologyViewController.m
//  MyBoRuiSi
//
//  Created by wsl on 16/8/5.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLPhysiologyViewController.h"
#import "WLZwViewController.h"
#import "WLHomeDataHandle.h"

@interface WLPhysiologyViewController ()

@property (weak, nonatomic) IBOutlet UILabel *questionLbl;
@property (weak, nonatomic) IBOutlet UIButton *optionA;
@property (weak, nonatomic) IBOutlet UIButton *optionB;
@property (weak, nonatomic) IBOutlet UIButton *optionC;
@property (weak, nonatomic) IBOutlet UIButton *optionD;

@end

@implementation WLPhysiologyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
    btn.backgroundColor = [UIColor clearColor];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setImage:[UIImage imageNamed:@"图层-47"] forState:UIControlStateNormal];
    [btn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
    [btn setTitle:@"生理测评" forState:UIControlStateNormal];
    self.navigationItem.titleView = btn;
    
    
    
    [self.navigationController.navigationBar setBackgroundImage:[self createImageWithColor:RGBA(255, 255, 255, 1)] forBarMetrics:UIBarMetricsDefault];
 
    [self requestData];
    
}

- (void)requestData
{
    [WLHomeDataHandle requestPaperContentWithId:_testId success:^(id responseObject) {
        
        WLLog(@"%@",responseObject);
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
//会
- (IBAction)Canbutton:(id)sender {
    
    WLZwViewController *zw = [[WLZwViewController alloc]init];
    [self.navigationController pushViewController:zw animated:YES];
}
//不会
- (IBAction)notbutton:(id)sender {
    
    WLZwViewController *zw = [[WLZwViewController alloc]init];
    [self.navigationController pushViewController:zw animated:YES];
}
//偶尔会
- (IBAction)oubutton:(id)sender {
    
    WLZwViewController *zw = [[WLZwViewController alloc]init];
    [self.navigationController pushViewController:zw animated:YES];
}
//偶尔不会
- (IBAction)ounotbutton:(id)sender {
    
    WLZwViewController *zw = [[WLZwViewController alloc]init];
    [self.navigationController pushViewController:zw animated:YES];
}

@end
