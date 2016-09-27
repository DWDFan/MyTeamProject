//
//  CZNewFeatureCell.h
//  大微博5
//
//  Created by wsl on 16/6/6.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CZNewFeatureCell : UICollectionViewCell

@property(nonatomic,strong) UIImage *image;
// 判断是否是最后一页
- (void)setIndexPath:(NSIndexPath *)indexPath count:(int)count;


@end
