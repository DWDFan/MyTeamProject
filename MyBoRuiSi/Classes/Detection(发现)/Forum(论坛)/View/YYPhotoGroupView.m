//
//  YYPhotoGroupView.m
//
//  Created by ibireme on 14/3/9.
//  Copyright (C) 2014 ibireme. All rights reserved.
//

#import "YYPhotoGroupView.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <UIKit/UIDevice.h>
#import "UIDevice+Hardware.h"
#import "SDWebImageManager.h"
#import "UIImage+Blur.h"
#import "CALayer+YYAdd.h"
#import "UIScrollView+Addition.h"
#import "UIView+ViewController.h"
#import "NSData+ImageContentType.h"
#import "UIImage+Color.h"
#import "UIColor+HEX.h"
//#import "YYKit.h"

//#import "GmeQrcode.h"
#import "ChooseActionSheet.h"
//#import "WebViewsController.h"
//#import "SearchGroupResultViewController.h"

//重力感应

//#import "CRMotionView.h"

//涂鸦功能

//#import "ColorGradientViewController.h"

#define kPadding 20
#define kHiColor [UIColor colorWithRGBHex:0x2dd6b8]

#ifndef YY_CLAMP // return the clamped value
#define YY_CLAMP(_x_, _low_, _high_)  (((_x_) > (_high_)) ? (_high_) : (((_x_) < (_low_)) ? (_low_) : (_x_)))
#endif
#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif
CGFloat YYScreenScale() {
    static CGFloat scale;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        scale = [UIScreen mainScreen].scale;
    });
    return scale;
}
static inline CGSize CGSizePixelCeil(CGSize size) {
    CGFloat scale = YYScreenScale();
    return CGSizeMake(ceil(size.width * scale) / scale,
                      ceil(size.height * scale) / scale);
}

@interface YYPhotoGroupItem()<NSCopying>

@property (nonatomic, readonly) UIImage *thumbImage;
@property (nonatomic, readonly) BOOL thumbClippedToTop;
- (BOOL)shouldClipToTop:(CGSize)imageSize forView:(UIView *)view;
@end
@implementation YYPhotoGroupItem

- (UIImage *)thumbImage {
    if ([_thumbView respondsToSelector:@selector(image)]) {
        return ((UIImageView *)_thumbView).image;
    }
    return nil;
}

- (BOOL)thumbClippedToTop {
    if (_thumbView) {
        if (_thumbView.layer.contentsRect.size.height < 1) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)shouldClipToTop:(CGSize)imageSize forView:(UIView *)view {
    if (imageSize.width < 1 || imageSize.height < 1) return NO;
    if (view.width < 1 || view.height < 1) return NO;
    return imageSize.height / imageSize.width > view.width / view.height;
}

- (id)copyWithZone:(NSZone *)zone {
    YYPhotoGroupItem *item = [self.class new];
    return item;
}
@end



@interface YYPhotoGroupCell : UIScrollView <UIScrollViewDelegate>
@property (nonatomic, strong) UIView *imageContainerView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, assign) NSInteger page;

@property (nonatomic, assign) BOOL showProgress;
@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, strong) CAShapeLayer *progressLayer;

@property (nonatomic, strong) YYPhotoGroupItem *item;
@property (nonatomic, readonly) BOOL itemDidLoad;

//@property (nonatomic, strong) CRMotionView *motionView; //重力感应

@property (nonatomic, assign) BOOL isForceCell; //是否是重力感应

- (void)resizeSubviewSize;
@end

@implementation YYPhotoGroupCell

#pragma mark --- 重力感应 ---

- (instancetype)init {
    self = super.init;
    if (!self) return nil;
    self.delegate = self;
    self.bouncesZoom = YES;
    self.maximumZoomScale = 3;
    self.multipleTouchEnabled = YES;
    self.alwaysBounceVertical = NO;
    self.showsVerticalScrollIndicator = YES;
    self.showsHorizontalScrollIndicator = NO;
    self.frame = [UIScreen mainScreen].bounds;
    
    self.isForceCell = YES;
    
    _imageContainerView = [UIView new];
    _imageContainerView.clipsToBounds = YES;
    [self addSubview:_imageContainerView];
    
    //重力感应
//    _motionView = [[CRMotionView alloc] initWithFrame:CGRectMake(ZERO, ZERO, IPHONE_WIDTH, IPHONE_HEIGHT)];
//    [self addSubview:_motionView];

//    _imageView = [UIImageView new];
//    _imageView.clipsToBounds = YES;
//    _imageView.backgroundColor = [UIColor colorWithWhite:1.000 alpha:0.500];
//    
//    _imageView = _motionView.imageView;
//    [_imageContainerView addSubview:_motionView];
    
//    _imageView = [UIImageView new];
//    _imageView.clipsToBounds = YES;
//    _imageView.backgroundColor = [UIColor colorWithWhite:1.000 alpha:0.500];
//    [_imageContainerView addSubview:_imageView];
    
    _progressLayer = [CAShapeLayer layer];
    _progressLayer.size = CGSizeMake(40, 40);
    _progressLayer.cornerRadius = 20;
    _progressLayer.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.500].CGColor;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(_progressLayer.bounds, 7, 7) cornerRadius:(40 / 2 - 7)];
    _progressLayer.path = path.CGPath;
    _progressLayer.fillColor = [UIColor clearColor].CGColor;
    _progressLayer.strokeColor = [UIColor whiteColor].CGColor;
    _progressLayer.lineWidth = 4;
    _progressLayer.lineCap = kCALineCapRound;
    _progressLayer.strokeStart = 0;
    _progressLayer.strokeEnd = 0;
    _progressLayer.hidden = YES;
    [self.layer addSublayer:_progressLayer];
    
    
    return self;
}


