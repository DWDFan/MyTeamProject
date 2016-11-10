//
//  ZGArticleCell.h
//  MyBoRuiSi
//
//  Created by Catskiy on 16/9/26.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZGArticleModel.h"



@interface ZGArticleCell : UITableViewCell

@property (nonatomic, strong) ZGArticleViewModel *articleViewModel;
@property (nonatomic, assign) ZGArticleCellType type;

@property (nonatomic, copy) void(^moreBlock)(UIButton *button);
@property (nonatomic, copy) void(^commentBlock)(UIButton *button);
/** 点赞 */
@property (nonatomic, copy) void(^praiseblock)(UIButton *button);
- (void)addPraiseCount;
- (void)subPraiseCount;

@end
