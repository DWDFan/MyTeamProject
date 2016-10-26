//
//  DWDMultiSelectImageView.m
//  EduChat
//
//  Created by Mr.Black on 15/12/29.
//  Copyright © 2015年 dwd. All rights reserved.
//

#import "DWDMultiSelectImageView.h"
#import "ZGArticleModel.h"

#define KColumn 5
#define KButtonWidth  ((WLScreenW - 30 - 40)/5)
#define KImgSize CGSizeMake(KButtonWidth,KButtonWidth)
#define KImgPadding  (DWDScreenW - KColumn * KButtonWidth)/(KColumn +1)
@interface DWDMultiSelectImageView()

@end
@implementation DWDMultiSelectImageView

+ (instancetype)multiSelectImageView
{
    DWDMultiSelectImageView *multiSelectImageView = [[DWDMultiSelectImageView alloc]init];
    return multiSelectImageView;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.arrImages = [NSMutableArray array];
        
        }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {

        self.backgroundColor = [UIColor clearColor];
        
        _arrImages = [NSMutableArray array];
        self.arrImages = [NSMutableArray array];
    }
    return self;
}

- (void)setArrImages:(NSMutableArray *)arrImages
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

    _arrImages = arrImages.mutableCopy;
    
    if (_arrImages.count < 6) {
        [_arrImages addObject:[UIImage imageNamed:@"add_image"]];
    }
    
    int col = 0;
    int row = 0;
    int paddingx = ZGPadding;
    int paddingOY = ZGPaddingMax;
    int paddingY = 10;
    int btnX = 0;
    int btnY = 0;
    
    for (int i = 0; i < MIN(6, _arrImages.count); i ++) {
        
        col = i % KColumn;
        row = i / KColumn;
        
        btnX = ZGPaddingMax + (KImgSize.width + ZGPadding) * col;
        btnY = paddingOY + row * (KImgSize.height) +  row * paddingY;
        
        UIButton *btn = [[UIButton alloc] init];
        btn.frame = CGRectMake(btnX, btnY, KImgSize.width, KImgSize.height);
        
        id imageObj = _arrImages[i];
        if ([imageObj isKindOfClass:[ZGImageModel class]]) {
            ZGImageModel *imageM = (ZGImageModel *)imageObj;
            [btn sd_setImageWithURL:[NSURL URLWithString:imageM.image] forState:UIControlStateNormal];
        }else {
            [btn setBackgroundImage:_arrImages[i] forState:UIControlStateNormal];
        }
        
        [self addSubview:btn];
        
        // 删除按钮
        NSInteger count = arrImages.count == 6 ? 6 : _arrImages.count - 1;
        if (i < count) {
            UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            deleteBtn.frame = CGRectMake(btn.right - 13, btn.top - 8, 20, 20);
            [deleteBtn setImage:[UIImage imageNamed:@"del_image"] forState:UIControlStateNormal];
            [deleteBtn addTarget:self action:@selector(deleteBtnAcition:) forControlEvents:UIControlEventTouchUpInside];
            [deleteBtn setTag:1000 + i];
            [self addSubview:deleteBtn];
        }
        
        //if button is addButton
        if ((i == _arrImages.count-1) && (_arrImages.count < 7)) {
            [btn addTarget:self action:@selector(openPhoto) forControlEvents:UIControlEventTouchDown];
        }
    }
    
    //setup self frame
    int num =  _arrImages.count % KColumn == 0 ? _arrImages.count / KColumn : _arrImages.count / KColumn + 1;
    [self setHeight: paddingOY + num * (KImgSize.height) +  num * paddingY];

}

- (void)openPhoto
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(multiSelectImageViewDidSelectAddButton:)]) {
        [self.delegate multiSelectImageViewDidSelectAddButton:self];
    }
    
    /*
     * please in delegate method write this code
     
     #import "JFImagePickerController.h"
     
     <JFImagePickerDelegate>
     
    JFImagePickerController *picker = [[JFImagePickerController alloc] initWithRootViewController:nil];
    picker.pickerDelegate = self;
    
    [self.delegate presentViewController:picker animated:YES completion:nil];
     */
}

- (void)clearAllPhotos
{
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            [view removeFromSuperview];
        }
    }
}

- (void)deleteBtnAcition:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(multiSelectImageViewDidDeleteImageAtIndex:)]) {
        
        [self.delegate multiSelectImageViewDidDeleteImageAtIndex:sender.tag - 1000];
    }
}

@end