- (instancetype)initWithForce{
    self = super.init;
    if (!self) return nil;
    self.delegate = self;
    self.bouncesZoom = YES;
    self.maximumZoomScale = 3;
    self.multipleTouchEnabled = YES;
    self.alwaysBounceVertical = NO;
    self.showsVerticalScrollIndicator = YES;
    self.showsHorizontalScrollIndicator = NO;
    self.frame = [UIScreen mainScreen].bounds;
    
    self.isForceCell = NO;
    
    _imageContainerView = [UIView new];
    _imageContainerView.clipsToBounds = YES;
    [self addSubview:_imageContainerView];
    
        _imageView = [UIImageView new];
        _imageView.clipsToBounds = YES;
        _imageView.backgroundColor = [UIColor colorWithWhite:1.000 alpha:0.500];
    
    
        _imageView = [UIImageView new];
        _imageView.clipsToBounds = YES;
        _imageView.backgroundColor = [UIColor colorWithWhite:1.000 alpha:0.500];
        [_imageContainerView addSubview:_imageView];
    
    _progressLayer = [CAShapeLayer layer];
    _progressLayer.size = CGSizeMake(40, 40);
    _progressLayer.cornerRadius = 20;
    _progressLayer.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.500].CGColor;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(_progressLayer.bounds, 7, 7) cornerRadius:(40 / 2 - 7)];
    _progressLayer.path = path.CGPath;
    _progressLayer.fillColor = [UIColor clearColor].CGColor;
    _progressLayer.strokeColor = [UIColor whiteColor].CGColor;
    _progressLayer.lineWidth = 4;
    _progressLayer.lineCap = kCALineCapRound;
    _progressLayer.strokeStart = 0;
    _progressLayer.strokeEnd = 0;
    _progressLayer.hidden = YES;
    [self.layer addSublayer:_progressLayer];
    
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    _progressLayer.center = CGPointMake(self.width / 2, self.height / 2);
}

- (void)setItem:(YYPhotoGroupItem *)item {
    
    if (_item == item) return;
    _item = item;
    _itemDidLoad = NO;
    
    [self setZoomScale:1.0 animated:NO];
    self.maximumZoomScale = 1;
    
    [_imageView sd_cancelCurrentImageLoad];
  // [_imageView cancelCurrentImageRequest];
    [_imageView.layer removePreviousFadeAnimation];
    
    _progressLayer.hidden = NO;
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    _progressLayer.strokeEnd = 0;
    _progressLayer.hidden = YES;
    [CATransaction commit];
    
    if (!_item) {
        _imageView.image = nil;
        return;
    }
    
    @weakify(self);
    
    [_imageView sd_setImageWithPreviousCachedImageWithURL:item.largeImageURL placeholderImage:item.thumbImage options:SDWebImageContinueInBackground progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        @strongify(self);
        if (!self) return;
        CGFloat progress = receivedSize / (float)expectedSize;
        progress = progress < 0.01 ? 0.01 : progress > 1 ? 1 : progress;
        if (isnan(progress)) progress = 0;
        self.progressLayer.hidden = NO;
        self.progressLayer.strokeEnd = progress;
        
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        @strongify(self);
        if (!self) return;
        self.progressLayer.hidden = YES;
        if (image) {
            self.maximumZoomScale = 3;
            if (image) {
                self->_itemDidLoad = YES;
                
                [self resizeSubviewSize];
                [self.imageView.layer addFadeAnimationWithDuration:0.1 curve:UIViewAnimationCurveLinear];
                
                //重力感应
//                
//                if(_motionView){
//                 [_motionView setImage:image];
//                }
            }
        }
    }];
    
    /*
    [_imageView setImageWithURL:item.largeImageURL placeholder:item.thumbImage options:kNilOptions progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        @strongify(self);
        if (!self) return;
        CGFloat progress = receivedSize / (float)expectedSize;
        progress = progress < 0.01 ? 0.01 : progress > 1 ? 1 : progress;
        if (isnan(progress)) progress = 0;
        self.progressLayer.hidden = NO;
        self.progressLayer.strokeEnd = progress;
    } transform:nil completion:^(UIImage *image, NSURL *url, YYWebImageFromType from, YYWebImageStage stage, NSError *error) {
        @strongify(self);
        if (!self) return;
        self.progressLayer.hidden = YES;
        if (stage == YYWebImageStageFinished) {
            self.maximumZoomScale = 3;
            if (image) {
                self->_itemDidLoad = YES;
                
                [self resizeSubviewSize];
                [self.imageView.layer addFadeAnimationWithDuration:0.1 curve:UIViewAnimationCurveLinear];
            }
        }
        
    }];
     */
    [self resizeSubviewSize];
    
}

