//
//  DWDMultiSelectImageView.m
//  EduChat
//
//  Created by Mr.Black on 15/12/29.
//  Copyright © 2015年 dwd. All rights reserved.
//

#import "DWDMultiSelectImageView.h"

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
    
//    UILabel *lab = [[UILabel alloc]init];
//    lab.text = @"添加图片";
//    lab.textColor = COLOR_WORD_GRAY_1;
//    lab.font = [UIFont systemFontOfSize:14];
//    lab.frame = CGRectMake(10, 10, 100, 25);
//    [self addSubview:lab];

    
    if (arrImages.count < 6) {
        [arrImages addObject:[UIImage imageNamed:@"add_image"]];
    }
    _arrImages = arrImages;
    
    int col = 0;
    int row = 0;
    int paddingx = ZGPadding;
    int paddingOY = ZGPaddingMax;
    int paddingY = 10;
    int btnX = 0;
    int btnY = 0;
    
    for (int i = 0; i < arrImages.count; i ++) {
        
        col = i % KColumn;
        row = i / KColumn;
        
        btnX = ZGPaddingMax + (KImgSize.width + ZGPadding) * col;
        btnY = paddingOY + row * (KImgSize.height) +  row * paddingY;
        
        UIButton *btn = [[UIButton alloc] init];
        btn.frame = CGRectMake(btnX, btnY, KImgSize.width, KImgSize.height);
        
        [btn setBackgroundImage:arrImages[i] forState:UIControlStateNormal];
        [self addSubview:btn];
        
        //if button is addButton
        if ((i == arrImages.count-1) && (arrImages.count < 10)) {
            [btn addTarget:self action:@selector(openPhoto) forControlEvents:UIControlEventTouchDown];
        }
    }
    
    //setup self frame
    int num =  arrImages.count % KColumn == 0 ? arrImages.count / KColumn : arrImages.count / KColumn + 1;
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
@end
