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
    timeLbl.frame = CGRectMake(WLScreenW - 145, 15, 130, 12);
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
    
    _nameLbl.text = comment.author ? comment.author : comment.nickname;
    
    _timeLbl.text = comment.date ? comment.date : comment.addtime;
    
//    _commentLbl.text = comment.msg ? comment.msg : comment.content;
    
    _starView.showStar = [comment.star floatValue] * 20;

    CGFloat width = [MOTool MOtextSizeW:_nameLbl.text WithHigth:12 WithFount:_nameLbl.font];
    
    _nameLbl.width = width < 120 ? width : 120;
    
    _starView.x = CGRectGetMaxX(_nameLbl.frame) + 15;
    
//    CGFloat height = [MOTool MOtextSizeH:_commentLbl.text WithWidth:_commentLbl.width WithFount:_commentLbl.font];
    
//    _commentLbl.height = height;
    
    NSString *commetStr = comment.msg ? comment.msg : comment.content;

    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithData:[commetStr dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    [attributedString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12], NSForegroundColorAttributeName:COLOR_WORD_GRAY_2} range:NSMakeRange(0, attributedString.length)];
    _commentLbl.attributedText = attributedString;

    
//    NSMutableAttributedString *htmlString =[[NSMutableAttributedString alloc] initWithData:[commetStr dataUsingEncoding:NSUTF8StringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute:[NSNumber numberWithInt:NSUTF8StringEncoding]} documentAttributes:nil error:nil];
//    
//    [htmlString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} range:NSMakeRange(0, htmlString.length)];
    
    CGSize textSize = [attributedString boundingRectWithSize:(CGSize){WLScreenW - 30, CGFLOAT_MAX} options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    
    _commentLbl.height = textSize.height;
}

@end
