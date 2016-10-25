//
//  WLVipDateView.m
//  MyBoRuiSi
//
//  Created by Beelin on 2016/10/24.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLVipDateView.h"

@implementation WLVipDateView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:.5];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeView)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)setDate:(NSString *)date{
    _date = date;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(self.width/2 - 150, self.height/2 - 100, 300, 200)];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 10;
    [self addSubview:view];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, 300, 50)];
    lab.numberOfLines = 0;
    lab.text = [NSString stringWithFormat:@"会员有效期：\n%@",date];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.textColor = RGB(53, 53, 53);
    [view addSubview:lab];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(lab.frame) + 40, 260, 0.7)];
    line.backgroundColor = color_red;
    [view addSubview:line];
    
    UIButton *buy_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    buy_btn.frame = CGRectMake(20, CGRectGetMaxY(line.frame) + 15, 120, 40);
    buy_btn.layer.masksToBounds = YES;
    buy_btn.layer.cornerRadius = 5;
    buy_btn.backgroundColor = color_red;
    [buy_btn setTitle:@"续费" forState:UIControlStateNormal];
    [buy_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buy_btn addTarget:self action:@selector(keepAction) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:buy_btn];
    
    UIButton *cancle_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancle_btn.frame = CGRectMake(CGRectGetMaxX(buy_btn.frame) + 20, CGRectGetMaxY(line.frame) + 15, 120, 40);
    cancle_btn.layer.masksToBounds = YES;
    cancle_btn.layer.cornerRadius = 5;
    cancle_btn.layer.borderColor = color_red.CGColor;
    cancle_btn.layer.borderWidth = 0.7;
    cancle_btn.backgroundColor = [UIColor whiteColor];
    [cancle_btn setTitle:@"取消" forState:UIControlStateNormal];
    [cancle_btn setTitleColor:color_red forState:UIControlStateNormal];
    [cancle_btn addTarget:self action:@selector(cancleAction) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:cancle_btn];
    
}

- (void)keepAction{
    !self.keepBlock ?: self.keepBlock();
}
- (void)cancleAction{
    !self.cancleBlock ?: self.cancleBlock();
}

- (void)removeView{
    !self.cancleBlock ?: self.cancleBlock();
}

@end
