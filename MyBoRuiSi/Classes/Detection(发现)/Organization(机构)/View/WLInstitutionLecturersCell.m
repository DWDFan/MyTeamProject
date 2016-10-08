//
//  WLInstitutionLecturersCell.m
//  MyBoRuiSi
//
//  Created by Catski on 16/9/25.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLInstitutionLecturersCell.h"
#import "WLDisplayStarView.h"

@interface WLInstitutionLecturersCell ()

@property (nonatomic, strong) WLDisplayStarView *starView;
@property (nonatomic, strong) UIImageView *avatarImgV;
@property (nonatomic, strong) UILabel *nameLbl;
@property (nonatomic, strong) UILabel *descLbl;

@end

@implementation WLInstitutionLecturersCell

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
    _avatarImgV.frame = CGRectMake(15, 10, 80, 80);
    _avatarImgV.layer.masksToBounds = YES;
    _avatarImgV.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_avatarImgV];
    
    _nameLbl = [[UILabel alloc] init];
    _nameLbl.frame = CGRectMake(CGRectGetMaxX(_avatarImgV.frame) + 15, 15, 70, 14);
    _nameLbl.textColor = COLOR_BLACK;
    _nameLbl.font = [UIFont systemFontOfSize:14];
    [self addSubview: _nameLbl];
    
    _descLbl = [[UILabel alloc] init];
    _descLbl.frame = CGRectMake(CGRectGetMaxX(_avatarImgV.frame) + 15, CGRectGetMaxY(_nameLbl.frame) + 10, WLScreenW - 30 - CGRectGetMaxX(_avatarImgV.frame), 80 - 14 - 15);
    _descLbl.textColor = COLOR_WORD_GRAY_1;
    _descLbl.font = [UIFont systemFontOfSize:12];
    _descLbl.numberOfLines = 2;
    [self addSubview: _descLbl];
    
    _starView = [[WLDisplayStarView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_nameLbl.frame) + 10, 15, 100, 14)];
    [self addSubview:_starView];
}

- (void)setLecturer:(WLLecturerModel *)lecturer
{
    _lecturer = lecturer;
    
    [_avatarImgV sd_setImageWithURL:[NSURL URLWithString:_lecturer.photo] placeholderImage:[UIImage imageNamed:@"photo_defult"]];
    
    _nameLbl.text = lecturer.name;
    
    _descLbl.text = lecturer.desc;
    
    _starView.showStar = [lecturer.star floatValue] * 20;
}

@end
