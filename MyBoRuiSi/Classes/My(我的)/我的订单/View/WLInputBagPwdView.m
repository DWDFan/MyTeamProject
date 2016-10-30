//
//  WLInputBagPwdView.m
//  MyBoRuiSi
//
//  Created by Gatlin on 16/10/19.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLInputBagPwdView.h"

#import "NSString+Util.h"
@interface WLInputBagPwdView ()
@property (weak, nonatomic) IBOutlet UIView *pwdView;
@property (nonatomic, copy) NSMutableString *pwd;
@end

@implementation WLInputBagPwdView

+ (instancetype)inputBagPawdView{
    return [[[NSBundle mainBundle] loadNibNamed:@"WLInputBagPwdView" owner:nil options:nil] lastObject];
}

- (void)awakeFromNib{
    [super awakeFromNib];
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeView)];
    [self addGestureRecognizer:tap];

    _pwdView.layer.masksToBounds = YES;
    _pwdView.layer.cornerRadius = 3;
    
    _pwdView.layer.borderColor = RGB(153,153,153).CGColor;
    _pwdView.layer.borderWidth = 0.7;
}

- (NSMutableString *)pwd{
    if (!_pwd) {
        _pwd = [[NSMutableString alloc] init];
    }
    return _pwd;
}

- (void)removeView{
    !self.closeBlock ?: self.closeBlock();
}

- (IBAction)closeAction:(UIButton *)sender {
    !self.closeBlock ?: self.closeBlock();
}
- (IBAction)forgetPwd:(UIButton *)sender {
    !self.forgetPwdBlock ?: self.forgetPwdBlock();
}
- (IBAction)deleteOnePwdAction:(UIButton *)sender {
    if (self.pwd.length <= 0) return;
    
    [self.pwd deleteCharactersInRange:NSMakeRange(self.pwd.length - 1, 1)];
    
    for (UIView *v in self.pwdView.subviews) {
        if ([v isKindOfClass:[UILabel class]]) {
            [v removeFromSuperview];
        }
    }
    [self setupPwdViewWithPwd:self.pwd];
}
- (IBAction)inputPwdAction:(UIButton *)sender {
    if (self.pwd.length >= 6) return;
    
    switch (sender.tag) {
        case 0:
            [self.pwd insertString:@"0" atIndex:self.pwd.length];
            break;
        case 1:
            [self.pwd insertString:@"1" atIndex:self.pwd.length];
            break;
        case 2:
            [self.pwd insertString:@"2" atIndex:self.pwd.length];
            break;
        case 3:
            [self.pwd insertString:@"3" atIndex:self.pwd.length];
            break;
        case 4:
            [self.pwd insertString:@"4" atIndex:self.pwd.length];
            break;
        case 5:
            [self.pwd insertString:@"5" atIndex:self.pwd.length];
            break;
        case 6:
            [self.pwd insertString:@"6" atIndex:self.pwd.length];
            break;
        case 7:
            [self.pwd insertString:@"7" atIndex:self.pwd.length];
            break;
        case 8:
            [self.pwd insertString:@"8" atIndex:self.pwd.length];
            break;
        case 9:
            [self.pwd insertString:@"9" atIndex:self.pwd.length];
            break;
            
        default:
            break;
    }
    [self setupPwdViewWithPwd:self.pwd];
    if (self.pwd.length == 6) {
        NSString *pwd = self.pwd.copy;
        !self.completeBlock ?: self.completeBlock([pwd md532BitLower]);
    }
}


- (void)setupPwdViewWithPwd:(NSString *)pwd{
    for (int i = 0; i < pwd.length; i ++) {
        UILabel *lab = [[UILabel alloc] init];
        lab.frame = CGRectMake(i * 45, 0, 45, 40);
        lab.text = @"*";
        lab.font = [UIFont systemFontOfSize:20];
        lab.textAlignment = NSTextAlignmentCenter;
        [self.pwdView addSubview:lab];
    }
}
@end
