//
//  WLAuthorCell.h
//  MyBoRuiSi
//
//  Created by Catski on 16/9/29.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLDisplayStarView.h"

@interface WLAuthorCell : UITableViewCell

@property (nonatomic, strong) UIImageView *avatarImgV;
@property (nonatomic, strong) UILabel *nameLbl;
@property (nonatomic, strong) UILabel *starLbl;
@property (nonatomic, strong) WLDisplayStarView *starView;

@end
