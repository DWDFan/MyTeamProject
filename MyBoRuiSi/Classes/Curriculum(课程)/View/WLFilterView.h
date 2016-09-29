//
//  WLFilterView.h
//  MyBoRuiSi
//
//  Created by Catskiy on 16/9/27.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WLFilterViewDelegate <NSObject>

- (void)filerViewDidselectedButton:(UIButton *)button Index:(NSInteger)index isChange:(BOOL)isChange;

@end

@interface WLFilterView : UIView

@property (nonatomic, weak) id<WLFilterViewDelegate> delegate;

- (void)setFilterButtonNormal;

@end
