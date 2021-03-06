//
//  ZGArticleCell.m
//  MyBoRuiSi
//
//  Created by Catskiy on 16/9/26.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "ZGArticleCell.h"
#import "YYPhotoGroupView.h"

@interface ZGArticleCell ()

@property (nonatomic, strong) UIImageView *avatarImgV;
@property (nonatomic, strong) UIButton *praBtn;
@property (nonatomic, strong) UIButton *cmtImgV;
@property (nonatomic, strong) UILabel *nameLbl;
@property (nonatomic, strong) UILabel *timeLbl;
@property (nonatomic, strong) UILabel *titleLbl;
@property (nonatomic, strong) UILabel *contentLbl;
@property (nonatomic, strong) UILabel *praLbl;
@property (nonatomic, strong) UILabel *cmtLbl;
@property (nonatomic, strong) UIView *imageContainV;
@property (nonatomic, strong) NSMutableArray *images;

@property (nonatomic, strong) UIButton *moreBtn;
@property (nonatomic, strong) UILabel *readLbl;
@property (nonatomic, strong) UIImageView *readIcon;

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
    
    // 赞,评论,阅读图标/按钮
    _praBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_praBtn setImage:[UIImage imageNamed:@"素彩网www.sc115.com-230"] forState:UIControlStateNormal];
    [_praBtn setImage:[UIImage imageNamed:@"follow_heart_nomal"] forState:UIControlStateSelected];
    [_praBtn addTarget:self action:@selector(praBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_praBtn];

    _cmtImgV = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cmtImgV setImage:[UIImage imageNamed:@"素彩网www.sc115.com-108"] forState:UIControlStateNormal];
    [_cmtImgV addTarget:self action:@selector(cmtBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_cmtImgV];

    
    _readIcon = [[UIImageView alloc] init];
    _readIcon.image = [UIImage imageNamed:@"素彩网www.sc115.com-114"];
    _readIcon.contentMode = UIViewContentModeScaleAspectFit;
    _readIcon.hidden = YES;
    [self addSubview:_readIcon];
    
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
    
    // 赞,评论,阅读数量
    _praLbl = [[UILabel alloc] init];
    _praLbl.textColor = COLOR_WORD_GRAY_2;
    _praLbl.font = [UIFont systemFontOfSize:12];
    [self addSubview:_praLbl];
    
    _cmtLbl = [[UILabel alloc] init];
    _cmtLbl.textColor = COLOR_WORD_GRAY_2;
    _cmtLbl.font = [UIFont systemFontOfSize:12];
    [self addSubview:_cmtLbl];
    
    _readLbl = [[UILabel alloc] init];
    _readLbl.textColor = COLOR_WORD_GRAY_2;
    _readLbl.font = [UIFont systemFontOfSize:12];
    _readLbl.hidden = YES;
    [self addSubview:_readLbl];

    
    _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_moreBtn setImage:[UIImage imageNamed:@"素彩网www.sc115.com-139-拷贝"] forState:UIControlStateNormal];
    [_moreBtn addTarget:self action:@selector(moreBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_moreBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -13, 0, 0)];
    _moreBtn.hidden = YES;
    [self addSubview:_moreBtn];

    
    _imageContainV = [[UIView alloc] init];
    _imageContainV.layer.masksToBounds = YES;
    [self addSubview:_imageContainV];
    
    CGFloat imageW = (WLScreenW - ZGPaddingMax * 2 - 2 * ZGPadding) / 3;
    CGFloat imageH = imageW * 0.7;
    
    for (int i = 0; i < 6; i ++) {
        
        NSInteger row = i/3;
        NSInteger col = i%3;
        UIImageView *imageV = [[UIImageView alloc] init];
        imageV.frame = CGRectMake((imageW + ZGPadding) * col, (imageH + 10) * row, imageW, imageH);
        imageV.contentMode = UIViewContentModeScaleAspectFill;
        imageV.layer.masksToBounds = YES;
        [_imageContainV addSubview:imageV];
        [self.images addObject:imageV];
        
        imageV.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handlePhotoImgV:)];
        [imageV addGestureRecognizer:tap];
    }
}

