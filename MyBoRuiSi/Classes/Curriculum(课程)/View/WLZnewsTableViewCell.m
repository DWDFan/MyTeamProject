//
//  WLZnewsTableViewCell.m
//  MyBoRuiSi
//
//  Created by wsl on 16/8/10.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLZnewsTableViewCell.h"

@implementation WLZnewsTableViewCell

- (void)setCourse:(WLCourceModel *)course
{
    _course = course;
    
    [_photoImgV sd_setImageWithURL:[NSURL URLWithString:_course.photo] placeholderImage:[UIImage imageNamed:@"photo_defult"]];
    
    _nameLbl.text = _course.name;
    
    _authorLbl.text = [NSString stringWithFormat:@"讲师：%@",_course.author];
    
//    [_joinNumLbl setTitle:[NSString stringWithFormat:@"%@/%@",_course.num,@20] forState:UIControlStateNormal];
//    [_joinNumLbl setTitleEdgeInsets:UIEdgeInsetsMake(0, -ZGPadding, 0, ZGPadding)];
    _joinNumLbl.text = [NSString stringWithFormat:@"在线人数:%@/%@",_course.num,_course.limit];
    
    
    _timeLbl.text = _course.period;
    
    _priceLbl.text = [NSString stringWithFormat:@"￥%@",_course.disPrice];
    
    if ([_course.zbStatus integerValue] == 0) {
        [_liveStatusImgV setImage:[UIImage imageNamed:@"直播未开始"] forState:UIControlStateNormal];
        [_liveStatusImgV setTitle:@"直播未开始" forState:UIControlStateNormal];
    }else if ([_course.zbStatus integerValue] == 1){
        [_liveStatusImgV setImage:[UIImage imageNamed:@"icon-直播中"] forState:UIControlStateNormal];
        [_liveStatusImgV setTitle:@"直播进行中" forState:UIControlStateNormal];
    }else if ([_course.zbStatus integerValue] == 2) {
        [_liveStatusImgV setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_liveStatusImgV setTitle:@"直播已结束" forState:UIControlStateNormal];
    }else {
        _liveStatusImgV.hidden = YES;
    }
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
}


@end
