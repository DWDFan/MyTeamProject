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
    
    [_photoImgV sd_setImageWithURL:[NSURL URLWithString:_course.photo] placeholderImage:[UIImage imageNamed:@"icon"]];
    
    _nameLbl.text = _course.name;
    
    _authorLbl.text = [NSString stringWithFormat:@"讲师：%@",_course.author];
    
    [_joinNumLbl setTitle:[NSString stringWithFormat:@"%@/%@",_course.num,@20] forState:UIControlStateNormal];
    [_joinNumLbl setTitleEdgeInsets:UIEdgeInsetsMake(0, -ZGPadding, 0, ZGPadding)];
    
    _timeLbl.text = _course.period;
    
    _priceLbl.text = [NSString stringWithFormat:@"￥%@",_course.price];
    
    if ([_course.zbStatus isEqual:@2]) {
        _liveStatusImgV.hidden = YES;
    }else {
        _liveStatusImgV.hidden = NO;
    }
    
}

- (void)awakeFromNib {

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
