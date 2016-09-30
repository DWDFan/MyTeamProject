//
//  WLAuthorCell.m
//  MyBoRuiSi
//
//  Created by Catski on 16/9/29.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLAuthorCell.h"

@implementation WLAuthorCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setSubviews];
    }
    return self;
}

- (void)setSubviews
{
    UIImageView *avatarImgV = [[UIImageView alloc] init];
    avatarImgV.frame = CGRectMake(15, 10, 80, 80);
    avatarImgV.contentMode = UIViewContentModeScaleAspectFill;
    avatarImgV.layer.masksToBounds = YES;
    [self addSubview:avatarImgV];
    _avatarImgV = avatarImgV;
    
    UILabel *nameLbl = [[UILabel alloc] init];
    nameLbl.frame = CGRectMake(avatarImgV.right + 15, avatarImgV.centerY - 7, 60, 15);
    nameLbl.numberOfLines = 1;
    nameLbl.textColor = COLOR_BLACK;
    nameLbl.font = [UIFont systemFontOfSize:15];
    [self addSubview:nameLbl];
    _nameLbl = nameLbl;

    WLDisplayStarView *starView = [[WLDisplayStarView alloc] init];
    starView.frame = CGRectMake(nameLbl.right + 15, nameLbl.y, 100, 15);
    [self addSubview:starView];
    _starView = starView;
    
    UILabel *starLbl = [[UILabel alloc] init];
    starLbl.frame = CGRectMake(starView.right + 10, starView.y, 40, 15);
    starLbl.numberOfLines = 1;
    starLbl.textColor = KColorYellow;
    starLbl.font = [UIFont systemFontOfSize:12];
    [self addSubview:starLbl];
    _starLbl = starLbl;

}


@end
