//
//  WLEntTableViewCell.m
//  MyBoRuiSi
//
//  Created by wsl on 16/8/6.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLEntTableViewCell.h"
#import "WLMyQiYeCourseModel.h"
@interface WLEntTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *photo_imv;
@property (weak, nonatomic) IBOutlet UILabel *name_lab;
@property (weak, nonatomic) IBOutlet UILabel *jiangshi_lab;
@property (weak, nonatomic) IBOutlet UILabel *time_lab;

@end
@implementation WLEntTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(WLMyQiYeCourseModel *)model{
    _model = model;
    
    [_photo_imv sd_setImageWithURL:[NSURL URLWithString:model.photo] placeholderImage:PHOTO_AVATAR];
    _name_lab.text = model.name;
    _jiangshi_lab.text = [NSString stringWithFormat:@"主讲：%@",model.jiangshi];
    _time_lab.text = [NSString stringWithFormat:@"课程时长%@分钟",[MOTool getNULLString:model.tmlong]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
