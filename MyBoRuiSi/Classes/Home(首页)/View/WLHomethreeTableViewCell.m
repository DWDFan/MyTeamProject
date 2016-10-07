//
//  WLHomethreeTableViewCell.m
//  MyBoRuiSi
//
//  Created by wsl on 16/7/31.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLHomethreeTableViewCell.h"

@interface WLHomethreeTableViewCell ()

@property (nonatomic, strong) NSMutableArray *starArray;

@end

@implementation WLHomethreeTableViewCell

- (void)setModelll:(RecommendationModelll *)Modelll
{
    self.mname.text = Modelll.name;
    self.follow.text = [NSString stringWithFormat:@"关注:%@",Modelll.follow];;
    self.mmember.text = [NSString stringWithFormat:@"学员:%@",Modelll.member];;
    [self.pphoto sd_setImageWithURL:[NSURL URLWithString:Modelll.photo] placeholderImage:[UIImage imageNamed:@"photo_defult"]];
    
    for (int i = 0; i < 5; i ++) {
        UIImageView *star = (UIImageView *)_starArray[i];
        if (i < [Modelll.star intValue]) {
            star.hidden = NO;
        }else {
            star.hidden = YES;
        }
    }
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    _starArray = [NSMutableArray array];
    
    for (int i = 0; i < 5; i ++) {
        UIImageView *star = [[UIImageView alloc] init];
        star.frame = CGRectMake(i * 10, 0, 10, 10);
        star.image = [UIImage imageNamed:@"素彩网www.sc115.com-102"];
        [_starArray addObject:star];
        
        UIImageView *starGray = [[UIImageView alloc] init];
        starGray.frame = CGRectMake(i * 10, 0, 10, 10);
        starGray.image = [UIImage imageNamed:@"素彩网www.sc115.com-102-拷贝-3"];
        
        [self.starView addSubview:starGray];
        [self.starView addSubview:star];
    }
}

@end