- (void)resizeSubviewSize {
    
#pragma mark --- 修改 （以高度适配） ---
    
    if(self.isForceCell){
        
        //重力感应
     
        _imageContainerView.origin = CGPointZero;
        [_imageContainerView setSize:CGSizeMake(0, self.height)];
//        _imageContainerView.height = self.height;
        
        UIImage *image = _imageView.image;
        if (image.size.width / image.size.height > self.width / self.height) {
            CGFloat width = floor(image.size.width / (image.size.height / self.height));
            [_imageContainerView setSize:CGSizeMake(width, self.height)];
//            _imageContainerView.width = floor(image.size.width / (image.size.height / self.height));
        } else {
            CGFloat width = image.size.width / image.size.height * self.height;
            if (width < 1 || isnan(width)) width = self.width;
            width = floor(width);
//            _imageContainerView.width = width;
            [_imageContainerView setSize:CGSizeMake(width, self.height)];
            _imageContainerView.centerX = self.width / 2;
        }
        if (_imageContainerView.width > self.width && _imageContainerView.width - self.width <= 1) {
//            _imageContainerView.width = self.width;
            [_imageContainerView setSize:CGSizeMake(self.width, self.height)];
        }
        self.contentSize = CGSizeMake(self.width, MAX(_imageContainerView.height, self.height));
        [self scrollRectToVisible:self.bounds animated:NO];
        
        if (_imageContainerView.width <= self.width) {
            self.alwaysBounceVertical = NO;
        } else {
            self.alwaysBounceVertical = YES;
        }
        
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        _imageView.frame = _imageContainerView.bounds;
        [CATransaction commit];

    }else{
        _imageContainerView.origin = CGPointZero;
//        _imageContainerView.width = self.size.width;
        [_imageContainerView setSize:CGSizeMake(self.width, 0)];
        
        UIImage *image = _imageView.image;
        if (image.size.height / image.size.width > self.height / self.width) {
            CGFloat height = floor(image.size.height / (image.size.width / self.width));
            [_imageContainerView setSize:CGSizeMake(self.size.width, height)];
        } else {
            CGFloat height = image.size.height / image.size.width * self.width;
            if (height < 1 || isnan(height)) height = self.height;
            height = floor(height);
            [_imageContainerView setSize:CGSizeMake(self.size.width, height)];
//            _imageContainerView.height = height;
            _imageContainerView.centerY = self.height / 2;
            
        }
        if (_imageContainerView.height > self.height && _imageContainerView.height - self.height <= 1) {
//            _imageContainerView.height = self.height;
            [_imageContainerView setSize:CGSizeMake(self.size.width, self.height)];
        }
        self.contentSize = CGSizeMake(self.width, MAX(_imageContainerView.height, self.height));
        
        [self scrollRectToVisible:self.bounds animated:NO];
        
        if (_imageContainerView.height <= self.height) {
            self.alwaysBounceVertical = NO;
        } else {
            self.alwaysBounceVertical = YES;
        }
        
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        _imageView.frame = _imageContainerView.bounds;
        [CATransaction commit];
    }
    
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return _imageContainerView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    
    UIView *subView = _imageContainerView;
    
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
    (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
    (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    
    subView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                                 scrollView.contentSize.height * 0.5 + offsetY);
}

@end

@interface YYPhotoGroupView() <UIScrollViewDelegate, UIGestureRecognizerDelegate>{
 ChooseActionSheet *sheet;
}
@property (nonatomic, weak) UIView *fromView;
@property (nonatomic, weak) UIView *toContainerView;

@property (nonatomic, strong) UIImage *snapshotImage;
@property (nonatomic, strong) UIImage *snapshorImageHideFromView;


@property (nonatomic, strong) UIImageView *blurBackground;

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *cells;
@property (nonatomic, strong) UIPageControl *pager;
@property (nonatomic, assign) CGFloat pagerCurrentPage;
@property (nonatomic, assign) BOOL fromNavigationBarHidden;

@property (nonatomic, assign) NSInteger fromItemIndex;
@property (nonatomic, assign) BOOL isPresented;

@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;
@property (nonatomic, assign) CGPoint panGestureBeginPoint;

@end

@implementation YYPhotoGroupView

- (instancetype)initWithGroupItems:(NSArray *)groupItems{
    self = [super init];
    if (groupItems.count == 0) return nil;
    _groupItems = groupItems.copy;
    _blurEffectBackground = YES;
    
    /*
     NSString *model = [UIDevice currentDevice].machineModel;
     static NSMutableSet *oldDevices;
     static dispatch_once_t onceToken;
     dispatch_once(&onceToken, ^{
     oldDevices = [NSMutableSet new];
     [oldDevices addObject:@"iPod1,1"];
     [oldDevices addObject:@"iPod2,1"];
     [oldDevices addObject:@"iPod3,1"];
     [oldDevices addObject:@"iPod4,1"];
     [oldDevices addObject:@"iPod5,1"];
     
     [oldDevices addObject:@"iPhone1,1"];
     [oldDevices addObject:@"iPhone1,1"];
     [oldDevices addObject:@"iPhone1,2"];
     [oldDevices addObject:@"iPhone2,1"];
     [oldDevices addObject:@"iPhone3,1"];
     [oldDevices addObject:@"iPhone3,2"];
     [oldDevices addObject:@"iPhone3,3"];
     [oldDevices addObject:@"iPhone4,1"];
     
     [oldDevices addObject:@"iPad1,1"];
     [oldDevices addObject:@"iPad2,1"];
     [oldDevices addObject:@"iPad2,2"];
     [oldDevices addObject:@"iPad2,3"];
     [oldDevices addObject:@"iPad2,4"];
     [oldDevices addObject:@"iPad2,5"];
     [oldDevices addObject:@"iPad2,6"];
     [oldDevices addObject:@"iPad2,7"];
     [oldDevices addObject:@"iPad3,1"];
     [oldDevices addObject:@"iPad3,2"];
     [oldDevices addObject:@"iPad3,3"];
     });
     if ([oldDevices containsObject:model]) {
     _blurEffectBackground = NO;
     }8*/
    
    self.backgroundColor = [UIColor clearColor];
    self.frame = [UIScreen mainScreen].bounds;
    self.clipsToBounds = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
    tap2.delegate = self;
    tap2.numberOfTapsRequired = 2;
    [tap requireGestureRecognizerToFail: tap2];
    [self addGestureRecognizer:tap2];
    
//    UILongPressGestureRecognizer *press = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
//    press.delegate = self;
//    [self addGestureRecognizer:press];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        [self addGestureRecognizer:pan];
        _panGesture = pan;
    }
    
    _cells = @[].mutableCopy;
    
    _background = UIImageView.new;
    _background.frame = self.bounds;
    _background.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    _blurBackground = UIImageView.new;
    _blurBackground.frame = self.bounds;
    _blurBackground.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    _contentView = UIView.new;
    _contentView.frame = self.bounds;
    _contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    _scrollView = UIScrollView.new;
    _scrollView.frame = CGRectMake(-kPadding / 2, 0, self.width + kPadding, self.height);
    _scrollView.delegate = self;
    _scrollView.scrollsToTop = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.alwaysBounceHorizontal = groupItems.count > 1;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _scrollView.delaysContentTouches = NO;
    _scrollView.canCancelContentTouches = YES;
    
    _pager = [[UIPageControl alloc] init];
    _pager.hidesForSinglePage = YES;
    _pager.userInteractionEnabled = NO;
    _pager.width = self.width - 36;
    _pager.height = 10;
    _pager.center = CGPointMake(self.width / 2, self.height - 18);
    _pager.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    
    
    [self addSubview:_background];
    [self addSubview:_blurBackground];
    [self addSubview:_contentView];
    [_contentView addSubview:_scrollView];
    [_contentView addSubview:_pager];
    
    return self;
}

