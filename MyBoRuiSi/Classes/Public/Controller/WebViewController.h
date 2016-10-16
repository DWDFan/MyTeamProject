//
//  WebViewController.h
//  Gone
//
//  Created by Happy on 15/9/16.
//  Copyright (c) 2015年 xiaowuxiaowu. All rights reserved.
//

typedef void(^AddGoodsBlock)(id obj);

#import "BaseViewController.h"


@interface WebViewController : BaseViewController<UIWebViewDelegate>

{
    UIWebView *web;
}

@property (nonatomic, copy) AddGoodsBlock addGoodBlock;

@property (nonatomic, assign) BOOL isHide; //判断是否隐藏导航栏

@property (nonatomic, strong) NSString *urlstr;

@property (nonatomic, strong) NSString *titleStr;

@end
