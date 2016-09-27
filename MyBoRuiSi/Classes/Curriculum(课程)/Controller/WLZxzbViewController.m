//
//  WLZxzbViewController.m
//  MyBoRuiSi
//
//  Created by wsl on 16/8/10.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLZxzbViewController.h"
#import "DLTabedSlideView.h"

#import "WLjag1ViewController.h"
#import "WLZxViewController.h"
#import "WLFleiViewController.h"

@interface WLZxzbViewController ()<DLTabedSlideViewDelegate>

@property (weak, nonatomic) IBOutlet DLTabedSlideView *view_mian;

@property (nonatomic,strong ) NSMutableArray *arr_vc;
@end

@implementation WLZxzbViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
    btn.backgroundColor = [UIColor clearColor];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setImage:[UIImage imageNamed:@"图层-47"] forState:UIControlStateNormal];
    [btn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
    [btn setTitle:@"在线直播" forState:UIControlStateNormal];
    self.navigationItem.titleView = btn;
    
    
    
    [self.navigationController.navigationBar setBackgroundImage:[self createImageWithColor:RGBA(255, 255, 255, 1)] forBarMetrics:UIBarMetricsDefault];
    
    [self addchern];
    
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
//添加子控制器
-(void)addchern{
    
    self.arr_vc = [NSMutableArray array];
    [self.arr_vc addObject:[[WLZxViewController alloc]init]];
    [self.arr_vc addObject:[[WLjag1ViewController alloc]init]];
     [self.arr_vc addObject:[[WLFleiViewController alloc]init]];
    
    
    
    
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
    
    DLTabedbarItem *item1 = [DLTabedbarItem itemWithTitle:@"最新" image: nil selectedImage:nil];
    DLTabedbarItem *item2 = [DLTabedbarItem itemWithTitle:@"价格" image: nil selectedImage:nil];
    
    DLTabedbarItem *item3 = [DLTabedbarItem itemWithTitle:@"分类" image: nil selectedImage:nil];
    
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
