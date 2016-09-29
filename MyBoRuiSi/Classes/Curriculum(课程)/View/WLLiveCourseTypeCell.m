//
//  WLLiveCourseTypeCell.m
//  MyBoRuiSi
//
//  Created by Catski on 16/9/28.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLLiveCourseTypeCell.h"
#import "ZGCourseTypeModel.h"

@interface ItemBtn : UIButton
@end

@implementation ItemBtn

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    return CGRectMake(25, 10, WLScreenW/4 - 50, WLScreenW/4 - 50);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    return CGRectMake(0, WLScreenW/4 - 35, WLScreenW/4, 30);
}

@end

@implementation WLLiveCourseTypeCell

- (void)setTypeArray:(NSArray *)typeArray
{
    _typeArray = typeArray;
    
    CGFloat itemW = WLScreenW / 4;
    CGFloat itemH = itemW;
    
    for (int i = 0; i < typeArray.count; i ++) {
        
        ZGCourseTypeModel *typeModel = typeArray[i];
        CGFloat row = i / 4;
        CGFloat col = i % 4;
        
        ItemBtn *item = [ItemBtn buttonWithType:UIButtonTypeCustom];
        item.frame = CGRectMake(col * itemW, 10 + itemH * row, itemW, itemH);
        item.tag = i + 1000;
        
        [item setTitle:[NSString stringWithFormat:@"%@\n(%@)",typeModel.type,typeModel.num] forState:UIControlStateNormal];
        [item setTitleColor:COLOR_BLACK forState:UIControlStateNormal];
        item.titleLabel.font = [UIFont systemFontOfSize:12];
        item.titleLabel.textAlignment = NSTextAlignmentCenter;
        item.titleLabel.numberOfLines = 2;
        item.imageView.layer.masksToBounds = YES;
        item.imageView.layer.cornerRadius = (WLScreenW/4 - 50)/2;
        [item sd_setImageWithURL:[NSURL URLWithString:typeModel.icon] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"组-3@2x_41"]];
        [item addTarget:self action:@selector(itemAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:item];
    }
}

- (void)itemAction:(UIButton *)sender
{
    ZGCourseTypeModel *model = _typeArray[sender.tag - 1000];
    self.block ? self.block(model.id) : nil;
}

@end
