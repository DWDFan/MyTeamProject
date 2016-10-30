//
//  WLnewsTableViewCell.m
//  MyBoRuiSi
//
//  Created by wsl on 16/8/6.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLnewsTableViewCell.h"
#import "WLSystemMsgModel.h"
@interface WLnewsTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *red_Imv;
@property (weak, nonatomic) IBOutlet UILabel *title_lab;
@property (weak, nonatomic) IBOutlet UILabel *date_lab;
@property (weak, nonatomic) IBOutlet UILabel *content;


@end
@implementation WLnewsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setModel:(WLSystemMsgModel *)model{
    _model = model;
    
    _title_lab.text = model.title;
    _date_lab.text = model.date;
    _content.text = model.content;
    
    if(model.isRead){
        _red_Imv.image = nil;
    }else{
        _red_Imv.image = [UIImage imageNamed:@"提现"];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
