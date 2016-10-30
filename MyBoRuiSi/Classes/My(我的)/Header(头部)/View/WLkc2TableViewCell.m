//
//  WLkc2TableViewCell.m
//  MyBoRuiSi
//
//  Created by wsl on 16/8/9.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLkc2TableViewCell.h"
#import "WLCourseFavModel.h"
@interface WLkc2TableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *photo_imv;
@property (weak, nonatomic) IBOutlet UILabel *name_lab;
@property (weak, nonatomic) IBOutlet UILabel *zhujiang_lab;
@property (weak, nonatomic) IBOutlet UILabel *price_lab;
@property (weak, nonatomic) IBOutlet UILabel *date_lab;
@property (weak, nonatomic) IBOutlet UIButton *oneVSHow_btn;
@end
@implementation WLkc2TableViewCell

- (void)awakeFromNib {
    // Initialization code
}


- (void)setModel:(WLCourseFavModel *)model{
    _model = model;
    
    [_photo_imv sd_setImageWithURL:[NSURL URLWithString:model.photo]];
    _name_lab.text = model.name;
    _zhujiang_lab.text = [NSString stringWithFormat:@"%@老师", model.zhujiang];

    _price_lab.text = model.disPrice ? model.disPrice : model.price;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
