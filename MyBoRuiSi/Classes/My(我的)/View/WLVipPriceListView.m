//
//  WLVipPriceListView.m
//  MyBoRuiSi
//
//  Created by Gatlin on 16/10/24.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLVipPriceListView.h"

#import "WLVipFeeModel.h"
@implementation WLVipPriceListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:.5];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeView)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)setDataSource:(NSArray *)dataSource{
    _dataSource = dataSource;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(self.width/2 - 150, self.height/2 - dataSource.count/2 * 45, 300, (dataSource.count + 1) * 45)];
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 10;
    view.backgroundColor = [UIColor whiteColor];
    [self addSubview:view];
    
    for (int i = 0; i < dataSource.count; i ++) {
        WLVipFeeModel *model = dataSource[i];
        
        UILabel *year_lab = [[UILabel alloc] initWithFrame:CGRectMake(20, i * 45, 70, 45)];
        year_lab.textAlignment = NSTextAlignmentRight;
        if([model.year isEqualToNumber:@0]){
            year_lab.text = @"永久会员";
        }else{
            year_lab.text = [NSString stringWithFormat:@"%@年",model.year];
        }
        [view addSubview:year_lab];
        
        UIButton *money_btn = [[UIButton alloc] initWithFrame:CGRectMake(135, i * 45, 100, 45)];
        money_btn.tag = i;
        money_btn.titleLabel.textAlignment = NSTextAlignmentLeft;
        [money_btn setTitle:[NSString stringWithFormat:@"￥%@",model.money] forState:UIControlStateNormal];
        [money_btn setTitleColor:color_red forState:UIControlStateNormal];
        [money_btn addTarget:self action:@selector(buyVip:) forControlEvents:UIControlEventTouchCancel];
        [view addSubview:money_btn];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(20, i * 45, 280, 0.7)];
        line.backgroundColor = RGB(153, 153, 153);
        [view addSubview:line];
    }
    
    UIButton *cancle_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancle_btn.frame = CGRectMake(0, dataSource.count * 45, 300, 45);
    [cancle_btn setTitle:@"取消" forState:UIControlStateNormal];
    [cancle_btn setTitleColor:color_red forState:UIControlStateNormal];
    cancle_btn.backgroundColor = KColorBackgroud;
    [cancle_btn addTarget:self action:@selector(cancleAction) forControlEvents:UIControlEventTouchCancel];
    [view addSubview:cancle_btn];
}

- (void)cancleAction{
    !self.cancleBlock ?: self.cancleBlock();
}

- (void)removeView{
    !self.cancleBlock ?: self.cancleBlock();
}

- (void)buyVip:(UIButton *)sender{
    WLVipFeeModel *model = self.dataSource[sender.tag];
    !self.buyVipBlock ?: self.buyVipBlock(model.year);

}
@end
