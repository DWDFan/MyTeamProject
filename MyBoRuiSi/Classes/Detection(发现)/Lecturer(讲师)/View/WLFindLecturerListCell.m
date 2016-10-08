//
//  WLFindLecturerListCell.m
//  MyBoRuiSi
//
//  Created by Catskiy on 2016/10/8.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLFindLecturerListCell.h"
#import "WLDisplayStarView.h"
@interface WLFindLecturerListCell ()

{
    WLDisplayStarView *_starView;
    UIImageView *_avatarImgV;
    UIImageView *_levelIcon;
    UILabel *_nameLbl;
    UILabel *_levelLbl;
    UILabel *_followNumLbl;
}

@end

@implementation WLFindLecturerListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setSubviews];
    }
    return self;
}

- (void)setSubviews
{
    _avatarImgV = [[UIImageView alloc] init];
    _avatarImgV.frame = CGRectMake(ZGPaddingMax, ZGPadding, 80, 80);
    _avatarImgV.contentMode = UIViewContentModeScaleAspectFill;
    _avatarImgV.layer.masksToBounds = YES;
    [self addSubview:_avatarImgV];
    
    _nameLbl = [[UILabel alloc] init];
    _nameLbl.frame = CGRectMake(_avatarImgV.right + ZGPaddingMax, _avatarImgV.y + ZGPaddingMax, 100, 14);
    _nameLbl.font = [UIFont systemFontOfSize:14];
    _nameLbl.textColor = COLOR_WORD_BLACK;
    [self addSubview:_nameLbl];
    
    _starView = [[WLDisplayStarView alloc] init];
    _starView.frame = CGRectMake(_nameLbl.right + ZGPaddingMax, _nameLbl.y, 70, _nameLbl.height);
    [self addSubview:_starView];
    
    _levelIcon = [[UIImageView alloc] init];
    _levelIcon.frame = CGRectMake(WLScreenW - 55 - ZGPaddingMax, ZGPaddingMax, 55, 35);
    _levelIcon.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_levelIcon];
    
    _levelLbl = [[UILabel alloc] init];
    _levelLbl.frame = CGRectMake(_levelIcon.x, _levelIcon.bottom + ZGPadding, 55, 12);
    _levelLbl.font = [UIFont systemFontOfSize:12];
    _levelLbl.textColor = COLOR_WORD_BLACK;
    [self addSubview:_levelLbl];
    
    UIImageView *followIcon = [[UIImageView alloc] init];
    followIcon.frame = CGRectMake(_nameLbl.x, _avatarImgV.bottom - ZGPaddingMax, 20, 20);
    followIcon.contentMode = UIViewContentModeScaleAspectFit;
    followIcon.image = [UIImage imageNamed:@"Heart-拷贝"];
    [self addSubview:followIcon];
    
    _followNumLbl = [[UILabel alloc] init];
    _followNumLbl.frame = CGRectMake(followIcon.right + ZGPadding, followIcon.y , 150, followIcon.height);
    _followNumLbl.font = [UIFont systemFontOfSize:12];
    _followNumLbl.textColor = COLOR_WORD_GRAY_1;
    [self addSubview:_followNumLbl];
}

- (void)setLecturer:(RecommendModell *)lecturer
{
    _lecturer = lecturer;
    
    [_avatarImgV sd_setImageWithURL:[NSURL URLWithString:lecturer.photo] placeholderImage:PHOTO_AVATAR];
    
    _nameLbl.text = lecturer.name;
    
    _starView.showStar = [lecturer.star floatValue] * 20;
    
}

@end