#pragma mark --- 涂鸦功能 ---

//- (XGXButton *)tuyaBtn{
//    if(!_tuyaBtn){
//        _tuyaBtn = [XGXButton buttonWithType:UIButtonTypeCustom];
//        [_tuyaBtn setTitle:@"涂鸦" forState:0];
//        _tuyaBtn.frame = CGRectMake( 20 , IPHONE_HEIGHT - 60, 40, 40);
//    }
//    return _tuyaBtn;
//}

#pragma mark --- 切换按钮 ---

//- (XGXButton *)changeBtn{
//    if(!_changeBtn){
//        
//        _changeBtn = [XGXButton buttonWithType:UIButtonTypeCustom];
//        [_changeBtn setTitle:@"切换" forState:0];
//        _changeBtn.selected = SINGLE.isImageChange;
//        _changeBtn.frame = CGRectMake(IPHONE_WIDTH - 60, IPHONE_HEIGHT - 60, 40, 40);
//    }
//    
//    return _changeBtn;
//}


- (instancetype)initWithGroupItems:(NSArray *)groupItems isForce:(BOOL)isForce{
    self = [super init];
    if (groupItems.count == 0) return nil;
    _groupItems = groupItems.copy;
    _blurEffectBackground = YES;
    
//    self.isForce = SINGLE.isImageChange;
    
  /*
    NSString *model = [UIDevice currentDevice].machineModel;
    static NSMutableSet *oldDevices;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        oldDevices = [NSMutableSet new];
        [oldDevices addObject:@"iPod1,1"];
        [oldDevices addObject:@"iPod2,1"];
        [oldDevices addObject:@"iPod3,1"];
        [oldDevices addObject:@"iPod4,1"];
        [oldDevices addObject:@"iPod5,1"];
        
        [oldDevices addObject:@"iPhone1,1"];
        [oldDevices addObject:@"iPhone1,1"];
        [oldDevices addObject:@"iPhone1,2"];
        [oldDevices addObject:@"iPhone2,1"];
        [oldDevices addObject:@"iPhone3,1"];
        [oldDevices addObject:@"iPhone3,2"];
        [oldDevices addObject:@"iPhone3,3"];
        [oldDevices addObject:@"iPhone4,1"];
        
        [oldDevices addObject:@"iPad1,1"];
        [oldDevices addObject:@"iPad2,1"];
        [oldDevices addObject:@"iPad2,2"];
        [oldDevices addObject:@"iPad2,3"];
        [oldDevices addObject:@"iPad2,4"];
        [oldDevices addObject:@"iPad2,5"];
        [oldDevices addObject:@"iPad2,6"];
        [oldDevices addObject:@"iPad2,7"];
        [oldDevices addObject:@"iPad3,1"];
        [oldDevices addObject:@"iPad3,2"];
        [oldDevices addObject:@"iPad3,3"];
    });
    if ([oldDevices containsObject:model]) {
        _blurEffectBackground = NO;
    }8*/
    
    self.backgroundColor = [UIColor clearColor];
    self.frame = [UIScreen mainScreen].bounds;
    self.clipsToBounds = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
    tap2.delegate = self;
    tap2.numberOfTapsRequired = 2;
    [tap requireGestureRecognizerToFail: tap2];
    [self addGestureRecognizer:tap2];
    
//    UILongPressGestureRecognizer *press = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
//    press.delegate = self;
//    [self addGestureRecognizer:press];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        [self addGestureRecognizer:pan];
        _panGesture = pan;
    }
    
    
    _cells = @[].mutableCopy;
    
    _background = UIImageView.new;
    _background.frame = self.bounds;
    _background.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    _blurBackground = UIImageView.new;
    _blurBackground.frame = self.bounds;
    _blurBackground.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    _contentView = UIView.new;
    _contentView.frame = self.bounds;
    _contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    _scrollView = UIScrollView.new;
    _scrollView.frame = CGRectMake(-kPadding / 2, 0, self.width + kPadding, self.height);
    _scrollView.delegate = self;
    _scrollView.scrollsToTop = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.alwaysBounceHorizontal = groupItems.count > 1;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _scrollView.delaysContentTouches = NO;
    _scrollView.canCancelContentTouches = YES;
    
    _pager = [[UIPageControl alloc] init];
    _pager.hidesForSinglePage = YES;
    _pager.userInteractionEnabled = NO;
    _pager.width = self.width - 36;
    _pager.height = 10;
    _pager.center = CGPointMake(self.width / 2, self.height - 18);
    _pager.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    
    [self addSubview:_background];
    [self addSubview:_blurBackground];
    [self addSubview:_contentView];
    [_contentView addSubview:_scrollView];
    [_contentView addSubview:_pager];
    
    //切换按钮
    
    [_contentView addSubview:self.changeBtn];
    
    //涂鸦按钮
//    [_contentView addSubview:self.tuyaBtn];
    
    //切换图片的展示方式
    
