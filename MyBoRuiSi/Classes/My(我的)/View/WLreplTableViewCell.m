//
//  WLreplTableViewCell.m
//  MyBoRuiSi
//
//  Created by wsl on 16/8/6.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLreplTableViewCell.h"
#import "WLReplyModel.h"
@interface WLreplTableViewCell ()
@property (weak, nonatomic) IBOutlet UIButton *photo_imv;
@property (weak, nonatomic) IBOutlet UILabel *name_lab;
@property (weak, nonatomic) IBOutlet UILabel *date_lab;
@property (weak, nonatomic) IBOutlet UILabel *reply_lab;
@property (weak, nonatomic) IBOutlet UILabel *title_lab;
@end
@implementation WLreplTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setModel:(WLReplyModel *)model{
    _model = model;
    
    [_photo_imv sd_setBackgroundImageWithURL:[NSURL URLWithString:model.photo] forState:UIControlStateNormal placeholderImage:PHOTO_AVATAR];
    _name_lab.text = model.name;
    _date_lab.text = model.addtime;
    _reply_lab.text = model.reply;
    _title_lab.text = model.title;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
