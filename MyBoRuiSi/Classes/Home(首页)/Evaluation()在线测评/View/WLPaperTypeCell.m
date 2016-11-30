//
//  WLPaperTypeCell.m
//  MyBoRuiSi
//
//  Created by Catski on 2016/10/4.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLPaperTypeCell.h"

@implementation WLPaperTypeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setSubviews];
    }
    return self;
}

- (void)setSubviews
{
    UIImageView *photoImgV = [[UIImageView alloc] init];
    photoImgV.frame = CGRectMake(15, 10, 40, 40);
    photoImgV.contentMode = UIViewContentModeScaleAspectFill;
    photoImgV.layer.masksToBounds = YES;
    photoImgV.layer.cornerRadius = 20;
    [self addSubview:photoImgV];
    _photoImgV = photoImgV;
    
    UILabel *nameLbl = [[UILabel alloc] init];
    nameLbl.frame = CGRectMake(photoImgV.right + ZGPaddingMax, 10, 14 * 14, 40);
//    nameLbl.width = 14 * 20;WLScreenW - 3 * ZGPaddingMax - photoImgV.width
    nameLbl.numberOfLines = 1;
    nameLbl.textColor = COLOR_BLACK;
    nameLbl.font = [UIFont systemFontOfSize:14];
    [self addSubview:nameLbl];
    _nameLbl = nameLbl;
    
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