//    WEAKSELF;
//    [self.changeBtn addActionHandler:^(NSInteger tag) {
//        
//        [weakSelf dismissAnimated:NO completion:^{
//        }];
//        [weakSelf removeFromSuperview];
//        if(!weakSelf.changeBtn.selected){
//            weakSelf.changeBtn.selected = SINGLE.isImageChange =  YES;
//            YYPhotoGroupView *group = [[YYPhotoGroupView alloc] initWithGroupItems:weakSelf.groupItems isForce:SINGLE.isImageChange];
//            [group presentFromImageView:weakSelf.fromView toContainer:weakSelf.toContainerView animated:YES completion:^{
//            }];
//            
//        }else{
//            weakSelf.changeBtn.selected = SINGLE.isImageChange =  NO;
//            YYPhotoGroupView *group = [[YYPhotoGroupView alloc] initWithGroupItems:weakSelf.groupItems isForce:SINGLE.isImageChange];
//            [group presentFromImageView:weakSelf.fromView toContainer:weakSelf.toContainerView animated:YES completion:^{
//            }];
//        }
//    }];
    
    return self;
}


- (void)presentFromImageView:(UIView *)fromView
                 toContainer:(UIView *)toContainer
                    animated:(BOOL)animated
                  completion:(void (^)(void))completion {
    if (!toContainer) return;
    
    _fromView = fromView;
    _toContainerView = toContainer;
    
    NSInteger page = -1;
    for (NSUInteger i = 0; i < self.groupItems.count; i++) {
        if (fromView == ((YYPhotoGroupItem *)self.groupItems[i]).thumbView) {
            page = (int)i;
            break;
        }
    }
    if (page == -1) page = 0;
    _fromItemIndex = page;
    
    _snapshotImage = [self snapshotImageAfterScreenUpdates:YES toView:_toContainerView];
    BOOL fromViewHidden = fromView.hidden;
    fromView.hidden = YES;
    _snapshorImageHideFromView = [self snapshotImageToView:_toContainerView];
    fromView.hidden = fromViewHidden;
    
    _background.image = _snapshorImageHideFromView;
    if (!_blurEffectBackground) {
        _blurBackground.image = [_snapshorImageHideFromView darkImage];//[_snapshorImageHideFromView blurredImageWithSize:CGSizeMake(100, 100) tintColor:[UIColor colorWithWhite:0.2 alpha:0.78] saturationDeltaFactor:1.0 maskImage:nil];//[_snapshorImageHideFromView blurredImageWithRadius:100]; //Same to UIBlurEffectStyleDark
    } else {
        _blurBackground.image = [UIImage imageWithColor:[UIColor colorWithHexString:@"#1A1A1A"]];
        _blurBackground.alpha = 1.0;
    }
    
    self.size = _toContainerView.size;
    NSLog(@"%f",self.size.width);
//    self.blurBackground.alpha = 0.6;
    self.pager.alpha = 0;
    self.pager.numberOfPages = self.groupItems.count;
    self.pager.currentPage = page;
    [_toContainerView addSubview:self];
    
    _scrollView.contentSize = CGSizeMake(_scrollView.width * self.groupItems.count, _scrollView.height);
    [_scrollView scrollRectToVisible:CGRectMake(_scrollView.width * _pager.currentPage, 0, _scrollView.width, _scrollView.height) animated:NO];
    [self scrollViewDidScroll:_scrollView];
    
    NSLog(@"%f %f",_scrollView.width,_scrollView.height);
    
    [UIView setAnimationsEnabled:YES];
    _fromNavigationBarHidden = [UIApplication sharedApplication].statusBarHidden;
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:animated ? UIStatusBarAnimationFade : UIStatusBarAnimationNone];
    
    YYPhotoGroupCell *cell = [self cellForPage:self.currentPage];
    YYPhotoGroupItem *item = _groupItems[self.currentPage];
    
    if (!item.thumbClippedToTop) {
        [[SDWebImageManager sharedManager]cachedImageExistsForURL:item.largeImageURL completion:^(BOOL isInCache) {
            
            if(isInCache){
                cell.item = item;
            }
        }];
//        NSString *imageKey = [[YYWebImageManager sharedManager] cacheKeyForURL:item.largeImageURL];
//        if ([[YYWebImageManager sharedManager].cache getImageForKey:imageKey withType:YYImageCacheTypeMemory]) {
//            cell.item = item;
//        }
    }
    if (!cell.item) {
        cell.imageView.image = item.thumbImage;
        [cell resizeSubviewSize];
    }
    
    if (item.thumbClippedToTop) {
        CGRect fromFrame = [_fromView convertRect:_fromView.bounds toView:cell];
        CGRect originFrame = cell.imageContainerView.frame;
        CGFloat scale = fromFrame.size.width / cell.imageContainerView.width;
        
        cell.imageContainerView.centerX = CGRectGetMidX(fromFrame);
        cell.imageContainerView.height = fromFrame.size.height / scale;
        cell.imageContainerView.layer.transformScale = scale;
        cell.imageContainerView.centerY = CGRectGetMidY(fromFrame);
        NSLog(@"%f",cell.imageContainerView.height);
        float oneTime = animated ? 0.25 : 0;
        [UIView animateWithDuration:oneTime delay:0 options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseInOut animations:^{
            _blurBackground.alpha = 1.0;
        }completion:NULL];
        
        _scrollView.userInteractionEnabled = NO;
        [UIView animateWithDuration:oneTime delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            cell.imageContainerView.layer.transformScale = 1;
            cell.imageContainerView.frame = originFrame;
            _pager.alpha = 1;
        }completion:^(BOOL finished) {
            _isPresented = YES;
            [self scrollViewDidScroll:_scrollView];
            _scrollView.userInteractionEnabled = YES;
            [self hidePager];
            if (completion) completion();
        }];
        
    } else {
        CGRect fromFrame = [_fromView convertRect:_fromView.bounds toView:cell.imageContainerView];
        
        cell.imageContainerView.clipsToBounds = NO;
        cell.imageView.frame = fromFrame;
        cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
        
        float oneTime = animated ? 0.3 : 0;
        [UIView animateWithDuration:oneTime animations:^{
            _blurBackground.alpha = 1.0;
        }completion:NULL];
        
        _scrollView.userInteractionEnabled = NO;
        [UIView animateWithDuration:oneTime animations:^{
            cell.imageView.frame = cell.imageContainerView.bounds;
//            toContainer.transform = CGAffineTransformMakeScale(
//                                                               0.95, 0.95);/////
            
            cell.imageView.transform = CGAffineTransformIdentity;//////
         //   cell.imageView.layer.transformScale = 1.01;
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 animations:^{
             //   cell.imageView.layer.transformScale = 1.0;
//                toContainer.transform = CGAffineTransformIdentity;
                _pager.alpha = 1;
            }completion:^(BOOL finished) {
                cell.imageContainerView.clipsToBounds = YES;
                _isPresented = YES;
                [self scrollViewDidScroll:_scrollView];
                _scrollView.userInteractionEnabled = YES;
                [self hidePager];
                if (completion) completion();
            }];
        }];
    }
    
    
}
- (UIImage *)snapshotImageAfterScreenUpdates:(BOOL)afterUpdates toView:(UIView *)view{
    if (![view respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0);
        [view.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *snap = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return snap;
    }
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0);
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:afterUpdates];
    UIImage *snap = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snap;
}
- (UIImage *)snapshotImageToView:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *snap = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snap;
}


