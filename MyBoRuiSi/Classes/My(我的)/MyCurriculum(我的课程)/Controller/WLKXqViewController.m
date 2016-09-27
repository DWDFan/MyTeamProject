//
//  WLKXqViewController.m
//  MyBoRuiSi
//
//  Created by wsl on 16/8/6.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLKXqViewController.h"
#import "WLorganVC.h"

#import "WLDirectseedingViewController.h"

@interface WLKXqViewController ()

@end

@implementation WLKXqViewController

- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
    btn.backgroundColor = [UIColor clearColor];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setImage:[UIImage imageNamed:@"图层-47"] forState:UIControlStateNormal];
    [btn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
    [btn setTitle:@"课程详情" forState:UIControlStateNormal];
    self.navigationItem.titleView = btn;
    
    
    
    [self.navigationController.navigationBar setBackgroundImage:[self createImageWithColor:RGBA(255, 255, 255, 1)] forBarMetrics:UIBarMetricsDefault];
    
    
    //设置右边的按钮图片没有渲染
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageWithOriginalName:@"图层-49"] style:UIBarButtonItemStyleDone target:self action:@selector(fnx)];
    

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
//设置右边的按钮
-(void)fnx{
    
}

#pragma mark 点击cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 3) {
        //机构
        WLorganVC *vc = [[WLorganVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 5){
        //直播课程
        
        WLDirectseedingViewController *direct = [[WLDirectseedingViewController alloc]init];
        [self.navigationController pushViewController:direct animated:YES];
        
    }
    
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
