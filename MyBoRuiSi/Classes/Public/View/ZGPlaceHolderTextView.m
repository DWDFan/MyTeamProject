//
//  ZGPlaceHolderTextView.m
//  MyBoRuiSi
//
//  Created by Catski on 2016/10/10.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "ZGPlaceHolderTextView.h"

@implementation ZGPlaceHolderTextView

- (void)drawRect:(CGRect)rect {
    if (self.text.length > 0) {
        [super drawRect:rect];
        return;
    }else{
        NSDictionary *dict = @{NSForegroundColorAttributeName : [UIColor lightGrayColor],
                               NSFontAttributeName : [UIFont systemFontOfSize:14]};
        NSAttributedString *placeHolder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:dict];
        [placeHolder drawAtPoint:CGPointMake(0, 0)];
    }
}

@end
