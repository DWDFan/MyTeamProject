//
//  ZGArticleModel.m
//  MyBoRuiSi
//
//  Created by Catskiy on 16/9/26.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "ZGArticleModel.h"

@implementation ZGImageModel



@end

@implementation ZGArticleModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"image" : [ZGImageModel class]};
}

@end

@implementation ZGArticleViewModel

- (void)setArticle:(ZGArticleModel *)article
{
    _article = article;
    
    _avatarFrame = CGRectMake(ZGPaddingMax, ZGPaddingMax, 40, 40);
    
    _timeFrame = CGRectMake(WLScreenW - 130 - ZGPaddingMax, _avatarFrame.origin.y, 130, _avatarFrame.size.height);
    
    _nameFrame = CGRectMake(CGRectGetMaxX(_avatarFrame) + ZGPaddingMax, _avatarFrame.origin.y, WLScreenW - CGRectGetMaxX(_avatarFrame)  - 45 - _timeFrame.size.width, _avatarFrame.size.height);
    
    _titleFrame = CGRectMake(15, CGRectGetMaxY(_avatarFrame) + ZGPaddingMax, WLScreenW - ZGPaddingMax * 2, 14);
    
//    CGFloat heihgt = [MOTool MOtextSizeH:article.content WithWidth:WLScreenW - ZGPaddingMax * 2 WithFount:[UIFont systemFontOfSize:12]];
//    _contentFrame = CGRectMake(15, CGRectGetMaxY(_titleFrame) + ZGPaddingMax, WLScreenW - ZGPaddingMax * 2, heihgt);
    
    //计算html字符串高度
    NSMutableAttributedString *htmlString =[[NSMutableAttributedString alloc] initWithData:[article.content dataUsingEncoding:NSUTF8StringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute:[NSNumber numberWithInt:NSUTF8StringEncoding]} documentAttributes:NULL error:nil];
    [htmlString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} range:NSMakeRange(0, htmlString.length)];
    
    CGFloat height = [htmlString boundingRectWithSize:(CGSize){WLScreenW - - ZGPaddingMax * 2, CGFLOAT_MAX} options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
    _contentFrame = CGRectMake(15, CGRectGetMaxY(_titleFrame) + ZGPaddingMax, WLScreenW - ZGPaddingMax * 2, height);

    
    // 列表显示3行
    if (self.cellType == ZGArticleCellTypeList && height > 12 * 3 + 5) {
        _contentFrame = CGRectMake(15, CGRectGetMaxY(_titleFrame) + ZGPaddingMax, WLScreenW - ZGPaddingMax * 2, 12 * 3 + 7);
    }

    
    NSInteger row = (self.cellType == ZGArticleCellTypeList) ?  1 : (_article.image.count - 1)/3 + 1;
    
    CGFloat imageW = (WLScreenW - ZGPaddingMax * 2 - 2 * ZGPadding) / 3;
    CGFloat imageH = (imageW * 0.7) * row + (row - 1) * ZGPadding;
    _imageVFrame = CGRectMake(ZGPaddingMax, CGRectGetMaxY(_contentFrame) + ZGPaddingMax, WLScreenW - 2 * ZGPaddingMax, imageH + ZGPaddingMax);
    
    if (article.image.count == 0) {
        _imageVFrame.size.height = 0;
    }
    
    _praIconFrame = CGRectMake(ZGPaddingMax, CGRectGetMaxY(_imageVFrame), 15, 15);
    _praFrame = CGRectMake(CGRectGetMaxX(_praIconFrame) + ZGPadding, _praIconFrame.origin.y, 60, 15);
    
    _cmtIconFrame = CGRectMake(CGRectGetMaxX(_praFrame), _praIconFrame.origin.y, 15, 15);
    _cmtFrame = CGRectMake(CGRectGetMaxX(_cmtIconFrame) + ZGPadding, _praIconFrame.origin.y, 60, 15);
    
    _readIconFrame = CGRectMake(CGRectGetMaxX(_cmtFrame), _praIconFrame.origin.y, 15, 15);
    _readFrame = CGRectMake(CGRectGetMaxX(_readIconFrame) + ZGPadding, _praIconFrame.origin.y, 60, 15);
    
    _moreBtnFrame = CGRectMake( WLScreenW - ZGPaddingMax - 20, _readFrame.origin.y, 30, 15);
    
    _cellHeight = CGRectGetMaxY(_praIconFrame) + ZGPaddingMax;
}

@end
