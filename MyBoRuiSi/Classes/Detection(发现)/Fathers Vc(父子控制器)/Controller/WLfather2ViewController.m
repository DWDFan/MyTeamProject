//
//  WLfather2ViewController.m
//  MyBoRuiSi
//
//  Created by wsl on 16/8/10.
//  Copyright © 2016年 itcast.com. All rights reserved.
//
#import "WLfather2ViewController.h"
#import "DLTabedSlideView.h"

#import "WLForumTableViewController.h"
#import "WLQuViewController.h"
#import "WLxqusViewController.h"



@interface WLfather2ViewController ()<DLTabedSlideViewDelegate>

@property (weak, nonatomic) IBOutlet DLTabedSlideView *view_mian;


@property (nonatomic,strong ) NSMutableArray *arr_vc;
@end

@implementation WLfather2ViewController


#pragma mark viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
    btn.backgroundColor = [UIColor clearColor];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setImage:[UIImage imageNamed:@"图层-47"] forState:UIControlStateNormal];
    [btn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
    [btn setTitle:@"论坛" forState:UIControlStateNormal];
    self.navigationItem.titleView = btn;
    
    
    [self.navigationController.navigationBar setBackgroundImage:[MOTool createImageWithColor:RGBA(255, 255, 255, 1)] forBarMetrics:UIBarMetricsDefault];
    
    
    //1.
    // 添加子控制器
    [self setupChildVcs];
    
    
    
}


#pragma mark 添加子控制器
- (void)setupChildVcs
{
    
    
    self.arr_vc = [NSMutableArray array];
    [self.arr_vc addObject:[[WLForumTableViewController alloc]init]];
    [self.arr_vc addObject:[[WLQuViewController alloc]init]];
    [self.arr_vc addObject:[[WLxqusViewController alloc]init]];
    
    self.view_mian.delegate = self;
    self.view_mian.baseViewController = self;
    /** 点击之前的文字颜色*/
    self.view_mian.tabItemNormalColor = [UIColor blackColor];
    /** 点击之后的文字颜色*/
    self.view_mian.tabItemSelectedColor = color_red;
    /** 底部滑条颜色*/
    self.view_mian.tabbarTrackColor = color_red;
    /** 设置背景色*/
    self.view_mian.backgroundColor = [UIColor whiteColor];
    /** 添加背景图片*/
    self.view_mian.tabbarBackgroundImage = [UIImage imageNamed:@"QQ20160810-0"];
    //高度
    self.view_mian.tabbarHeight = 44;
    
    self.view_mian.tabbarBottomSpacing = 1.0;
    
    DLTabedbarItem *item1 = [DLTabedbarItem itemWithTitle:@"热点" image: nil selectedImage:nil];
    DLTabedbarItem *item2 = [DLTabedbarItem itemWithTitle:@"我的圈" image: nil selectedImage:nil];
    
    DLTabedbarItem *item3 = [DLTabedbarItem itemWithTitle:@"兴趣圈" image: nil selectedImage:nil];
    
    self.view_mian.tabbarItems = @[item1,item2,item3];
    [self.view_mian buildTabbar];
    self.view_mian.selectedIndex = 0;
    
    
}




- (NSInteger)numberOfTabsInDLTabedSlideView:(DLTabedSlideView *)sender{
    return self.arr_vc.count;
}
//
- (UIViewController *)DLTabedSlideViewWith:(DLTabedSlideView *)sender controllerAt:(NSInteger)index
{
    UIViewController *vc = self.arr_vc[index];
    return vc;
}

@end
