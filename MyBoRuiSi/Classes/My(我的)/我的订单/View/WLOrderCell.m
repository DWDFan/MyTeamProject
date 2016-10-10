//
//  WLOrderCell.m
//  MyBoRuiSi
//
//  Created by 莫瑞伟 on 16/8/4.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLOrderCell.h"

@interface WLOrderCell()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layout_image;
@property (weak, nonatomic) IBOutlet UIButton *button_option;

@property (weak, nonatomic) IBOutlet UIImageView *photo;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *jiangshi;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UIButton *vipFree_btn;
@property (weak, nonatomic) IBOutlet UIButton *status_btn;
@property (weak, nonatomic) IBOutlet UIButton *pay_btn;

@end


@implementation WLOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    //UIControlStateSelected
    [self.button_option setImage:[UIImage imageNamed:@"勾选-拷贝"] forState:UIControlStateSelected];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
}

/** 付款 */
- (IBAction)clickPay:(id)sender {
    
//    if (self.rechargeBlock) {
//        self.rechargeBlock();
//    }
    if(self.payBlock){
        self.payBlock([self.shopCarModel.price integerValue]);
    }
}

/** 选中 事件 */
- (IBAction)clickButton:(UIButton *)sender {
    sender.selected = !self.shopCarModel.isSelect;
    self.shopCarModel.select = sender.selected;
    if (self.selectBalanceBlock) {
        NSInteger price = [self.shopCarModel.price integerValue];
        NSString *cid = self.shopCarModel.id;
        self.selectBalanceBlock(price, sender.selected,cid);
    }
}

- (void)setIsOpen:(BOOL)isOpen
{
    __weak typeof(self) weakSelf = self;
    if (isOpen) {
         weakSelf.layout_image.constant = 50;
        
    }
    else{
         weakSelf.layout_image.constant = 15;
    }
}


#pragma mark - Setter
- (void)setShopCarModel:(WLShopCarModel *)shopCarModel{
    _shopCarModel = shopCarModel;
    
    [_photo sd_setImageWithURL:[NSURL URLWithString:_shopCarModel.photo] placeholderImage:nil];
    _name.text = _shopCarModel.name;
    _jiangshi.text = _shopCarModel.jiangshi;
    _price.text = [NSString stringWithFormat:@"￥%@",_shopCarModel.price];
    
    self.button_option.selected = _shopCarModel.isSelect;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
