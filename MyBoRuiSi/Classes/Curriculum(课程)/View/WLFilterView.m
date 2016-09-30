//
//  WLFilterView.m
//  MyBoRuiSi
//
//  Created by Catskiy on 16/9/27.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLFilterView.h"

@implementation WLFilterView
{
    UIView *_indecateV;
    UIButton *_currentBtn;
}
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
    NSArray *titles = @[@"销量", @"价格", @"分类"];
    NSArray *imagesNomal = @[@"sort_sellNum_nomal", @"sort_price_nomal", @"素彩网www.sc115.com-139-拷贝"];
    NSArray *imagesSelect = @[@"sort_sellNum_select", @"sort_price_asc", @"素彩网www.sc115.com-139-拷贝-2"];
    
    for (int i = 0; i < 3; i ++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i * WLScreenW / 3, 0, WLScreenW / 3, 45);
        button.backgroundColor = [UIColor whiteColor];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:COLOR_WORD_BLACK forState:UIControlStateNormal];
        [button setTitleColor:color_red forState:UIControlStateSelected];
        [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
        [button setImage:[UIImage imageNamed:imagesNomal[i]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:imagesSelect[i]] forState:UIControlStateSelected];
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, 35, 0, -35)];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.tag = 1000 + i;
        
        UIView *line = [[UIView alloc] init];
        line.frame = CGRectMake(button.right - 0.5, 0, 0.5, 45);
        line.backgroundColor = COLOR_tableView_separator;
        
        [self addSubview:button];
        [self addSubview:line];
        
        i == 0 ? _currentBtn = button : nil;
    }
    
    UIView *indecateV = [[UIView alloc] init];
    indecateV.frame = CGRectMake(0, 42, WLScreenW/3, 3);
    indecateV.backgroundColor = color_red;
    [self addSubview:indecateV];
    _indecateV = indecateV;
    
    UIView *bottomLine = [[UIView alloc] init];
    bottomLine.frame = CGRectMake(0, 44, WLScreenW, 1);
    bottomLine.backgroundColor = COLOR_tableView_separator;
    [self addSubview:bottomLine];
}

- (void)buttonAction:(UIButton *)sender
{
    NSInteger index = sender.tag - 1000;

    BOOL isChange = (sender != _currentBtn);

    if (!isChange && index == 2) {
        
        sender.selected = !sender.selected;
//        _currentBtn.selected = NO;
//        sender.selected = YES;
    }else {
        _currentBtn.selected = NO;
        
        sender.selected = YES;
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        
        _indecateV.x = index * WLScreenW / 3;
    }];
    
    if (self.delegate) {
        [self.delegate filerViewDidselectedButton:sender Index:index isChange:isChange];
    }
    
    _currentBtn = sender;
}

- (void)setFilterButtonNormal
{
    UIButton *filterBtn = [self viewWithTag:1000 + 2];
    filterBtn.selected = NO;
}

@end
