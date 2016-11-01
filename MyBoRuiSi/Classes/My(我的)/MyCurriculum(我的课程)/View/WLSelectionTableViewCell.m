//
//  WLSelectionTableViewCell.m
//  MyBoRuiSi
//
//  Created by wsl on 16/8/3.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLSelectionTableViewCell.h"
#import "WLMyDianBoCourseModel.h"
@interface WLSelectionTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *photo_imv;
@property (weak, nonatomic) IBOutlet UILabel *name_lab;
@property (weak, nonatomic) IBOutlet UILabel *jiangshi_lab;
@property (weak, nonatomic) IBOutlet UILabel *period_lab;
@property (weak, nonatomic) IBOutlet UILabel *disprice_lab;
@property (weak, nonatomic) IBOutlet UILabel *peopletCount_lab;
@end

@implementation WLSelectionTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setModel:(WLMyDianBoCourseModel *)model{
    _model = model;
    
    [_photo_imv sd_setImageWithURL:[NSURL URLWithString:model.photo] placeholderImage:nil];
    _name_lab.text = model.name;
    _jiangshi_lab.text = [NSString stringWithFormat:@"讲师：%@", model.jiangshi];
    _period_lab.text = model.period ? [NSString stringWithFormat:@"观看截止时间：%@", model.period] : nil;
    _disprice_lab.text = model.dis_price ? [NSString stringWithFormat:@"￥%@", model.dis_price] : [NSString stringWithFormat:@"￥%@", model.price] ;
    _peopletCount_lab.text = model.xx_num;
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
 period 有效期
 dis_price 折扣价
 xx_num 学习人数
 vip_free vip是否免费
 */
