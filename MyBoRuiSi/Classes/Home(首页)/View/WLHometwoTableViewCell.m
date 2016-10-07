//
//  WLHometwoTableViewCell.m
//  MyBoRuiSi
//
//  Created by wsl on 16/7/31.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLHometwoTableViewCell.h"
#import "AFNetworking.h"
@implementation WLHometwoTableViewCell

- (void)setModell:(RecommendModell *)Modell
{
    self.name.text = Modell.name;
    [self.name sizeToFit];
    self.Level.text = Modell.level;
    self.City.text = [NSString stringWithFormat:@"城市:%@",[MOTool getNULLString:Modell.city]];
    self.Follow.text = [NSString stringWithFormat:@"关注:%@",[MOTool getNULLString:Modell.follow]];
    self.Member.text = [NSString stringWithFormat:@"学员:%@",[MOTool getNULLString:Modell.member]];
    [self.Phopot sd_setImageWithURL:[NSURL URLWithString:Modell.photo] placeholderImage:[UIImage imageNamed:@"icon"]];
}

@end
