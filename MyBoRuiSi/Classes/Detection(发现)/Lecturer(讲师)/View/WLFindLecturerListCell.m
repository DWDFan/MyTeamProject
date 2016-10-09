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
    NSArray *_levelArray;
}

@end

@implementation WLFindLecturerListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _levelArray = @[@"初级讲师",@"中级讲师",@"高级讲师",@"特技讲师"];
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
    _nameLbl.frame = CGRectMake(_avatarImgV.right + ZGPaddingMax, _avatarImgV.y + ZGPaddingMax, 60, 14);
    _nameLbl.font = [UIFont systemFontOfSize:14];
    _nameLbl.textColor = COLOR_WORD_BLACK;
    [self addSubview:_nameLbl];
    
    _starView = [[WLDisplayStarView alloc] init];
    _starView.frame = CGRectMake(_nameLbl.right + ZGPadding, _nameLbl.y - 3, 70, 16);
    _starView.starSize = 16;
    [self addSubview:_starView];
    
    _levelIcon = [[UIImageView alloc] init];
    _levelIcon.frame = CGRectMake(WLScreenW - 42 - ZGPaddingMax, ZGPaddingMax, 42, 15);
    _levelIcon.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_levelIcon];
    
    _levelLbl = [[UILabel alloc] init];
    _levelLbl.frame = CGRectMake(_levelIcon.x, _levelIcon.bottom + ZGPadding, 42, 10);
    _levelLbl.font = [UIFont systemFontOfSize:10];
    _levelLbl.textColor = COLOR_WORD_BLACK;
    _levelLbl.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_levelLbl];
    
    UIImageView *followIcon = [[UIImageView alloc] init];
    followIcon.frame = CGRectMake(_nameLbl.x, _avatarImgV.bottom - 2 * ZGPaddingMax, 12, 12);
    followIcon.contentMode = UIViewContentModeScaleAspectFit;
    followIcon.image = [UIImage imageNamed:@"follow_heart_nomal"];
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
    
    _followNumLbl.text = [NSString stringWithFormat:@"%@人关注",lecturer.follow];
    
    _levelLbl.text = _levelArray[[lecturer.level integerValue] - 1];
    
    _starView.showStar = [lecturer.star floatValue] * 20;
    
    _levelIcon.image = [UIImage imageNamed:[NSString stringWithFormat:@"lecturer_level_%@",lecturer.level]];
}

@end
