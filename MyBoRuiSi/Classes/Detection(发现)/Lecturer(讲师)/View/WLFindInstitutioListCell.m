//
//  WLFindInstitutioListCell.m
//  MyBoRuiSi
//
//  Created by Catski on 2016/10/8.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLFindInstitutioListCell.h"

@interface WLFindInstitutioListCell ()

{
    UIImageView *_photoImgV;
    UIImageView *_typeIcon;
    UILabel *_nameLbl;
    UILabel *_typeLbl;
    UILabel *_followNumLbl;
    UILabel *_scaleLbl;
    NSArray *_typeArray;
}

@end

@implementation WLFindInstitutioListCell

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
    _photoImgV.frame = CGRectMake(ZGPaddingMax, ZGPadding, 80, 80);
    _photoImgV.contentMode = UIViewContentModeScaleAspectFill;
    _photoImgV.layer.masksToBounds = YES;
    [self addSubview:_photoImgV];
    
    _nameLbl = [[UILabel alloc] init];
    _nameLbl.frame = CGRectMake(_photoImgV.right + ZGPaddingMax, _photoImgV.y, 60, 14);
    _nameLbl.font = [UIFont systemFontOfSize:14];
    _nameLbl.textColor = COLOR_WORD_BLACK;
    [self addSubview:_nameLbl];

    _scaleLbl = [[UILabel alloc] init];
    _scaleLbl.frame = CGRectMake(_nameLbl.x, _photoImgV.centerY - 6, WLScreenW - _nameLbl.x - 60, 12);
    _scaleLbl.font = [UIFont systemFontOfSize:12];
    _scaleLbl.textColor = COLOR_WORD_BLACK;
    [self addSubview:_scaleLbl];

    UIImageView *followIcon = [[UIImageView alloc] init];
    followIcon.frame = CGRectMake(_nameLbl.x, _photoImgV.bottom - 12, 12, 12);
    followIcon.contentMode = UIViewContentModeScaleAspectFit;
    followIcon.image = [UIImage imageNamed:@"follow_heart_nomal"];
    [self addSubview:followIcon];
    
    _followNumLbl = [[UILabel alloc] init];
    _followNumLbl.frame = CGRectMake(followIcon.right + ZGPadding, followIcon.y , 150, followIcon.height);
    _followNumLbl.font = [UIFont systemFontOfSize:12];
    _followNumLbl.textColor = COLOR_WORD_GRAY_1;
    [self addSubview:_followNumLbl];

    _typeIcon = [[UIImageView alloc] init];
    _typeIcon.frame = CGRectMake(WLScreenW - 42 - ZGPaddingMax, ZGPaddingMax, 42, 20);
    _typeIcon.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_typeIcon];
    
    _typeLbl = [[UILabel alloc] init];
    _typeLbl.frame = CGRectMake(_typeIcon.x, _typeIcon.bottom + ZGPadding, 42, 10);
    _typeLbl.font = [UIFont systemFontOfSize:10];
    _typeLbl.textColor = COLOR_WORD_BLACK;
    _typeLbl.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_typeLbl];
}

- (void)setInstitution:(RecommendationModelll *)institution
{
    _institution = institution;
    
    [_photoImgV sd_setImageWithURL:[NSURL URLWithString:institution.photo] placeholderImage:PHOTO_PLACE];
    
    _nameLbl.text = institution.name;
    
    _scaleLbl.text = [NSString stringWithFormat:@"公司规模：%@",institution.member];
    
    _followNumLbl.text = [NSString stringWithFormat:@"%@人关注",institution.follow];
    
    _typeLbl.text = institution.gsType ? institution.gsType : @"其他";
    
    NSString *typeImage;
    if ([institution.gsType isEqualToString:@"国企"]) {
        typeImage = @"ins_type_state";
    }else if ([institution.gsType isEqualToString:@"私企"]) {
        typeImage = @"ins_type_personal";
    }else {
        typeImage = @"ins_type_other";
    }
    _typeIcon.image = [UIImage imageNamed:typeImage];
}

@end
