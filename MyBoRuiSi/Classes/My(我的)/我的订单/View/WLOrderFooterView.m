//
//  WLOrderFooterView.m
//  MyBoRuiSi
//
//  Created by Gatlin on 16/10/12.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLOrderFooterView.h"

#import "WLOrderModel.h"
@interface WLOrderFooterView ()
@property (weak, nonatomic) IBOutlet UILabel *amount_lab;
@property (weak, nonatomic) IBOutlet UIButton *pay_btn;
@property (weak, nonatomic) IBOutlet UIButton *detail_btn;
@property (weak, nonatomic) IBOutlet UIButton *delete_btn;
@end
@implementation WLOrderFooterView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = KColorBackgroud;
    self.amount_lab.textColor = COLOR_WORD_GRAY_1;
    
    _pay_btn.layer.masksToBounds = YES;
    _pay_btn.layer.cornerRadius = 3;
    
    _detail_btn.layer.masksToBounds = YES;
    _detail_btn.layer.cornerRadius = 3;
    
    _delete_btn.layer.masksToBounds = YES;
    _delete_btn.layer.cornerRadius = 3;
}

#pragma mark - Setter
- (void)setOrderModel:(WLOrderModel *)orderModel{
    _orderModel = orderModel;
    
//    _amount_lab.text = orderModel.
}
- (IBAction)payAction:(UIButton *)sender {
    if (self.payBlock) {
        self.payBlock(self.orderModel.id, @"");
    }
}
- (IBAction)detailAction:(UIButton *)sender {
    if (self.detailBlock) {
        self.detailBlock(self.orderModel.id);
    }
}
- (IBAction)deleteAction:(UIButton *)sender {
    if (self.deleteBlock) {
        self.deleteBlock(self.orderModel.id);
    }
}

@end
