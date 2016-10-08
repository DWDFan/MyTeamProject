//
//  WLDetailsTableViewCell.m
//  MyBoRuiSi
//
//  Created by wsl on 16/8/2.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLDetailsTableViewCell.h"

@interface WLDetailsTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *courseImgV;
@property (weak, nonatomic) IBOutlet UILabel *starLbl;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *priceLbl;
@property (weak, nonatomic) IBOutlet UILabel *followNum;
@property (weak, nonatomic) IBOutlet UILabel *disPriceLbl;

@end

@implementation WLDetailsTableViewCell

- (void)setCourse:(WLCourseListModel *)course
{
    _course = course;
    
    [_courseImgV sd_setImageWithURL:[NSURL URLWithString:course.photo] placeholderImage:[UIImage imageNamed:@"photo_defult"]];
    
    _starLbl.text = [NSString stringWithFormat:@"%@分",[MOTool getNULLString:course.star]];
    
    _nameLbl.text = [MOTool getNULLString:course.name];
    
    _priceLbl.text = [NSString stringWithFormat:@"￥%@",[MOTool getNULLString:course.disPrice ? course.disPrice : course.price]];
    
    _followNum.text = [NSString stringWithFormat:@"%@人关注",[MOTool getNULLString:course.follow]];
    
    // 有两个价格,显示原价
    if (course.disPrice && course.price) {
        NSString *disPrice = [NSString stringWithFormat:@"￥%@",[MOTool getNULLString:course.price]];
        NSAttributedString *attStr = [[NSAttributedString alloc] initWithString:disPrice attributes:@{NSStrikethroughStyleAttributeName : [NSNumber numberWithInteger:NSUnderlineStyleSingle]}];
        _disPriceLbl.attributedText = attStr;
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