- (void)setArticleViewModel:(ZGArticleViewModel *)articleViewModel
{
    _articleViewModel = articleViewModel;
    
    [_avatarImgV sd_setImageWithURL:[NSURL URLWithString:_articleViewModel.article.photo] placeholderImage:PHOTO_PLACE];
    
    _nameLbl.text = _articleViewModel.article.name ? _articleViewModel.article.name : _articleViewModel.article.nickname;
    
    _titleLbl.text = _articleViewModel.article.title;
    
    _timeLbl.text = _articleViewModel.article.addtime;
    
//    _contentLbl.text = _articleViewModel.article.content;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithData:[_articleViewModel.article.content dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    [attributedString addAttributes:@{NSForegroundColorAttributeName:COLOR_WORD_GRAY_1, NSFontAttributeName:[UIFont systemFontOfSize:12]} range:NSMakeRange(0, attributedString.length)];
    _contentLbl.attributedText = attributedString;
    
    _praLbl.text = [NSString stringWithFormat:@"%@",_articleViewModel.article.zanNum];
    
    _cmtLbl.text = [NSString stringWithFormat:@"%@",_articleViewModel.article.cmtNum ? _articleViewModel.article.cmtNum : _articleViewModel.article.replyNum];
    
    _readLbl.text = [NSString stringWithFormat:@"%@",_articleViewModel.article.viewNum];
    
    for (int i = 0; i < 6; i ++) {
        
        UIImageView *imageV = (UIImageView *)[_images objectAtIndex:i];
        
        if (i < _articleViewModel.article.image.count) {
            
            ZGImageModel *imageModel = _articleViewModel.article.image[i];
            [imageV sd_setImageWithURL:[NSURL URLWithString:imageModel.image] placeholderImage:PHOTO_PLACE];
            imageV.hidden = NO;
            
            if (_articleViewModel.cellType == ZGArticleCellTypeList && i >= 3) {
                imageV.hidden = YES;
            }
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
    _praBtn.frame = _articleViewModel.praIconFrame;
    _cmtImgV.frame = _articleViewModel.cmtIconFrame;
    _readIcon.frame = _articleViewModel.readIconFrame;
    _praLbl.frame = _articleViewModel.praFrame;
    _cmtLbl.frame = _articleViewModel.cmtFrame;
    _readLbl.frame = _articleViewModel.readFrame;
    _moreBtn.frame = _articleViewModel.moreBtnFrame;
    
    _praBtn.selected = _articleViewModel.article.selfZan;
    if ([[WLUserInfo share].userId isEqualToString:_articleViewModel.article.uid]) {
        
        _readIcon.hidden = NO;
        _readLbl.hidden = NO;
        _moreBtn.hidden = NO;
    }else {
        _readIcon.hidden = YES;
        _readLbl.hidden = YES;
        _moreBtn.hidden = YES;
    }
}

- (void)praBtnAction:(UIButton *)sender
{
    self.praiseblock ? self.praiseblock(sender) : nil;
}

- (void)cmtBtnAction:(UIButton *)sender
{
    self.commentBlock ? self.commentBlock(sender) : nil;
}

- (void)moreBtnAction:(UIButton *)sender
{
    self.moreBlock ? self.moreBlock(sender) : nil;
}

- (void)addPraiseCount
{
    NSInteger count = [_articleViewModel.article.zanNum integerValue] + 1;
    _articleViewModel.article.zanNum = [NSNumber numberWithInteger:count];
    _praLbl.text =  [NSString stringWithFormat:@"%@",_articleViewModel.article.zanNum];
}

- (void)subPraiseCount
{
    NSInteger count = [_articleViewModel.article.zanNum integerValue] - 1;
    _articleViewModel.article.zanNum = [NSNumber numberWithInteger:count];
    _praLbl.text =  [NSString stringWithFormat:@"%@",_articleViewModel.article.zanNum];
}

- (NSMutableArray *)images
{
    if (!_images) {
        _images = [NSMutableArray arrayWithCapacity:0];
    }
    return _images;
}

- (void)setType:(ZGArticleCellType)type
{
    _type = type;
    if (type == ZGArticleCellTypeList) {
        _readIcon.alpha = 0;
        _readLbl.alpha = 0;
        _moreBtn.alpha = 0;
    }else {
        _readIcon.alpha = 1;
        _readLbl.alpha = 1;
        _moreBtn.alpha = 1;
    }

}

- (void)handlePhotoImgV:(id)recognizer{
    
    if (_type == ZGArticleCellTypeList) {
        return;
    }
    
    UITapGestureRecognizer *tap = (UITapGestureRecognizer *)recognizer;
    NSMutableArray *items = [NSMutableArray new];
    

    for (NSUInteger i = 0; i < _articleViewModel.article.image.count; i++) {
        
        YYPhotoGroupItem *item = [YYPhotoGroupItem new];
        item.thumbView = self.images[i];
        ZGImageModel *imageModel = _articleViewModel.article.image[i];
        item.largeImageURL = [NSURL URLWithString:imageModel.image];
        item.largeImageSize = CGSizeMake(60, 60);
        [items addObject:item];
    }
    
    UIImageView *fromV = (UIImageView *)tap.view;
    NSLog(@"%f",fromV.frame.size.width);
    
    YYPhotoGroupView *v = [[YYPhotoGroupView alloc] initWithGroupItems:items isForce:YES];
    [v presentFromImageView:fromV toContainer:[UIApplication sharedApplication].keyWindow.rootViewController.view animated:YES completion:nil];
}

@end
