//
//  WLNoticesViewController.m
//  MyBoRuiSi
//
//  Created by wsl on 16/8/6.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLNoticesViewController.h"
#import "DLTabedSlideView.h"

#import "WLReplyViewController.h"
#import "WLnewsViewController.h"
#import "UIImage+Image.h"

@interface WLNoticesViewController ()<DLTabedSlideViewDelegate>

@property (weak, nonatomic) IBOutlet DLTabedSlideView *view_mian;

@property (nonatomic,weak) WLnewsViewController *vc_temp;

@property (nonatomic,strong ) NSMutableArray *arr_vc;
@end

@implementation WLNoticesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
    btn.backgroundColor = [UIColor clearColor];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setImage:[UIImage imageNamed:@"图层-47"] forState:UIControlStateNormal];
    [btn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
    [btn setTitle:@"通知" forState:UIControlStateNormal];
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
    [self.arr_vc addObject:[[WLReplyViewController alloc]init]];
    [self.arr_vc addObject:[[WLnewsViewController alloc]init]];
    
    
    
    
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
    self.view_mian.tabbarBackgroundImage = [UIImage imageNamed:@"bitp"];
    //高度
    self.view_mian.tabbarHeight = 44;
  
    self.view_mian.tabbarBottomSpacing = 1.0;
    
    DLTabedbarItem *item1 = [DLTabedbarItem itemWithTitle:@"回复" image: nil selectedImage:nil];
    DLTabedbarItem *item2 = [DLTabedbarItem itemWithTitle:@"系统消息" image: nil selectedImage:nil];
    
    self.view_mian.tabbarItems = @[item1,item2];
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

//返回索引
- (void)DLTabedSlideView:(DLTabedSlideView *)sender didSelectedAt:(NSInteger)index
{
    
    
    if (index == 1) {
        
        WLnewsViewController *vc = self.arr_vc[index];
        self.vc_temp = vc;
        
        
        //设置右边的按钮图片没有渲染
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageWithOriginalName:@"删除"] style:UIBarButtonItemStyleDone target:self action:@selector(Deletion)];

    }else{
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageWithOriginalName:@""] style:UIBarButtonItemStyleDone target:self action:@selector(Deletion)];

        
    }
    

}


//删除按钮
-(void)Deletion{
    
}

@end
