//
//  LiveTableViewCell.h
//  MyBoRuiSi
//
//  Created by 莫 on 16/8/2.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LiveTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageName;
@property (weak, nonatomic) IBOutlet UILabel *describeLabel;

@property (weak, nonatomic) IBOutlet UILabel *dataLabel;



/**
 *  跳转Block
 */
@property (nonatomic,strong) void (^WLiveTableViewCellBlcok)();


@end