- (void)dismissAnimated:(BOOL)animated completion:(void (^)(void))completion {
 
    

    if(self.dissBlock)
    self.dissBlock();
    [UIView setAnimationsEnabled:YES];
    
    [[UIApplication sharedApplication] setStatusBarHidden:_fromNavigationBarHidden withAnimation:animated ? UIStatusBarAnimationFade : UIStatusBarAnimationNone];
    NSInteger currentPage = self.currentPage;
    YYPhotoGroupCell *cell = [self cellForPage:currentPage];
    YYPhotoGroupItem *item = _groupItems[currentPage];
    
    UIView *fromView = nil;
    if (_fromItemIndex == currentPage) {
        fromView = _fromView;
    } else {
        fromView = item.thumbView;
    }
    
    [self cancelAllImageLoad];
    _isPresented = NO;
    BOOL isFromImageClipped = fromView.layer.contentsRect.size.height < 1;
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    if (isFromImageClipped) {
        CGRect frame = cell.imageContainerView.frame;
        cell.imageContainerView.layer.anchorPoint = CGPointMake(0.5, 0);
        cell.imageContainerView.frame = frame;
    }
    cell.progressLayer.hidden = YES;
    [CATransaction commit];
    
    
    if (fromView == nil) {
        self.background.image = _snapshotImage;
        [UIView animateWithDuration:animated ? 0.25 : 0 delay:0 options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseOut animations:^{
            _toContainerView.transform = CGAffineTransformMakeScale(
                                                               1, 1);////////////
            
            cell.imageView.transform = CGAffineTransformIdentity;
            self.alpha = 0.0;
            self.scrollView.layer.transformScale = 0.95;
            self.scrollView.alpha = 0;
            self.pager.alpha = 0;
            self.blurBackground.alpha = 0;
        }completion:^(BOOL finished) {
            self.scrollView.layer.transformScale = 1;
            [self removeFromSuperview];
            [self cancelAllImageLoad];
            if (completion) completion();
        }];
        return;
    }
    
    if (_fromItemIndex != currentPage) {
        _background.image = _snapshotImage;
        [_background.layer addFadeAnimationWithDuration:0.25 curve:UIViewAnimationCurveEaseOut];
    } else {
        _background.image = _snapshorImageHideFromView;
    }

    
    if (isFromImageClipped) {
        [cell scrollToTopAnimated:NO];
    }
    
    [UIView animateWithDuration:animated ? 0.2 : 0 delay:0 options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseOut animations:^{
        _pager.alpha = 0.0;
        _blurBackground.alpha = 0.0;
        if (isFromImageClipped) {
            
            CGRect fromFrame = [fromView convertRect:fromView.bounds toView:cell];
            CGFloat scale = fromFrame.size.width / cell.imageContainerView.width * cell.zoomScale;
            CGFloat height = fromFrame.size.height / fromFrame.size.width * cell.imageContainerView.width;
            if (isnan(height)) height = cell.imageContainerView.height;
            
            cell.imageContainerView.height = height;
            cell.imageContainerView.center = CGPointMake(CGRectGetMidX(fromFrame), CGRectGetMinY(fromFrame));
            cell.imageContainerView.layer.transformScale = scale;
            
        } else {
            CGRect fromFrame = [fromView convertRect:fromView.bounds toView:cell.imageContainerView];
            cell.imageContainerView.clipsToBounds = NO;
            cell.imageView.contentMode = fromView.contentMode;
            cell.imageView.frame = fromFrame;
        }
        _toContainerView.transform = CGAffineTransformMakeScale(
                                                                1, 1);////////////
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:animated ? 0.15 : 0 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {
            cell.imageContainerView.layer.anchorPoint = CGPointMake(0.5, 0.5);
            [self removeFromSuperview];
            if (completion) completion();
        }];
    }];
    
    
}

- (void)dismiss {
    [self dismissAnimated:YES completion:nil];
}


- (void)cancelAllImageLoad {
    [_cells enumerateObjectsUsingBlock:^(YYPhotoGroupCell *cell, NSUInteger idx, BOOL *stop) {
       // [cell.imageView cancelCurrentImageRequest];
        [cell.imageView sd_cancelCurrentImageLoad];
    }];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self updateCellsForReuse];
    
    CGFloat floatPage = _scrollView.contentOffset.x / _scrollView.width;
    NSInteger page = _scrollView.contentOffset.x / _scrollView.width + 0.5;
    
    for (NSInteger i = page - 1; i <= page + 1; i++) { // preload left and right cell
        if (i >= 0 && i < self.groupItems.count) {
            YYPhotoGroupCell *cell = [self cellForPage:i];
            if (!cell) {
                YYPhotoGroupCell *cell = [self dequeueReusableCell];
                cell.page = i;
                cell.left = (self.width + kPadding) * i + kPadding / 2;
                
                if (_isPresented) {
                    cell.item = self.groupItems[i];
                }
                [self.scrollView addSubview:cell];
            } else {
                if (_isPresented && !cell.item) {
                    cell.item = self.groupItems[i];
                }
            }
        }
    }
    
    NSInteger intPage = floatPage + 0.5;
    intPage = intPage < 0 ? 0 : intPage >= _groupItems.count ? (int)_groupItems.count - 1 : intPage;
    _pager.currentPage = intPage;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
        _pager.alpha = 1;
    }completion:^(BOOL finish) {
    }];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (!decelerate) {
        [self hidePager];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self hidePager];
}


