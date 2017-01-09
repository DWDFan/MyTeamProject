//
//  WLPurchaseBottomView.m
//  MyBoRuiSi
//
//  Created by Catskiy on 16/9/23.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLPurchaseBottomView.h"

@interface WLPurchaseBottomView ()

@property (nonatomic, weak) UIButton *addShopCartBtn;
@property (nonatomic, weak) UIButton *tasteBtn;
@property (nonatomic, weak) UIButton *purchaseBtn;
@property (nonatomic, weak) UIButton *joinBtn;
@property (nonatomic, assign) WLPurchaseViewStyle style;

@end

@implementation WLPurchaseBottomView

- (instancetype)initWithFrame:(CGRect)frame style:(WLPurchaseViewStyle)style
{
    if (self = [super initWithFrame:frame]) {
        [self setSubviewsWithStyle:style];
    }
    return self;
}

- (void)setSubviewsWithStyle:(WLPurchaseViewStyle)style
{
    _style = style;
    
    UIButton *addShopCartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addShopCartBtn.frame = CGRectMake(0, 0, 100, 50);
    addShopCartBtn.backgroundColor = color_red;
    addShopCartBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [addShopCartBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
    [addShopCartBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addShopCartBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    addShopCartBtn.tag = 1000;
    [self addSubview:addShopCartBtn];
    _addShopCartBtn = addShopCartBtn;
    
    UIButton *tasteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    tasteBtn.frame = CGRectMake(100, 0, 100, 50);
    tasteBtn.backgroundColor = KColorYellow;
    tasteBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [tasteBtn setTitle:@"体验学习" forState:UIControlStateNormal];
    [tasteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [tasteBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    tasteBtn.tag = 1001;
    [self addSubview:tasteBtn];
    _tasteBtn = tasteBtn;
    
    UIButton *purchaseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    purchaseBtn.frame = CGRectMake(200, 0,  WLScreenW - 200, 50);
    purchaseBtn.backgroundColor = [UIColor whiteColor];
    purchaseBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [purchaseBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    [purchaseBtn setTitleColor:color_red forState:UIControlStateNormal];
    [purchaseBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    purchaseBtn.tag = 1002;
    [self addSubview:purchaseBtn];
    _purchaseBtn = purchaseBtn;
    
    UIButton *joinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    joinBtn.frame = CGRectMake(0, 0,  WLScreenW, 50);
    joinBtn.backgroundColor = color_red;
    joinBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [joinBtn setTitle:@"进入课程" forState:UIControlStateNormal];
    [joinBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    joinBtn.hidden = YES;
    joinBtn.tag = 1003;
    [joinBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:joinBtn];
    _joinBtn = joinBtn;
    
    UIView *topLine = [[UIView alloc] init];
    topLine.frame = CGRectMake(0, 0, WLScreenW, 0.5);
    topLine.backgroundColor = COLOR_WORD_GRAY_2;
    [self addSubview:topLine];
    
    if (style == WLPurchaseViewStyleLive) {
        _addShopCartBtn.frame = CGRectMake(0, 0, WLScreenW / 2, 50);
        _purchaseBtn.frame =CGRectMake(WLScreenW / 2, 0, WLScreenW / 2, 50);
        _tasteBtn.frame = CGRectZero;
    }
}


- (void)buttonAction:(UIButton *)sender
{
    if (sender.tag == 1000) {
        sender.enabled = NO;
        sender.backgroundColor = [UIColor lightGrayColor];
    }
    !self.bottomViewBLock ?: self.bottomViewBLock(sender.tag);
}

- (void)setCanplay:(BOOL)canplay
{
    
    if (canplay) {      // 可进入
//        if (_style == WLPurchaseViewStyleVOD) {
//            self.joinBtn.hidden = NO;
//        }else {
//            
//        }
        self.joinBtn.hidden = NO;
    }else {
        _tasteBtn.enabled = YES;
        _purchaseBtn.enabled = YES;
        _addShopCartBtn.enabled = YES;
        _tasteBtn.backgroundColor = KColorYellow;
        _purchaseBtn.backgroundColor = [UIColor whiteColor];
        _addShopCartBtn.backgroundColor = color_red;
    }
}


@end
