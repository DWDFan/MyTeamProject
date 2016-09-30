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

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setSubviews];
    }
    return self;
}

- (void)setSubviews
{
    UIButton *addShopCartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addShopCartBtn.frame = CGRectMake(0, 0, 90, 50);
    addShopCartBtn.backgroundColor = color_red;
    addShopCartBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [addShopCartBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
    [addShopCartBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addShopCartBtn addTarget:self action:@selector(addCartBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:addShopCartBtn];
    _addShopCartBtn = addShopCartBtn;
    
    UIButton *tasteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    tasteBtn.frame = CGRectMake(90, 0, 90, 50);
    tasteBtn.backgroundColor = KColorYellow;
    tasteBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [tasteBtn setTitle:@"体验学习" forState:UIControlStateNormal];
    [tasteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [tasteBtn addTarget:self action:@selector(tasteBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:tasteBtn];
    _tasteBtn = tasteBtn;
    
    UIButton *purchaseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    purchaseBtn.frame = CGRectMake(180, 0,  WLScreenW - 180, 50);
    purchaseBtn.backgroundColor = [UIColor whiteColor];
    purchaseBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [purchaseBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    [purchaseBtn setTitleColor:color_red forState:UIControlStateNormal];
    [purchaseBtn addTarget:self action:@selector(purchaseBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:purchaseBtn];
    _purchaseBtn = purchaseBtn;

    UIView *topLine = [[UIView alloc] init];
    topLine.frame = CGRectMake(0, 0, WLScreenW, 0.5);
    topLine.backgroundColor = COLOR_WORD_GRAY_2;
    [self addSubview:topLine];
}

- (void)addCartBtnAction:(UIButton *)sender
{
    !self.joinShopCarBlock ?: self.joinShopCarBlock();
}

- (void)tasteBtnAction:(UIButton *)sender
{
    
}

- (void)purchaseBtnAction:(UIButton *)sender
{
    
}


@end
