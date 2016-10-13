//
//  WLDirectseedingTableViewCell.m
//  MyBoRuiSi
//
//  Created by wsl on 16/8/3.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLDirectseedingTableViewCell.h"
#import "WLMyZhiBoCourseModel.h"
#import "WLDisplayStarView.h"
@interface WLDirectseedingTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *photo_imv;
@property (weak, nonatomic) IBOutlet UILabel *name_lab;
@property (weak, nonatomic) IBOutlet UILabel *publictime_lab;
@property (weak, nonatomic) IBOutlet UILabel *jiangshi_lab;
@property (weak, nonatomic) IBOutlet UILabel *disprice_lab;
@property (weak, nonatomic) IBOutlet UIButton *status_btn;
@property (weak, nonatomic) IBOutlet UILabel *star_lab;
@property (weak, nonatomic) IBOutlet WLDisplayStarView *star_view;
@end

@implementation WLDirectseedingTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
   
    _star_view.maxStar = 60;
}

- (void)setModel:(WLMyZhiBoCourseModel *)model{
    _model = model;
    
    [_photo_imv sd_setImageWithURL:[NSURL URLWithString:model.photo] placeholderImage:nil];
    _name_lab.text = model.name;
    _jiangshi_lab.text = [NSString stringWithFormat:@"讲师：%@", model.jiangshi];
    _disprice_lab.text = [NSString stringWithFormat:@"￥%@", model.dis_price];
    _publictime_lab.text = [NSString stringWithFormat:@"讲课时间：%@",model.publictime];

    _star_view.showStar = [model.star integerValue];
    _star_lab.text = [NSString stringWithFormat:@"%@分",model.star];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
/*
 id 课程id
 photo 头像
 name 课程名字
 jiangshi 讲师
 star 几颗星
 dis_price 折扣价
 status 状态
 publictime 开始时间
 */
