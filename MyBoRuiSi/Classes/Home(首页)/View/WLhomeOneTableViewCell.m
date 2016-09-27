//
//  WLhomeOneTableViewCell.m
//  MyBoRuiSi
//
//  Created by wsl on 16/7/31.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLhomeOneTableViewCell.h"
#import "AFNetworking.h"


@implementation WLhomeOneTableViewCell

- (void)setModel:(CurriculumModel *)model
{
    self.Price.text = model.price;
    self.Tmlong.text = model.tmlong;
    self.disPrice.text = model.disPrice;
    self.Mname.text = model.name;
    self.Author.text = model.author;
    
    [self.Photoimage sd_setImageWithURL:[NSURL URLWithString:model.photo] placeholderImage:[UIImage imageNamed:@"icon"]];
}

//@property (nonatomic,copy) NSString *author;
//@property (nonatomic,copy) NSString *tmlong;/
//@property (nonatomic,copy) NSString *id;
//@property (nonatomic,copy) NSString *price;/
//@property (nonatomic,copy) NSString *disPrice;/
//@property (nonatomic,copy) NSString *photo;/
//@property (nonatomic,copy) NSString *name;

//@property (weak, nonatomic) IBOutlet UIImageView *Photoimage;
//@property (weak, nonatomic) IBOutlet UIImageView *Photoimages;
//@property (weak, nonatomic) IBOutlet UIImageView *Photoimagea;
//@property (weak, nonatomic) IBOutlet UILabel *Author;
//@property (weak, nonatomic) IBOutlet UILabel *Tmlong;
//@property (weak, nonatomic) IBOutlet UILabel *Price;
//@property (weak, nonatomic) IBOutlet UILabel *disPrice;
//@property (weak, nonatomic) IBOutlet UILabel *Mname;
@end
