//
//  YYPhotoGroupView.h
//
//  Created by ibireme on 14/3/9.
//  Copyright (C) 2014 ibireme. All rights reserved.
//

#import <UIKit/UIKit.h>


/// Single picture's info.
@interface YYPhotoGroupItem : NSObject

@property (nonatomic, assign) BOOL isForceItem; //判断是否是重重力感应

@property (nonatomic, strong) UIView *thumbView; ///< thumb image, used for animation position calculation
@property (nonatomic, assign) CGSize largeImageSize;
@property (nonatomic, strong) NSURL *largeImageURL;
@end


/// Used to show a group of images.
/// One-shot.
@interface YYPhotoGroupView : UIView

@property (nonatomic, strong) UIButton *tuyaBtn; //涂鸦按钮
@property (nonatomic, strong) UIImageView *background;
//@property (nonatomic,assign) BOOL isForce; //判断是否是重力感应

@property (nonatomic, readonly) NSArray *groupItems; ///< Array<YYPhotoGroupItem>
@property (nonatomic, readonly) NSInteger currentPage;
@property (nonatomic, assign) BOOL blurEffectBackground; ///< Default is YES
@property (nonatomic, copy)void (^dissBlock)();

@property (nonatomic, strong) UIButton *changeBtn; //切换按钮

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
- (instancetype)initWithFrame:(CGRect)frame UNAVAILABLE_ATTRIBUTE;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;
- (instancetype)initWithGroupItems:(NSArray *)groupItems;
- (instancetype)initWithGroupItems:(NSArray *)groupItems isForce:(BOOL)isForce;

- (void)presentFromImageView:(UIView *)fromView
                 toContainer:(UIView *)container
                    animated:(BOOL)animated
                  completion:(void (^)(void))completion;

- (void)dismissAnimated:(BOOL)animated completion:(void (^)(void))completion;
- (void)dismiss;

@end
