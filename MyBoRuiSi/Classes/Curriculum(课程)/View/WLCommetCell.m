//
//  WLCommetCell.m
//  MyBoRuiSi
//
//  Created by Catskiy on 16/9/23.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLCommetCell.h"
#import "WLDisplayStarView.h"

@interface WLCommetCell ()

@property (nonatomic, weak) UILabel *nameLbl;
@property (nonatomic, weak) UILabel *timeLbl;
@property (nonatomic, weak) UILabel *commentLbl;
@property (nonatomic, weak) WLDisplayStarView *starView;

@end

@implementation WLCommetCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setSubviews];
    }
    return self;
}

- (void)setSubviews
{
    UILabel *nameLbl = [[UILabel alloc] init];
    nameLbl.frame = CGRectMake(15, 15, 100, 12);
    nameLbl.font = [UIFont systemFontOfSize:12];
    nameLbl.textColor = COLOR_WORD_BLACK;
    [self addSubview:nameLbl];
    _nameLbl = nameLbl;
    
    UILabel *timeLbl = [[UILabel alloc] init];
    timeLbl.frame = CGRectMake(WLScreenW - 135, 15, 120, 12);
    timeLbl.font = [UIFont systemFontOfSize:12];
    timeLbl.textColor = COLOR_WORD_GRAY_1;
    timeLbl.textAlignment = NSTextAlignmentRight;
    [self addSubview:timeLbl];
    _timeLbl = timeLbl;
    
    UILabel *commentLbl = [[UILabel alloc] init];
    commentLbl.frame = CGRectMake(15, CGRectGetMaxY(nameLbl.frame) + 15, WLScreenW - 30, 12);
    commentLbl.font = [UIFont systemFontOfSize:12];
    commentLbl.textColor = COLOR_WORD_GRAY_2;
    commentLbl.numberOfLines = 0;
    [self addSubview:commentLbl];
    _commentLbl = commentLbl;
    
    WLDisplayStarView *starView = [[WLDisplayStarView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(nameLbl.frame) + 15, 14, 200, 13)];
    [self addSubview:starView];
    _starView = starView;
}

- (void)setComment:(WLCommentModel *)comment
{
    _comment = comment;
    
    _nameLbl.text = comment.author;
    
    _timeLbl.text = comment.date;
    
    _commentLbl.text = comment.msg;
    
    _starView.showStar = [comment.star integerValue] * 20;
    
    CGFloat width = [MOTool MOtextSizeW:_nameLbl.text WithHigth:12 WithFount:_nameLbl.font];
    
    _nameLbl.width = width < 120 ? width : 120;
    
    _starView.x = CGRectGetMaxX(_nameLbl.frame) + 15;
    
    CGFloat height = [MOTool MOtextSizeH:_commentLbl.text WithWidth:_commentLbl.width WithFount:_commentLbl.font];
    
    _commentLbl.height = height;
}

@end
