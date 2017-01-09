//
//  WLjs1TableViewCell.m
//  MyBoRuiSi
//
//  Created by wsl on 16/8/7.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLjs1TableViewCell.h"
#import "WLDisplayStarView.h"

#import "WLMyAttentionModel.h"
@interface WLjs1TableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *photo_imv;
@property (weak, nonatomic) IBOutlet UILabel *jiangshi_lab;
@property (weak, nonatomic) IBOutlet UILabel *des_lab;
@property (weak, nonatomic) IBOutlet UIView *star_view;

@end

@implementation WLjs1TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
//    _starView = [[WLDisplayStarView alloc] init];
//    [self.contentView addSubview:_starView];
}

- (void)setModel:(WLMyAttentionModel *)model{
    _model = model;
    
    [_photo_imv sd_setImageWithURL:[NSURL URLWithString:model.photo] placeholderImage:nil];
    _jiangshi_lab.text =  model.name;
    _des_lab.attributedText = [MOTool getAttributeStringByHtmlString:model.desc];
    
//   _starView.showStar = [model.star integerValue] *20;
    WLDisplayStarView *starView = [[WLDisplayStarView alloc] initWithFrame:CGRectMake(0, 0, 60, 20)];
    starView.showStar = [model.star integerValue]* 20;
    [_star_view addSubview: starView];

    
}
- (IBAction)deleteAction:(UIButton *)sender {
    !self.deleteBlock ?: self.deleteBlock(self.model.tid);
}

- (void)layoutSubviews{
    [super layoutSubviews];
//    _starView.frame = CGRectMake(160, 10, 60, 20);
}

@end
