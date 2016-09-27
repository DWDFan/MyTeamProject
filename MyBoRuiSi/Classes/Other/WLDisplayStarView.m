//
//  WLDisplayStarView.m
//  MyBoRuiSi
//
//  Created by Catskiy on 16/9/23.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLDisplayStarView.h"

@implementation WLDisplayStarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        //默认的星星的大小是 13.0f
        self.starSize = 13.0f;
        //未点亮时的颜色是 灰色的
        self.emptyColor = [UIColor colorWithRed:167.0f / 255.0f green:167.0f / 255.0f blue:167.0f / 255.0f alpha:1.0f];
        //点亮时的颜色是 亮黄色的
//        self.fullColor = [UIColor colorWithRed:255.0f / 255.0f green:121.0f / 255.0f blue:22.0f / 255.0f alpha:1.0f];
        self.fullColor = KColorYellow;
        //默认的长度设置为100
        self.maxStar = 100;
    }
    
    return self;
}

//重绘视图
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    NSString* stars = @"★★★★★";
    
    rect = self.bounds;
    UIFont *font = [UIFont boldSystemFontOfSize:_starSize];
//    CGSize starSize = [stars sizeWithFont:font];
    CGSize starSize = [stars sizeWithAttributes:@{NSFontAttributeName : font}];
    rect.size=starSize;
    [_emptyColor set];
//    [stars drawInRect:rect withFont:font];
    [stars drawInRect:rect withAttributes:@{NSForegroundColorAttributeName : _emptyColor, NSFontAttributeName : font}];
    
    CGRect clip = rect;
    clip.size.width = clip.size.width * _showStar / _maxStar;
    CGContextClipToRect(context,clip);
    [_fullColor set];
//    [stars drawInRect:rect withFont:font];
    [stars drawInRect:rect withAttributes:@{NSForegroundColorAttributeName : _fullColor, NSFontAttributeName : font}];
}


@end
