//
//  WLCirCleCell.m
//  MyBoRuiSi
//
//  Created by Catskiy on 2016/10/10.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLCirCleCell.h"
#import "WLCircleModel.h"

@interface circleBtn : UIButton

@end

@implementation circleBtn

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    return CGRectMake(25, 10, WLScreenW/4 - 50, WLScreenW/4 - 50);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    return CGRectMake(0, WLScreenW/4 - 35, WLScreenW/4, 20);
}

@end

@implementation WLCirCleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

- (void)setCirclesArray:(NSArray *)circlesArray
{
    _circlesArray = circlesArray;
    
    for (UIView *subView in self.subviews) {
        
        if ([subView isKindOfClass:[circleBtn class]]) {
            
            [subView removeFromSuperview];
        }
    }
    
    CGFloat itemW = WLScreenW / 4;
    CGFloat itemH = itemW - 10;
    
    for (int i = 0; i < circlesArray.count; i ++) {
        
        WLCircleModel *circle = _circlesArray[i];
        CGFloat row = i / 4;
        CGFloat col = i % 4;
        
        circleBtn *item = [circleBtn buttonWithType:UIButtonTypeCustom];
        item.frame = CGRectMake(col * itemW, 10 + itemH * row, itemW, itemH);
        item.tag = i + 1000;
        
        [item setTitle:circle.name forState:UIControlStateNormal];
        [item setTitleColor:COLOR_BLACK forState:UIControlStateNormal];
        item.titleLabel.font = [UIFont systemFontOfSize:12];
        item.titleLabel.textAlignment = NSTextAlignmentCenter;
        item.imageView.layer.masksToBounds = YES;
        item.imageView.layer.cornerRadius = (WLScreenW/4 - 50)/2;
        [item sd_setImageWithURL:[NSURL URLWithString:circle.photo] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"组-3@2x_41"]];
        [item addTarget:self action:@selector(itemAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:item];
    }
}

- (void)itemAction:(UIButton *)sender
{
    WLCircleModel *model = _circlesArray[sender.tag - 1000];
    self.block ? self.block(model.id, model.name) : nil;
}

+ (CGFloat)heightWithCount:(NSInteger)count
{
    CGFloat itemW = WLScreenW / 4;
    CGFloat itemH = itemW + 10;
    
    if (count == 0) return itemH;

    NSInteger row = (count - 1)/4 + 1;
    
    return row * itemH;
}

@end
