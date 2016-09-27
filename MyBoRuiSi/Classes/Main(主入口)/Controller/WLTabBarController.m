//
//  WLTabBarController.m
//  小微博
//
//  Created by wsl on 16/6/18.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "WLTabBarController.h"
#import "UIImage+Image.h"
#import "WLTabBar.h"

#import "WLHome.h"
#import "WLCurriculum.h"
#import "WLDetection.h"
#import "WLMyController.h"

#import "WLNavigationController.h"

@interface WLTabBarController ()<WLTabBarDelegate>

@property(nonatomic,strong) NSMutableArray *items;

@end

@implementation WLTabBarController

//懒加载

-(NSMutableArray *)items
{
    if (_items == nil) {
        _items = [NSMutableArray array];
    }
    return _items;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   //添加控制器
    [self setUptabBarController];
    //添加tabbar
    [self setUptabBar];
   }


//添加tabbar按钮
-(void)setUptabBar{
    //添加自定义tabbar
    WLTabBar *tabbar = [[WLTabBar alloc]initWithFrame:self.tabBar.bounds];
    
    tabbar.backgroundColor = [UIColor whiteColor];
    // 设置代理
    tabbar.delegate = self;//转跳控制器的代理

    tabbar.items = self.items;//把可变数组里的items的值赋值到tabbar的数组里面
    //移除系统的tabbar
   // [self.tabBar removeFromSuperview];//这样系统的按钮就要自己一个一个移除
    
    [self.tabBar addSubview:tabbar];//添加到view上面
 }


#pragma mark WLTabBar 的代理方法//专跳控制器的代理
-(void)tabBar:(WLTabBar *)tabBar didClickButton:(NSInteger)index
{
    self.selectedIndex = index;
    
}



//删除系统tabbar上的按钮
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    for (UIView *tabbarbutton in self.tabBar.subviews) {
        if ([tabbarbutton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabbarbutton removeFromSuperview];
        }
    }
    
}

//添加子控制器
-(void)setUptabBarController{
   
    
    //首页
    WLHome *home = [[WLHome alloc]init];
    [self setUpviewController:home image:[UIImage imageNamed:@"图层-56"] selectedImage:[UIImage imageWithOriginalName:@"图层-56-拷贝"] title:@"首页"];
    //home.view.backgroundColor =[UIColor greenColor];
    
    //课程
    WLCurriculum *ab = [[WLCurriculum alloc]init];
    [self setUpviewController:ab image:[UIImage imageNamed:@"图层-48"] selectedImage:[UIImage imageWithOriginalName:@"图层-48-拷贝"] title:@"课程"];
      //ab.view.backgroundColor = [UIColor lightGrayColor];
   //发现
    WLDetection *cc = [[WLDetection alloc]init];
    [self setUpviewController:cc image:[UIImage imageNamed:@"图层-55"] selectedImage:[UIImage imageWithOriginalName:@"图层-55-拷贝"] title:@"发现"];
    //cc.view.backgroundColor = [UIColor yellowColor];
    //我
    WLMyController *ww = [[WLMyController alloc]init];
    
    [self setUpviewController:ww image:[UIImage imageNamed:@"图层-54"] selectedImage:[UIImage imageWithOriginalName:@"图层-54-拷贝"] title:@"我的"];

       //ww.view.backgroundColor = [UIColor purpleColor];
   
    
}

#pragma mark 添加子控制器
-(void)setUpviewController:(UIViewController *)vc image:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSString *)title{
    
//    
//    vc.navigationItem.title = title;
//    
//    vc.tabBarItem.title = title;
    
    vc.title = title;
    
    vc.tabBarItem.image = image;
    
    vc.tabBarItem.selectedImage = selectedImage;
    //vc.tabBarItem.badgeValue = @"99";
    //包装成导航控制器
    WLNavigationController *nvc = [[WLNavigationController alloc]initWithRootViewController:vc];
    [self addChildViewController:nvc];
    
    //把所有的属性,控件放到items可变数组中
    [self.items addObject:vc.tabBarItem];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