- (void)hidePager {
        [UIView animateWithDuration:0.3 delay:0.8 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseOut animations:^{
            _pager.alpha = 0;
        }completion:^(BOOL finish) {
        }];
}

/// enqueue invisible cells for reuse
- (void)updateCellsForReuse {
    for (YYPhotoGroupCell *cell in _cells) {
        if (cell.superview) {
            if (cell.left > _scrollView.contentOffset.x + _scrollView.width * 2||
                cell.right < _scrollView.contentOffset.x - _scrollView.width) {
                [cell removeFromSuperview];
                cell.page = -1;
                cell.item = nil;
            }
        }
    }
}

#pragma mark --- 初始化  ---

/// dequeue a reusable cell
- (YYPhotoGroupCell *)dequeueReusableCell {
    YYPhotoGroupCell *cell = nil;
    for (cell in _cells) {
        if (!cell.superview) {
            return cell;
        }
    }
    
//    NSLog(@"isforce == %d",self.isForce);
    
    cell = [[YYPhotoGroupCell alloc] initWithForce];
    cell.frame = self.bounds;
    cell.imageContainerView.frame = self.bounds;
    cell.imageView.frame = cell.bounds;
    cell.page = -1;
    cell.item = nil;
    [_cells addObject:cell];
    return cell;
}

/// get the cell for specified page, nil if the cell is invisible
- (YYPhotoGroupCell *)cellForPage:(NSInteger)page {
    for (YYPhotoGroupCell *cell in _cells) {
        if (cell.page == page) {
            return cell;
        }
    }
    return nil;
}

- (NSInteger)currentPage {
    NSInteger page = _scrollView.contentOffset.x / _scrollView.width + 0.5;
    if (page >= _groupItems.count) page = (NSInteger)_groupItems.count - 1;
    if (page < 0) page = 0;
    return page;
}

- (void)showHUD:(NSString *)msg {
    if (!msg.length) return;
    UIFont *font = [UIFont systemFontOfSize:17];
    CGSize size = [MOTool heightForText:msg size:CGSizeMake(200, 200) font:font];//[msg sizeForFont:font size:CGSizeMake(200, 200) mode:NSLineBreakByCharWrapping];
    UILabel *label = [UILabel new];
    label.size = CGSizePixelCeil(size);
    label.font = font;
    label.text = msg;
    label.textColor = [UIColor whiteColor];
    label.numberOfLines = 0;
    
    UIView *hud = [UIView new];
    hud.size = CGSizeMake(label.width + 20, label.height + 20);
    hud.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.650];
    hud.clipsToBounds = YES;
    hud.layer.cornerRadius = 8;
    
    label.center = CGPointMake(hud.width / 2, hud.height / 2);
    [hud addSubview:label];
    
    hud.center = CGPointMake(self.width / 2, self.height / 2);
    hud.alpha = 0;
    [self addSubview:hud];
    
    [UIView animateWithDuration:0.4 animations:^{
        hud.alpha = 1;
    }];
    double delayInSeconds = 1.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [UIView animateWithDuration:0.4 animations:^{
            hud.alpha = 0;
        } completion:^(BOOL finished) {
            [hud removeFromSuperview];
        }];
    });
}

- (void)doubleTap:(UITapGestureRecognizer *)g {
    if (!_isPresented) return;
    YYPhotoGroupCell *tile = [self cellForPage:self.currentPage];
    if (tile) {
        if (tile.zoomScale > 1) {
            [tile setZoomScale:1 animated:YES];
        } else {
            CGPoint touchPoint = [g locationInView:tile.imageView];
            CGFloat newZoomScale = tile.maximumZoomScale;
            CGFloat xsize = self.width / newZoomScale;
            CGFloat ysize = self.height / newZoomScale;
            [tile zoomToRect:CGRectMake(touchPoint.x - xsize/2, touchPoint.y - ysize/2, xsize, ysize) animated:YES];
        }
    }
}

