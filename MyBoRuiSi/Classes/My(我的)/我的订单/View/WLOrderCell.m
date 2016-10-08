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

- (IBAction)clickPay:(id)sender {
    
    if (self.action_pay) {
        self.action_pay();
    }
}

//椭圆-2
- (IBAction)clickButton:(UIButton *)sender {
    sender.selected = !sender.selected;
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
- (void)setOrderModer:(WLOrderModel *)orderModer{
    _orderModer = orderModer;
    
    [_photo sd_setImageWithURL:[NSURL URLWithString:_orderModer.photo] placeholderImage:nil];
    _name.text = _orderModer.name;
    _jiangshi.text = _orderModer.jiangshi;
    _price.text = [NSString stringWithFormat:@"￥%@",_orderModer.price];
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
