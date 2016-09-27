//
//  WLTabBarButton.m
//  小微博
//
//  Created by wsl on 16/6/19.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "WLTabBarButton.h"

#define imagevido 0.7

@interface WLTabBarButton()



@end

@implementation WLTabBarButton

-(void)setItem:(UITabBarItem *)item
{   _item = item;
    
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
    //监听一个对象的属性有没有改变 KVO
    [item addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"selectedImage" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"badgeValue" options:NSKeyValueObservingOptionNew context:nil];
    

}

//如果属性改了会调用这个方法
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    [self setTitle:_item.title forState:UIControlStateNormal];
    
    [self setImage:_item.image forState:UIControlStateNormal];
    
    [self setImage:_item.selectedImage forState:UIControlStateSelected];
    
   

}



//初始化属性
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self =  [super initWithFrame:frame]) {
        
        // 设置字体颜色
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [self setTitleColor:[UIColor colorWithRed:164/255.0 green:30/255.0 blue:59/255.0 alpha:1] forState:UIControlStateSelected];
        
        // 图片居中
        self.imageView.contentMode = UIViewContentModeCenter;
        // 文字居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        // 设置文字字体
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        

        
    }
    return self;
}

//子控件位置
-(void)layoutSubviews{
    [super layoutSubviews];
    
    
    // 1.imageView
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    CGFloat imageW = self.bounds.size.width;
    CGFloat imageH = self.bounds.size.height * imagevido;
    self.imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    
    
    // 2.title
    CGFloat titleX = 0;
    CGFloat titleY = imageH - 3;
    CGFloat titleW = self.bounds.size.width;
    CGFloat titleH = self.bounds.size.height - titleY;
    self.titleLabel.frame = CGRectMake(titleX, titleY, titleW, titleH);

    
//    // 3.badgeView
//    self.badageView.x = self.width - self.badageView.width - 10;
//    self.badageView.y = 0;
    
    
}
@end
