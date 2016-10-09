//
//  WLShoppingsTableViewController.m
//  MyBoRuiSi
//
//  Created by 莫瑞伟 on 16/8/4.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "DLTabedSlideView.h"
#import "WLShoppingsTableViewController.h"
#import "WLShoppingsTableViewController1.h"
#import "WLShoppingsTableViewController2.h"
#import "WLShoppingsTableViewController3.h"
#import "WLShoppingsTableViewController4.h"
#import "UIImage+Image.h"

@interface WLShoppingsTableViewController ()<DLTabedSlideViewDelegate>

@property (strong, nonatomic) IBOutlet DLTabedSlideView *tabedSlideView;
@property (nonatomic,strong ) NSMutableArray *arr_vc;
@property (nonatomic,weak) MOTempViewController *vc_temp;


@end

@implementation WLShoppingsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self setTitleButtonWithString:@"编辑"];
   
    [self initSelf];
    
}
- (void)initSelf{
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
    btn.backgroundColor = [UIColor clearColor];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setImage:[UIImage imageNamed:@"图层-47"] forState:UIControlStateNormal];
    [btn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
    [btn setTitle:@" 我的订单" forState:UIControlStateNormal];
    self.navigationItem.titleView = btn;
    
    self.arr_vc = [NSMutableArray array];
    [self.arr_vc addObject:[[WLShoppingsTableViewController1 alloc]init]];
    [self.arr_vc addObject:[[WLShoppingsTableViewController2 alloc]init]];
    [self.arr_vc addObject:[[WLShoppingsTableViewController3 alloc]init]];
    [self.arr_vc addObject:[[WLShoppingsTableViewController4 alloc]init]];
    
    self.tabedSlideView.delegate = self;
    self.tabedSlideView.baseViewController = self;
    /** 点击之前的文字颜色*/
    self.tabedSlideView.tabItemNormalColor = [UIColor blackColor];
    /** 点击之后的文字颜色*/
    self.tabedSlideView.tabItemSelectedColor = color_red;
    /** 底部滑条颜色*/
    self.tabedSlideView.tabbarTrackColor = color_red;
    /** 设置背景色*/
    self.tabedSlideView.backgroundColor = [UIColor whiteColor];
    /** 添加背景图片*/
    self.tabedSlideView.tabbarBackgroundImage = [UIImage imageNamed:@"tableView_bak"];
    self.tabedSlideView.tabbarHeight = 44;
    self.tabedSlideView.tabbarBottomSpacing = 3.0;
    
    DLTabedbarItem *item1 = [DLTabedbarItem itemWithTitle:@"购物车" image: nil selectedImage:nil];
    DLTabedbarItem *item2 = [DLTabedbarItem itemWithTitle:@"待付款" image: nil selectedImage:nil];
    DLTabedbarItem *item3 = [DLTabedbarItem itemWithTitle:@"已完成" image: nil selectedImage:nil];
    DLTabedbarItem *item4 = [DLTabedbarItem itemWithTitle:@"已关闭" image: nil selectedImage:nil];
    
    self.tabedSlideView.tabbarItems = @[item1,item2,item3,item4];
    [self.tabedSlideView buildTabbar];
    self.tabedSlideView.selectedIndex = 0;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //设置导航控制器导航上的背景图片，并且拉伸
    [self.navigationController.navigationBar setBackgroundImage:[UIImage cleImage:RGBA(255, 255, 255, 1)] forBarMetrics:UIBarMetricsDefault];
}
- (NSInteger)numberOfTabsInDLTabedSlideView:(DLTabedSlideView *)sender{
    return self.arr_vc.count;
}

- (UIViewController *)DLTabedSlideViewWith:(DLTabedSlideView *)sender controllerAt:(NSInteger)index
{
    UIViewController *vc = self.arr_vc[index];
    return vc;
}
- (void)DLTabedSlideView:(DLTabedSlideView *)sender didSelectedAt:(NSInteger)index
{
    [self setTitleButtonWithString:@"编辑"];
    MOTempViewController *vc = self.arr_vc[index];
    self.vc_temp = vc;
}
- (void)setTitleButtonWithString:(NSString *)title
{
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 45, 30)];
    btn.backgroundColor = [UIColor clearColor];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setTitleColor:color_red forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    //左
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:btn];
    // 设置导航条的按钮
    self.navigationItem.rightBarButtonItem = right;
}
- (void)clickButton:(UIButton *)button
{
    if ([button.titleLabel.text isEqualToString:@"编辑"]) {
        [button setTitle:@"取消" forState:UIControlStateNormal];
        
    }
    else{
        [button setTitle:@"编辑" forState:UIControlStateNormal];
       
    }
    
}
@end
