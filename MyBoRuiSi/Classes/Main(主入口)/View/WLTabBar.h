//
//  WLTabBar.h
//  小微博
//
//  Created by wsl on 16/6/18.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WLTabBar;
@protocol WLTabBarDelegate <NSObject>
@optional
//转跳控制器的代理方法
- (void)tabBar:(WLTabBar *)tabBar didClickButton:(NSInteger)index;

@end

@interface WLTabBar : UIView

//保存tbabar按钮
@property(nonatomic,strong) NSArray *items;

@property(nonatomic,weak)id <WLTabBarDelegate> delegate;

@end
