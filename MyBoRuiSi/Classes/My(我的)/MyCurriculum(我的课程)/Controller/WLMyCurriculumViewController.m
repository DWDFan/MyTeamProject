//
//  WLMyCurriculumViewController.m
//  MyBoRuiSi
//
//  Created by wsl on 16/8/3.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLMyCurriculumViewController.h"

#import "WLSelectionViewController.h"
#import "WLDirectseedingViewController.h"
#import "WLEnterpriseTViewController.h"

@interface WLMyCurriculumViewController ()
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;

@property (weak, nonatomic) IBOutlet UIView *view3;
@end

@implementation WLMyCurriculumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
    btn.backgroundColor = [UIColor clearColor];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setImage:[UIImage imageNamed:@"图层-47"] forState:UIControlStateNormal];
    [btn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
    [btn setTitle:@"我的课程" forState:UIControlStateNormal];
    self.navigationItem.titleView = btn;
    
    
    
    [self.navigationController.navigationBar setBackgroundImage:[self createImageWithColor:RGBA(255, 255, 255, 1)] forBarMetrics:UIBarMetricsDefault];
    //设置圆角
    _view1.layer.cornerRadius = 5;
    [_view1.layer setMasksToBounds:YES];
    _view2.layer.cornerRadius = 5;
    [_view2.layer setMasksToBounds:YES];
    _view3.layer.cornerRadius = 5;
    [_view3.layer setMasksToBounds:YES];
    
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
//点播
- (IBAction)Dianbutton:(id)sender {
    
   // NSLog(@"1");
    
    WLSelectionViewController *select = [[WLSelectionViewController alloc]init];
    [self.navigationController pushViewController:select animated:YES];
}
//直播
- (IBAction)ZBbutton:(id)sender {
    
    WLDirectseedingViewController *direct = [[WLDirectseedingViewController alloc]init];
    [self.navigationController pushViewController:direct animated:YES];
}
//企业课程
- (IBAction)Qybutton:(id)sender {
    
    
    WLEnterpriseTViewController *direct = [[WLEnterpriseTViewController alloc]init];
    [self.navigationController pushViewController:direct animated:YES];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
