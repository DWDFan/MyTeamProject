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
   
    //隐藏付款按钮 只有待支付才有付款按钮
    self.pay_btn.hidden = YES;

}

/** 付款 */
- (IBAction)clickPay:(id)sender {
    
//    if (self.rechargeBlock) {
//        self.rechargeBlock();
//    }
    if(self.payBlock){
        self.payBlock(self.shopCarModel.disPrice ? [self.shopCarModel.disPrice integerValue] : [self.shopCarModel.price integerValue]);
    }
}

/** 选中 事件 */
- (IBAction)clickButton:(UIButton *)sender {
    sender.selected = !self.shopCarModel.isSelect;
    self.shopCarModel.select = sender.selected;
    if (self.selectBalanceBlock) {
        if ([self.shopCarModel.vipFree isEqualToNumber:@1] && [WLUserInfo share].vip) {
            self.selectBalanceBlock(0, sender.selected,self.shopCarModel);
        }else{
            NSInteger price = self.shopCarModel.disPrice ? [self.shopCarModel.disPrice integerValue] : [self.shopCarModel.price integerValue];
            self.selectBalanceBlock(price, sender.selected,self.shopCarModel);
        }
    }
    if (self.selectDeleteBlock) {
        self.selectDeleteBlock(sender.selected,self.oid);
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
    _jiangshi.text = [NSString stringWithFormat:@"讲师%@", _shopCarModel.jiangshi];
    _price.text = [NSString stringWithFormat:@"￥%@.00",  _shopCarModel.disPrice ? [_shopCarModel.disPrice stringValue] : [_shopCarModel.price stringValue]];
    if([_shopCarModel.vipFree isEqualToNumber:@1]){
        self.vipFree_btn.layer.borderWidth = 0.7;
        self.vipFree_btn.layer.borderColor = color_red.CGColor;
        self.vipFree_btn.layer.masksToBounds = YES;
        self.vipFree_btn.layer.cornerRadius = 3;
    }else{
        self.vipFree_btn.hidden = YES;
    }
    
    if([shopCarModel.type isEqualToNumber:@1]){
        [self.status_btn setTitle:@"点播课程" forState:UIControlStateNormal];
        if(self.cellType == waitPayType){//待支付
            //显示付款按钮
            self.pay_btn.hidden = NO;
        }
    }else if([shopCarModel.type isEqualToNumber:@2]){
        switch ([shopCarModel.status intValue]) {
            case 0:
                [self.status_btn setTitle:@"直播未开始" forState:UIControlStateNormal];
                [self.status_btn setImage:nil forState:UIControlStateNormal];
                [self.status_btn setTitleColor:RGB(193, 193, 193) forState:UIControlStateNormal];
                if(self.cellType == waitPayType){//待支付
                    //显示付款按钮
                    self.pay_btn.hidden = NO;
                }
                break;
            case 1:
                 [self.status_btn setImage:[UIImage imageNamed:@"icon-直播中"] forState:UIControlStateNormal];
                [self.status_btn setTitle:@"直播中" forState:UIControlStateNormal];
                 [self.status_btn setTitleColor:color_red forState:UIControlStateNormal];
                break;
            case 2:
                [self.status_btn setTitle:@"直播结束" forState:UIControlStateNormal];
                [self.status_btn setImage:nil forState:UIControlStateNormal];
                [self.status_btn setTitleColor:RGB(193, 193, 193) forState:UIControlStateNormal];
                break;
            default:
                self.status_btn.hidden = YES;
                break;
        }
        
    }else{
        self.status_btn.hidden = YES;
    }
    
    self.button_option.selected = _shopCarModel.isSelect;
    
    switch (self.cellType) {
        case shopCarType:{
           
            //判断是否失效
            if([_shopCarModel.lose isEqualToNumber:@1]){
                [self.button_option setImage:nil forState:UIControlStateNormal];
                [self.button_option setImage:nil forState:UIControlStateSelected];
                self.button_option.userInteractionEnabled = NO;
                [self.button_option setTitle:@"失效" forState:UIControlStateNormal];
                self.button_option.backgroundColor = RGB(193, 193, 193);
                
                self.button_option.layer.masksToBounds = YES;
                self.button_option.layer.cornerRadius = 2;
            }

        }break;
        case waitPayType:{
            
        }break;
            
        default:
            break;
    }
    }
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
