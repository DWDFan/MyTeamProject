//
//  WLke1TableViewCell.m
//  MyBoRuiSi
//
//  Created by wsl on 16/8/9.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLke1TableViewCell.h"
#import "WLCourseFavModel.h"
@interface WLke1TableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *photo_imv;
@property (weak, nonatomic) IBOutlet UILabel *name_lab;
@property (weak, nonatomic) IBOutlet UILabel *price_lab;
@property (weak, nonatomic) IBOutlet UILabel *jiangshi_lab;
@property (weak, nonatomic) IBOutlet UILabel *studyNum_lab;


@end
@implementation WLke1TableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setModel:(WLCourseFavModel *)model{
    _model = model;
    
    [_photo_imv sd_setImageWithURL:[NSURL URLWithString:model.photo]];
    _name_lab.text = model.name;
    _jiangshi_lab.text = [NSString stringWithFormat:@"讲师：%@", model.zhujiang];
    _studyNum_lab.text = [NSString stringWithFormat:@"已经%@人学习",model.studyNum];
    _price_lab.text = model.disPrice ? model.disPrice : model.price;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
