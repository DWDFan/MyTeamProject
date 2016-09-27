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
    priceLbl.frame = CGRectMake(_nameLbl.left, _nameLbl.bottom + 5, _nameLbl.width, 12);
    priceLbl.numberOfLines = 1;
    priceLbl.textColor = color_red;
    priceLbl.font = [UIFont systemFontOfSize:12];
    [self addSubview:priceLbl];
    _priceLbl = priceLbl;
    
    UILabel *authLbl = [[UILabel alloc] init];
    authLbl.frame = CGRectMake(_nameLbl.left, _photoImgV.bottom - 12, 70, 12);
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
}

- (void)setCourse:(WLCourceModel *)course
{
    _course = course;
    
    [_photoImgV sd_setImageWithURL:[NSURL URLWithString:course.photo] placeholderImage:[UIImage imageNamed:@"icon"]];
    
    _nameLbl.text = _course.name;
    
    _priceLbl.text = [NSString stringWithFormat:@"￥%@",course.price];
    
    _authLbl.text = [NSString stringWithFormat:@"主讲:%@",course.author];
    
    NSString *joinNum = [NSString stringWithFormat:@"%@人已学习",course.num];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:joinNum];
    [attrStr addAttribute:NSForegroundColorAttributeName value:color_red range:NSMakeRange(0, attrStr.length - 4)];
    [attrStr addAttribute:NSForegroundColorAttributeName value:COLOR_WORD_GRAY_2 range:NSMakeRange(attrStr.length - 4, 4)];
    _joinNumLbl.attributedText = attrStr;
}


@end
