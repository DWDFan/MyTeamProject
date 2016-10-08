//
//  WLSortSelectView.m
//  MyBoRuiSi
//
//  Created by Catskiy on 2016/10/8.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLSortSelectView.h"

@implementation WLSortSelectView

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
    self.backgroundColor = [UIColor whiteColor];
    
    CGFloat itemW = WLScreenW / 3;
    
    for (int i = 0; i < 3; i ++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i * itemW, 0, itemW, 40);
        [button setTitleColor:COLOR_WORD_BLACK forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setTag:1000 + i];
        [self addSubview:button];
        
        if (i < 2) {
            UIView *sepLine = [[UIView alloc] initWithFrame:CGRectMake(button.right - 0.5, 0, 0.5, 40)];
            sepLine.backgroundColor = COLOR_tableView_separator;
            [self addSubview:sepLine];
        }
        if (i == 1) {
            [button setImage:[UIImage imageNamed:@"素彩网www.sc115.com-139-拷贝"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"素彩网www.sc115.com-139-拷贝-2"] forState:UIControlStateSelected];
            [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 15)];
            [button setImageEdgeInsets:UIEdgeInsetsMake(0, 55, 0, -55)];
        }
    }
    
    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, 39.5, WLScreenW, 0.5)];
    bottomLine.backgroundColor = COLOR_tableView_separator;
    [self addSubview:bottomLine];
}

- (void)buttonAction:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectViewDidselectedItem:)]) {
        [self.delegate selectViewDidselectedItem:sender];
    }
}

- (void)setTitlesArray:(NSArray *)titlesArray
{
    _titlesArray = titlesArray;
    
    for (int i = 0; i < 3; i ++) {
        
        UIButton *button = [self viewWithTag:1000 + i];
        [button setTitle:titlesArray[i] forState:UIControlStateNormal];
    }
}

@end
