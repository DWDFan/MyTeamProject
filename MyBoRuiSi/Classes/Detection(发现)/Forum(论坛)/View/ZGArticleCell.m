//
//  ZGArticleCell.m
//  MyBoRuiSi
//
//  Created by Catskiy on 16/9/26.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "ZGArticleCell.h"

@interface ZGArticleCell ()

@property (nonatomic, strong) UIImageView *avatarImgV;
@property (nonatomic, strong) UIImageView *praImgV;
@property (nonatomic, strong) UIImageView *cmtImgV;
@property (nonatomic, strong) UILabel *nameLbl;
@property (nonatomic, strong) UILabel *timeLbl;
@property (nonatomic, strong) UILabel *titleLbl;
@property (nonatomic, strong) UILabel *contentLbl;
@property (nonatomic, strong) UILabel *praLbl;
@property (nonatomic, strong) UILabel *cmtLbl;
@property (nonatomic, strong) UIView *imageContainV;
@property (nonatomic, strong) NSMutableArray *images;

@end

@implementation ZGArticleCell

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
    _avatarImgV.contentMode = UIViewContentModeScaleAspectFill;
    _avatarImgV.layer.cornerRadius = 20.0;
    _avatarImgV.layer.masksToBounds = YES;
    [self addSubview:_avatarImgV];
    
    _praImgV = [[UIImageView alloc] init];
    _praImgV.image = [UIImage imageNamed:@"Heart-拷贝"];
    _praImgV.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_praImgV];
    
    _cmtImgV = [[UIImageView alloc] init];
    _cmtImgV.image = [UIImage imageNamed:@"素彩网www.sc115.com-108"];
    _cmtImgV.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_cmtImgV];
    
    _timeLbl = [[UILabel alloc] init];
    _timeLbl.textColor = COLOR_WORD_GRAY_2;
    _timeLbl.textAlignment = NSTextAlignmentRight;
    _timeLbl.font = [UIFont systemFontOfSize:12];
    [self addSubview:_timeLbl];
    
    _nameLbl = [[UILabel alloc] init];
    _nameLbl.textColor = COLOR_WORD_GRAY_2;
    _nameLbl.font = [UIFont systemFontOfSize:12];
    [self addSubview:_nameLbl];
    
    _titleLbl = [[UILabel alloc] init];
    _titleLbl.textColor = COLOR_BLACK;
    _titleLbl.font = [UIFont systemFontOfSize:14];
    [self addSubview:_titleLbl];
    
    _contentLbl = [[UILabel alloc] init];
    _contentLbl.numberOfLines = 0;
    _contentLbl.textColor = COLOR_WORD_GRAY_1;
    _contentLbl.font = [UIFont systemFontOfSize:12];
    [self addSubview:_contentLbl];
    
    _praLbl = [[UILabel alloc] init];
    _praLbl.textColor = COLOR_WORD_GRAY_2;
    _praLbl.font = [UIFont systemFontOfSize:12];
    [self addSubview:_praLbl];
    
    _cmtLbl = [[UILabel alloc] init];
    _cmtLbl.textColor = COLOR_WORD_GRAY_2;
    _cmtLbl.font = [UIFont systemFontOfSize:12];
    [self addSubview:_cmtLbl];
    
    _imageContainV = [[UIView alloc] init];
    _imageContainV.layer.masksToBounds = YES;
    [self addSubview:_imageContainV];
    
    CGFloat imageW = (WLScreenW - ZGPaddingMax * 2 - 2 * ZGPadding) / 3;
    CGFloat imageH = imageW * 0.7;
    
    for (int i = 0; i < 3; i ++) {
        
        UIImageView *imageV = [[UIImageView alloc] init];
        imageV.frame = CGRectMake((imageW + ZGPadding) * i, 0, imageW, imageH);
        imageV.contentMode = UIViewContentModeScaleAspectFill;
        imageV.layer.masksToBounds = YES;
        [_imageContainV addSubview:imageV];
        [self.images addObject:imageV];
    }
    
    
}

- (void)setArticleViewModel:(ZGArticleViewModel *)articleViewModel
{
    _articleViewModel = articleViewModel;
    
    [_avatarImgV sd_setImageWithURL:[NSURL URLWithString:_articleViewModel.article.photo] placeholderImage:[UIImage imageNamed:@"photo_defult"]];
    
    _nameLbl.text = _articleViewModel.article.name;
    
    _titleLbl.text = _articleViewModel.article.title;
    
    _timeLbl.text = _articleViewModel.article.addtime;
    
    _contentLbl.text = _articleViewModel.article.content;
    
    _praLbl.text = [NSString stringWithFormat:@"%@",_articleViewModel.article.zanNum];
    
    _cmtLbl.text = [NSString stringWithFormat:@"%@",_articleViewModel.article.cmtNum];
    
    for (int i = 0; i < 3; i ++) {
        
        UIImageView *imageV = (UIImageView *)[_images objectAtIndex:i];

        if (i < _articleViewModel.article.images.count) {
            [imageV sd_setImageWithURL:[NSURL URLWithString:_articleViewModel.article.images[i]] placeholderImage:[UIImage imageNamed:@"photo_defult"]];
        }else {
            imageV.hidden = YES;
        }
    }
    
    _avatarImgV.frame = _articleViewModel.avatarFrame;
    _nameLbl.frame = _articleViewModel.nameFrame;
    _timeLbl.frame = _articleViewModel.timeFrame;
    _titleLbl.frame = _articleViewModel.titleFrame;
    _contentLbl.frame = _articleViewModel.contentFrame;
    _imageContainV.frame = _articleViewModel.imageVFrame;
    _praImgV.frame = _articleViewModel.praIconFrame;
    _cmtImgV.frame = _articleViewModel.cmtIconFrame;
    _praLbl.frame = _articleViewModel.praFrame;
    _cmtLbl.frame = _articleViewModel.cmtFrame;
}

@end
