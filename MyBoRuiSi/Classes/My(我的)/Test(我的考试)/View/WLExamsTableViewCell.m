//
//  WLExamsTableViewCell.m
//  MyBoRuiSi
//
//  Created by mo on 16/8/4.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLExamsTableViewCell.h"
#import "WLMyTestModel.h"
@interface WLExamsTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *imv;
@property (weak, nonatomic) IBOutlet UILabel *title_lab;
@property (weak, nonatomic) IBOutlet UILabel *score_lab;
@property (weak, nonatomic) IBOutlet UILabel *addtime_lab;

@end

@implementation WLExamsTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setModel:(WLMyTestModel *)model{
    _model = model;
    
    _title_lab.text = model.title;
    _score_lab.text = model.score;
    _addtime_lab.text = model.addtime;
    
}
- (IBAction)lookAnswerAction:(UIButton *)sender {
    !self.lookAnswerBlock ?: self.lookAnswerBlock();
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
/*
 title 标题
 tid 测试id
 addtime 测试时间
 score 测试分数
 */