//- (void)longPress:(UILongPressGestureRecognizer *)recognizer {
//    if (!_isPresented) return;
//    
//    
//    
//    YYPhotoGroupCell *tile = [self cellForPage:self.currentPage];
//    if (!tile.imageView.image) return;
//    
//    // try to save original image data if the image contains multi-frame (such as GIF/APNG)
//    
//    id imageItem = tile.imageView.image;
//    
////    id imageItem = [tile.imageView.image dataRepresentation];
////    YYImageType type = YYImageDetectType((__bridge CFDataRef)(imageItem));
////    if (type != YYImageTypePNG &&
////        type != YYImageTypeJPEG &&
////        type != YYImageTypeGIF) {
////        imageItem = tile.imageView.image;
////    }
//    //com.tencent.xin.sharetimeline
//    
//    /*
//    UIActivityViewController *activityViewController =
//    [[UIActivityViewController alloc] initWithActivityItems:@[imageItem] applicationActivities:nil];
//
//    
//    UIViewController *toVC = self.toContainerView.viewController;
//    if (!toVC) toVC = self.viewController;
//    [toVC presentViewController:activityViewController animated:YES completion:nil];
//     */
//    
//    if(recognizer.state == UIGestureRecognizerStateBegan)
//    {
//    if(sheet){
//        [sheet removeFromSuperview];
//        
//    }
//    sheet = [[ChooseActionSheet alloc]init];
//    
//    [sheet showChooseActionSheetBlock:^(NSInteger buttonIndex, BOOL isCannel) {
//        
//        if(isCannel)
//        {
//            return;
//        }
//        
//        if(buttonIndex == 0){
//        
//            ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc]init];
//            [assetsLibrary writeImageToSavedPhotosAlbum:[imageItem CGImage] orientation:(ALAssetOrientation)tile.imageView.image.imageOrientation completionBlock:^(NSURL *assetURL, NSError *error) {
//                if (error) {
//                    WLLog(@"Save image fail：%@",error);
//                }else{
//                    WLLog(@"Save image succeed.");
//                    [UIView show_success_progress:@"保存成功"];
//                }
//              
//            }];
//            
//        }
//        else if(buttonIndex == 1)
//        {
//            NSLog(@"识别");
//            
//            [((ViewController *)self.window.rootViewController).personalVC hiddenTabBar];
//            
//            NSString *result = [GmeQrcode dealLongPress:tile.imageView];
//            NSLog(@"识别二维码的结果===== %@",result);
//            
//            if (result) {
//                 [self dismiss];
//                NSString *stringValue = result;//result.text;
//                NSLog(@"contents =%@",stringValue);
//                //                    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"解析成功" message:contents delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
//                //                    [alter show];
//                
//                if([stringValue hasPrefix:@"friendId"])
//                {
//                    NSString *urlStr = [[stringValue componentsSeparatedByString:@"="] lastObject];
//                    
//                    OtherPersonalViewController *vc = [[OtherPersonalViewController alloc] init];
//                    vc.userId = urlStr;
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        [((ViewController *)[Common shareAppDelegate].window.rootViewController).relationshipVC pushViewController:vc animated:YES];
//                        
//                    });
//                    
//                }else if ([stringValue hasPrefix:@"crowdId"]){
//                    
//                    NSString *sid = [[stringValue componentsSeparatedByString:@"="] lastObject];
//                    SearchGroupResultViewController *xxxx = [SearchGroupResultViewController new];
//                    xxxx.crowid = [Common getNULLString:sid];
//                     [((ViewController *)[Common shareAppDelegate].window.rootViewController).relationshipVC pushViewController:xxxx animated:YES];
//                    
//                }
//                else
//                {
//                    WebViewsController *vc =[WebViewsController new];
//                    vc.urlstr = stringValue;
//                    vc.titles = @"详情";
//                     [((ViewController *)[Common shareAppDelegate].window.rootViewController).relationshipVC pushViewController:vc animated:YES];
//                }
//                
//                
//                
//            } else {
//                //                    UIAlertView *alter1 = [[UIAlertView alloc] initWithTitle:@"无法识别" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
//                //                    [alter1 show];
//            }
//            
//        }
//        else
//        {
//            
//        }
//        
//    } cancelButtonTitle:@"取消" array:@[@"保存",@"识别二维码"]];
//    }
//}

- (void)pan:(UIPanGestureRecognizer *)g {
    switch (g.state) {
        case UIGestureRecognizerStateBegan: {
            if (_isPresented) {
                _panGestureBeginPoint = [g locationInView:self];
            } else {
                _panGestureBeginPoint = CGPointZero;
            }
        } break;
        case UIGestureRecognizerStateChanged: {
            if (_panGestureBeginPoint.x == 0 && _panGestureBeginPoint.y == 0) return;
            CGPoint p = [g locationInView:self];
            CGFloat deltaY = p.y - _panGestureBeginPoint.y;
            _scrollView.top = deltaY;
            
            CGFloat alphaDelta = 160;
            CGFloat alpha = (alphaDelta - fabs(deltaY) + 50) / alphaDelta;
            alpha = YY_CLAMP(alpha, 0, 1);
            [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveLinear animations:^{
                _blurBackground.alpha = alpha;
                _pager.alpha = alpha;
            } completion:nil];
            
        } break;
        case UIGestureRecognizerStateEnded: {
            if (_panGestureBeginPoint.x == 0 && _panGestureBeginPoint.y == 0) return;
            CGPoint v = [g velocityInView:self];
            CGPoint p = [g locationInView:self];
            CGFloat deltaY = p.y - _panGestureBeginPoint.y;
            
            if (fabs(v.y) > 1000 || fabs(deltaY) > 120) {
                [self cancelAllImageLoad];
                _isPresented = NO;
                [[UIApplication sharedApplication] setStatusBarHidden:_fromNavigationBarHidden withAnimation:UIStatusBarAnimationFade];
                BOOL moveToTop = (v.y < - 50 || (v.y < 50 && deltaY < 0));
                CGFloat vy = fabs(v.y);
                if (vy < 1) vy = 1;
                CGFloat duration = (moveToTop ? _scrollView.bottom : self.height - _scrollView.top) / vy;
                duration *= 0.8;
                duration = YY_CLAMP(duration, 0.05, 0.3);
                [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionBeginFromCurrentState animations:^{
                    _toContainerView.transform = CGAffineTransformMakeScale(
                                                                            1, 1);////////////
                    _blurBackground.alpha = 0;
                    _pager.alpha = 0;
                    if (moveToTop) {
                        _scrollView.bottom = 0;
                    } else {
                        _scrollView.top = self.height;
                    }
                } completion:^(BOOL finished) {
                    if(self.dissBlock)
                     self.dissBlock();
                    [self removeFromSuperview];
                }];
                _background.image = _snapshotImage;
                [_background.layer addFadeAnimationWithDuration:0.3 curve:UIViewAnimationCurveEaseInOut];
            } else {
                [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:0.9 initialSpringVelocity:v.y / 1000 options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState animations:^{
                    _scrollView.top = 0;
                    _blurBackground.alpha = 1;
                    _pager.alpha = 1;
                } completion:^(BOOL finished) {
                    
                }];
            }
            
        } break;
        case UIGestureRecognizerStateCancelled : {
            _scrollView.top = 0;
            _blurBackground.alpha = 1;
        }
        default:break;
    }
}





@end
