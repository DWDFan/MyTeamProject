//
//  WLCourseListCell.m
//  MyBoRuiSi
//
//  Created by Catski on 16/9/25.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLCourseListCell.h"

@interface WLCourseListCell ()

{
    UIImageView *_photoImgV;
    UILabel *_nameLbl;
    UILabel *_priceLbl;
    UILabel *_authLbl;
    UILabel *_joinNumLbl;
    UIButton *_vipFreeBtn;
}

@end

@implementation WLCourseListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setSubviews];
    }
    return self;
}

- (void)setSubviews
{
    _photoImgV = [[UIImageView alloc] init];
    _photoImgV.frame = CGRectMake(15, 10, 100, 80);
    _photoImgV.contentMode = UIViewContentModeScaleAspectFill;
    _photoImgV.layer.masksToBounds = YES;
    [self addSubview:_photoImgV];
    
    _nameLbl = [[UILabel alloc] init];
    _nameLbl.frame = CGRectMake(_photoImgV.right + 15, _photoImgV.x, WLScreenW - _photoImgV.width - 45, 14 * 2 + 5);
    _nameLbl.numberOfLines = 0;
    _nameLbl.textColor = COLOR_BLACK;
    _nameLbl.font = [UIFont systemFontOfSize:14];
    [self addSubview:_nameLbl];
    
    UILabel *priceLbl = [[UILabel alloc] init];
    priceLbl.frame = CGRectMake(_nameLbl.left, _nameLbl.bottom + 5, 150, 14);
    priceLbl.numberOfLines = 1;
    priceLbl.textColor = color_red;
    priceLbl.font = [UIFont boldSystemFontOfSize:14];
    [self addSubview:priceLbl];
    _priceLbl = priceLbl;
    
    UILabel *authLbl = [[UILabel alloc] init];
    authLbl.frame = CGRectMake(_nameLbl.left, _photoImgV.bottom - 12, 140, 12);
    authLbl.numberOfLines = 1;
    authLbl.textColor = COLOR_BLACK;
    authLbl.font = [UIFont systemFontOfSize:12];
    [self addSubview:authLbl];
    _authLbl = authLbl;
    
    UILabel *joinNumLbl = [[UILabel alloc] init];
    joinNumLbl.frame = CGRectMake(authLbl.right + 10, _authLbl.y, WLScreenW - _authLbl.right - 25, 12);
    joinNumLbl.numberOfLines = 1;
    joinNumLbl.textColor = COLOR_BLACK;
    joinNumLbl.font = [UIFont systemFontOfSize:12];
    [self addSubview:joinNumLbl];
    _joinNumLbl = joinNumLbl;
    
    UIButton *vipFreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    vipFreeBtn.frame = CGRectMake(_priceLbl.right + 15, priceLbl.y - 4, 60, 22);
    vipFreeBtn.backgroundColor = KColorPink;
    vipFreeBtn.layer.cornerRadius = 4;
    vipFreeBtn.layer.borderColor = color_red.CGColor;
    vipFreeBtn.layer.borderWidth = 0.5;
    vipFreeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [vipFreeBtn setTitle:@"会员免费" forState:UIControlStateNormal];
    [vipFreeBtn setTitleColor:color_red forState:UIControlStateNormal];
    [self addSubview:vipFreeBtn];
    _vipFreeBtn = vipFreeBtn;
}

- (void)setCourse:(WLCourceModel *)course
{
    _course = course;
    
    [_photoImgV sd_setImageWithURL:[NSURL URLWithString:course.photo] placeholderImage:[UIImage imageNamed:@"photo_defult"]];
    
    _nameLbl.text = _course.name;
    
    _priceLbl.text = [NSString stringWithFormat:@"￥%@",course.disPrice];
    CGFloat width = [MOTool MOtextSizeW:_priceLbl.text WithHigth:14 WithFount:_priceLbl.font];
    _priceLbl.width = width <_nameLbl.width - 60 ? width : _nameLbl.width - 70;
    
    _vipFreeBtn.x = _priceLbl.right + 15;
    if (course.vipFree) {
        _vipFreeBtn.hidden = NO;
    }else {
        _vipFreeBtn.hidden = YES;
    }
    
    _authLbl.text = [NSString stringWithFormat:@"主讲:%@",course.author];
    
    NSString *joinNum = [NSString stringWithFormat:@"%@人已学习",course.num];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:joinNum];
    [attrStr addAttribute:NSForegroundColorAttributeName value:color_red range:NSMakeRange(0, attrStr.length - 4)];
    [attrStr addAttribute:NSForegroundColorAttributeName value:COLOR_WORD_GRAY_2 range:NSMakeRange(attrStr.length - 4, 4)];
    _joinNumLbl.attributedText = attrStr;
}


@end
