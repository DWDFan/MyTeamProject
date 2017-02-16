//
//  WLCircleInfoCell.m
//  MyBoRuiSi
//
//  Created by Catskiy on 2016/10/10.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLCircleInfoCell.h"

@implementation WLCircleInfoCell

- (void)setCircleInfo:(WLCircleInfoModel *)circleInfo
{
    _circleInfo = circleInfo;
    
    [_photoImgV sd_setImageWithURL:[NSURL URLWithString:circleInfo.icon] placeholderImage:PHOTO_PLACE];
    
    _nameLbl.text = circleInfo.name;
    
    _menberLbl.text = [NSString stringWithFormat:@"成员:%@",circleInfo.member];
    
    _topicLbl.text = [NSString stringWithFormat:@"话题:%@",circleInfo.topic];
    
    _followBtn.selected = circleInfo.isFollow;
}

- (IBAction)followBtnAction:(id)sender {
    
    self.block ? self.block(sender) : nil;
}

@end
