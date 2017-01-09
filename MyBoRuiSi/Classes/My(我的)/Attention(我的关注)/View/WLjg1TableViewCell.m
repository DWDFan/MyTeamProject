//
//  WLjg1TableViewCell.m
//  MyBoRuiSi
//
//  Created by wsl on 16/8/7.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLjg1TableViewCell.h"
#import "WLMyAttentionModel.h"
@interface WLjg1TableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *photo_imv;
@property (weak, nonatomic) IBOutlet UILabel *jg_lab;
@property (weak, nonatomic) IBOutlet UILabel *des_lab;

@end
@implementation WLjg1TableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setModel:(WLMyAttentionModel *)model{
    _model = model;
    
    [_photo_imv sd_setImageWithURL:[NSURL URLWithString:model.photo] placeholderImage:nil];
    _jg_lab.text = model.name;
    
    NSMutableAttributedString *htmlString =[[NSMutableAttributedString alloc] initWithData:[model.desc dataUsingEncoding:NSUTF8StringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute:[NSNumber numberWithInt:NSUTF8StringEncoding]} documentAttributes:NULL error:nil];
    [htmlString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:COLOR_WORD_GRAY_1} range:NSMakeRange(0, htmlString.length)];

    _des_lab.attributedText = htmlString;


}
- (IBAction)deleteAction:(UIButton *)sender {
    !self.deleteBlock ?: self.deleteBlock(self.model.tid);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
