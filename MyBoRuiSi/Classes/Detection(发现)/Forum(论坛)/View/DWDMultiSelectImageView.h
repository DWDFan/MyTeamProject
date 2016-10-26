//
//  DWDMultiSelectImageView.h
//  EduChat
//
//  Created by Mr.Black on 15/12/29.
//  Copyright © 2015年 dwd. All rights reserved.
//  选择多张图片 View

#import <UIKit/UIKit.h>
@class DWDMultiSelectImageView;
@protocol DWDMultiSelectImageViewDelegate <NSObject>

@required
- (void)multiSelectImageViewDidSelectAddButton:(DWDMultiSelectImageView *)multiSelectImageView;
- (void)multiSelectImageViewDidDeleteImageAtIndex:(NSUInteger)index;
@end

@interface DWDMultiSelectImageView : UIView

+ (instancetype)multiSelectImageView;

@property (copy, nonatomic) NSMutableArray *arrImages;
@property (nonatomic,weak) id<DWDMultiSelectImageViewDelegate> delegate;

- (void)clearAllPhotos;

@end
