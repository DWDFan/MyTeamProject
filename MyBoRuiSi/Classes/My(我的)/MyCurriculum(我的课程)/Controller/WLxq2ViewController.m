//
//  WLxq2ViewController.m
//  MyBoRuiSi
//
//  Created by wsl on 16/8/9.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLxq2ViewController.h"
#import "WLorganVC.h"//机构详情
#import "WLDgViewController.h"//教学大纲
#import "WLkjViewController.h"//相关课件

@interface WLxq2ViewController ()

@end

@implementation WLxq2ViewController

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

//
-(void)fnx{
    
}



//返回组尾的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 10 ;
}

    
#pragma mark 点击cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section == 0) {
        if (indexPath.row == 3) {
            //机构详情
            WLorganVC *vc = [[WLorganVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else if (indexPath.section == 2){
        //教学大纲
        WLDgViewController *dg = [[WLDgViewController alloc]init];
        [self.navigationController pushViewController:dg animated:YES];
        
    }else if (indexPath.section == 3) {
        //相关课件
        /// stroryboard 加载@@@@@@@@@@@@@@@@@@@
        UIStoryboard *stroryboard = [UIStoryboard storyboardWithName:@"WLkjViewController" bundle:nil];
        UIViewController *vc = [stroryboard instantiateInitialViewController];
        // vc.hidesBottomBarWhenPushed = YES;//隐藏tabbar
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}

@end
