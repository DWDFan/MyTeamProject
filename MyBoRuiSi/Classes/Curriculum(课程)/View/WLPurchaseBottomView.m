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

@end

@implementation WLPurchaseBottomView

//- (instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        [self setSubviews];
//    }
//    return self;
//}

- (instancetype)initWithFrame:(CGRect)frame style:(WLPurchaseViewStyle)style
{
    if (self = [super initWithFrame:frame]) {
        [self setSubviewsWithStyle:style];
    }
    return self;
}

- (void)setSubviewsWithStyle:(WLPurchaseViewStyle)style
{
    UIButton *addShopCartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addShopCartBtn.frame = CGRectMake(0, 0, 100, 50);
    addShopCartBtn.backgroundColor = color_red;
    addShopCartBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [addShopCartBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
    [addShopCartBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [addShopCartBtn setTitleColor:COLOR_WORD_GRAY_2 forState:UIControlStateDisabled];
    [addShopCartBtn addTarget:self action:@selector(addCartBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:addShopCartBtn];
    _addShopCartBtn = addShopCartBtn;
    
    UIButton *tasteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    tasteBtn.frame = CGRectMake(100, 0, 100, 50);
    tasteBtn.backgroundColor = KColorYellow;
    tasteBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [tasteBtn setTitle:@"体验学习" forState:UIControlStateNormal];
    [tasteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [tasteBtn setTitleColor:COLOR_WORD_GRAY_2 forState:UIControlStateDisabled];
    [tasteBtn addTarget:self action:@selector(tasteBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:tasteBtn];
    _tasteBtn = tasteBtn;
    
    UIButton *purchaseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    purchaseBtn.frame = CGRectMake(200, 0,  WLScreenW - 200, 50);
    purchaseBtn.backgroundColor = [UIColor whiteColor];
    purchaseBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [purchaseBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    [purchaseBtn setTitleColor:color_red forState:UIControlStateNormal];
//    [purchaseBtn setTitleColor:COLOR_WORD_GRAY_2 forState:UIControlStateDisabled];
    [purchaseBtn addTarget:self action:@selector(purchaseBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:purchaseBtn];
    _purchaseBtn = purchaseBtn;
    
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

- (void)addCartBtnAction:(UIButton *)sender
{
    _addShopCartBtn.enabled = NO;
    _addShopCartBtn.backgroundColor = [UIColor lightGrayColor];
    !self.bottomViewBLock ?: self.bottomViewBLock(0);
}

- (void)tasteBtnAction:(UIButton *)sender
{
    !self.bottomViewBLock ?: self.bottomViewBLock(1);
}

- (void)purchaseBtnAction:(UIButton *)sender
{
    !self.bottomViewBLock ?: self.bottomViewBLock(2);
}

- (void)setCanBuy:(BOOL)canBuy
{
    if (!canBuy) {
        _tasteBtn.enabled = NO;
        _purchaseBtn.enabled = NO;
        _addShopCartBtn.enabled = NO;
        _tasteBtn.backgroundColor = [UIColor lightGrayColor];
        _purchaseBtn.backgroundColor = [UIColor lightGrayColor];
        _addShopCartBtn.backgroundColor = [UIColor lightGrayColor];
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
