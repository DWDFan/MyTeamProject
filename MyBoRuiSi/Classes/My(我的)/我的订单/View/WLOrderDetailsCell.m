//
//  WLOrderDetailsCell.m
//  MyBoRuiSi
//
//  Created by 莫瑞伟 on 16/8/6.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLOrderDetailsCell.h"
#import "WLOrderDetailModel.h"
@interface WLOrderDetailsCell()
@property (weak, nonatomic) IBOutlet UILabel *name_lab;
@property (weak, nonatomic) IBOutlet UIImageView *photo_imv;
@property (weak, nonatomic) IBOutlet UILabel *money_lab;
@property (weak, nonatomic) IBOutlet UILabel *jianshi_lab;

@end
@implementation WLOrderDetailsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setOrderSourceModel:(WLOrderSourceModel *)orderSourceModel{
    _orderSourceModel = orderSourceModel;
    
    _name_lab.text = orderSourceModel.name;
    [_photo_imv sd_setImageWithURL:[NSURL URLWithString:orderSourceModel.photo] placeholderImage:PHOTO_AVATAR];
    _money_lab.text = [NSString stringWithFormat:@"￥%@.00",orderSourceModel.price];
    _jianshi_lab.text = [NSString stringWithFormat:@"讲师：%@",orderSourceModel.jiangshi];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
