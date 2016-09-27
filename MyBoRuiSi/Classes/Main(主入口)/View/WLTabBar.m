//
//  WLTabBar.m
//  小微博
//
//  Created by wsl on 16/6/18.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "WLTabBar.h"
#import "WLTabBarButton.h"

@interface WLTabBar()

@property(nonatomic,weak)UIButton *wlbutton;//tabbar上的子按钮
//保存按钮
@property(nonatomic,strong) NSMutableArray *buttons;

@property(nonatomic,weak)UIButton *selectedButton;


@end

@implementation WLTabBar
//懒加载
-(NSMutableArray *)buttons
{
    if (_buttons == nil) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}



//重写数组items set方法

-(void)setItems:(NSArray *)items
{
    _items = items;
    for (UITabBarItem *item in _items) {
        
       WLTabBarButton *btn = [WLTabBarButton buttonWithType:UIButtonTypeCustom];//自定义按钮
        
        btn.item = item;
        
        //标记tabbar有多少按钮
        btn.tag = self.buttons.count;
        //监听tabbar上的按钮
        [btn addTarget:self action:@selector(btnClik:) forControlEvents:UIControlEventTouchDown];
        
        if (btn.tag == 0) {
            [self btnClik:btn];
        }
        //把按钮添加到view上面
        [self addSubview:btn];
        
        [self.buttons addObject:btn];//添加到数组保存
    }
}
//点击tabbar按钮时候调用
-(void)btnClik:(UIButton *)button

{   //取消上一次的点击
    _selectedButton.selected = NO;
    button.selected = YES;//选当前
    _selectedButton = button;//记录当前点击
    
    // 通知tabBarVc切换控制器，
    if ([_delegate respondsToSelector:@selector(tabBar:didClickButton:)]) {
        [_delegate tabBar:self didClickButton:button.tag];
    }


}


//重写layoutSubviews方法调整按钮的位置

//子控件位置
-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat w = self.bounds.size.width;
    CGFloat h = self.bounds.size.height;
    
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnW = w / (self.items.count );
    CGFloat btnH = self.bounds.size.height;
    
    //for循环遍历所有子按钮位置
    
    
    int i = 0;
    for (UIView *tabBarButton in self.buttons) {
       
            btnX = i * btnW;
            
            tabBarButton.frame = CGRectMake(btnX, btnY, btnW, btnH);
            
            i++;
        
    }
    
    self.wlbutton.center = CGPointMake(w * 0.5, h * 0.5);
    
    
}


@end
