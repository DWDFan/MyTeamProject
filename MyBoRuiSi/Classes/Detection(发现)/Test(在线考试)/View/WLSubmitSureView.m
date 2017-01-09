//
//  WLSubmitSureView.m
//  MyBoRuiSi
//
//  Created by Magician on 2017/1/9.
//  Copyright © 2017年 itcast.com. All rights reserved.
//

#import "WLSubmitSureView.h"

@interface WLSubmitSureView ()

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, copy) void(^block)(NSInteger index);

@end

@implementation WLSubmitSureView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = RGBA(0, 0, 0, 0);
        UIView *backView = [[UIView alloc] init];
        backView.frame = CGRectMake(40, 0, WLScreenW - 80, 200);
        backView.centerY = WLScreenH * 0.5;
        backView.backgroundColor = [UIColor whiteColor];
        backView.layer.cornerRadius = 5;
        backView.layer.masksToBounds = YES;
        [self addSubview:backView];
        _backView = backView;
        
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(0, 0, backView.width, 140);
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = COLOR_WORD_BLACK;
        label.font = [UIFont systemFontOfSize:17];
        label.text = @"您确定要提交试卷了吗？";
        [backView addSubview:label];
        
        UIView *line = [[UIView alloc] init];
        line.frame = CGRectMake(20, 140, backView.width - 40, 0.5);
        line.backgroundColor = kColor_button_bg;
        [backView addSubview:line];
    
        UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        sureBtn.frame = CGRectMake(25, line.bottom + 10, (backView.width - 50 - 10) * 0.5, 40);
        [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [sureBtn setBackgroundColor:kColor_button_bg];
        sureBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        sureBtn.layer.cornerRadius = 5;
        sureBtn.layer.masksToBounds = YES;
        [sureBtn addTarget:self action:@selector(sureBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:sureBtn];
     
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.frame = CGRectMake(sureBtn.right + 10, line.bottom + 10, (backView.width - 50 - 10) * 0.5, 40);
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cancelBtn setBackgroundColor:kColor_button_bg];
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        cancelBtn.layer.cornerRadius = 5;
        cancelBtn.layer.masksToBounds = YES;
        [cancelBtn addTarget:self action:@selector(cancelBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:cancelBtn];

    }
    return self;
}

- (void)sureBtnAction:(UIButton *)sender
{
    self.block(0);
    [self removeFromSuperview];
}

- (void)cancelBtnAction:(UIButton *)sender
{
    [self removeFromSuperview];
}

- (void)showWithBlock:(void(^)(NSInteger index))block
{
    _block = block;
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    _backView.transform = CGAffineTransformMakeScale(0.3, 0.3);
    
    [UIView animateWithDuration:0.3 delay:0.0 usingSpringWithDamping:0.8 initialSpringVelocity:0.3 options:UIViewAnimationOptionCurveLinear animations:^{
    
        self.backgroundColor = RGBA(0, 0, 0, 0.5);
        _backView.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        
    }];
}

@end
