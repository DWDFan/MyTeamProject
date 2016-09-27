//
//  WLNavigationController.m
//  小微博
//
//  Created by wsl on 16/6/20.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "WLNavigationController.h"
#import "UIBarButtonItem+Item.h"
#import "WLTabBar.h"
#import "UIImage+Image.h"

@interface WLNavigationController ()<UINavigationControllerDelegate>
@property(nonatomic,strong) id popDelegate;
@end

@implementation WLNavigationController



//+ (void)initialize
//{
//    // 获取当前类下面的UIBarButtonItem
//    UIBarButtonItem *item = [UIBarButtonItem appearanceWhenContainedIn:self, nil];
//    
//    // 设置导航条按钮的文字颜色
//    NSMutableDictionary *titleAttr = [NSMutableDictionary dictionary];
//    
//    titleAttr[NSForegroundColorAttributeName] = [UIColor blackColor];
//    
//    [item setTitleTextAttributes:titleAttr forState:UIControlStateNormal];
//    
//    
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _popDelegate = self.interactivePopGestureRecognizer.delegate;
    
    
    //设置导航控制器导航上的背景图片，并且拉伸
    [self.navigationBar setBackgroundImage:[UIImage cleImage:[UIColor colorWithRed:139.0/255 green:23.0/255 blue:55.0/255 alpha:1]] forBarMetrics:UIBarMetricsDefault];
    //颜色
    NSMutableDictionary *titleAttr = [NSMutableDictionary dictionary];
    titleAttr[NSForegroundColorAttributeName] = [UIColor blackColor];
    self.navigationBar.titleTextAttributes = titleAttr;

    
    //清空返回滑动手势
    self.interactivePopGestureRecognizer.delegate = nil;
    self.delegate = self;//滑动返回代理
    
}

//控制器转调完成后调用//滑动返回
-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    if ((viewController = self.viewControllers[0])) {
        self.interactivePopGestureRecognizer.delegate = _popDelegate;
    }else{
        self.interactivePopGestureRecognizer.delegate = nil;
    }
}


-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
   
    
    if (self.viewControllers.count ) {
        viewController.hidesBottomBarWhenPushed = YES;
        //左
        UIBarButtonItem *left = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"素彩网www.sc115.com-139"] highImage:[UIImage imageNamed:@"素彩网www.sc115.com-139"] target:self action:@selector(popToPre) forControlEvents:UIControlEventTouchUpInside];
        // 设置导航条的按钮
        viewController.navigationItem.leftBarButtonItem = left;
//        //右
//        UIBarButtonItem *right = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_more"] highImage:[UIImage imageNamed:@"navigationbar_more_highlighted"] target:self action:@selector(popToRoot) forControlEvents:UIControlEventTouchUpInside];
//        viewController.navigationItem.rightBarButtonItem = right;
//
    }
     [super pushViewController:viewController animated:animated];
}

-(void)popToPre{
    
    [self popViewControllerAnimated:YES];

}

//-(void)popToRoot
//{
//    
//    [self popToRootViewControllerAnimated:YES];
//
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

 // 删除系统自带的tabBarButton
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    UITabBarController *tabBarVc = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    
    // 删除系统自带的tabBarButton
    for (UIView *tabBarButton in tabBarVc.tabBar.subviews) {
        if (![tabBarButton isKindOfClass:[WLTabBar class]]) {
            [tabBarButton removeFromSuperview];
        }
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
