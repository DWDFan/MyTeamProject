//
//  SZAddImage.m
//  MyBoRuiSi
//
//  Created by Catski on 2016/10/10.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "SZAddImage.h"
#import "JFImagePickerController.h"

#define imageH ((WLScreenW - 30 - 40)/5) // 图片高度
#define imageW ((WLScreenW - 30 - 40)/5) // 图片宽度
#define kMaxColumn 5 // 每行显示数量
#define MaxImageCount 6 // 最多显示图片个数
#define deleImageWH 15 // 删除按钮的宽高
#define kAdeleImage @"del_image" // 删除按钮图片
#define kAddImage @"add_image" // 添加按钮图片

@interface SZAddImage()<UINavigationControllerDelegate, UIImagePickerControllerDelegate, JFImagePickerDelegate>
{
    // 标识被编辑的按钮 -1 为添加新的按钮
    NSInteger editTag;
}
@end

@implementation SZAddImage

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *btn = [self createButtonWithImage:kAddImage andSeletor:@selector(addNew:)];
        [self addSubview:btn];
    }
    return self;
}

-(NSMutableArray *)images
{
    if (_images == nil) {
        _images = [NSMutableArray array];
    }
    return _images;
}

// 添加新的控件
- (void)addNew:(UIButton *)btn
{
    // 标识为添加一个新的图片
    
    if (![self deleClose:btn]) {
        editTag = -1;
        [self callImagePicker];
    }
    
    
}

// 修改旧的控件
- (void)changeOld:(UIButton *)btn
{
    // 标识为修改(tag为修改标识)
    if (![self deleClose:btn]) {
        editTag = btn.tag;
        [self callImagePicker];
    }
}

// 删除"删除按钮"
- (BOOL)deleClose:(UIButton *)btn
{
    if (btn.subviews.count == 2) {
        [[btn.subviews lastObject] removeFromSuperview];
        [self stop:btn];
        return YES;
    }
    
    return NO;
}

// 调用图片选择器
- (void)callImagePicker
{
//    UIImagePickerController *pc = [[UIImagePickerController alloc] init];
//    pc.allowsEditing = YES;
//    pc.delegate = self;
//    [self.window.rootViewController presentViewController:pc animated:YES completion:nil];
    JFImagePickerController *picker = [[JFImagePickerController alloc] initWithRootViewController:self.window.rootViewController];
    picker.pickerDelegate = self;
    
    [self.window.rootViewController presentViewController:picker animated:YES completion:nil];
}


// 根据图片名称或者图片创建一个新的显示控件
- (UIButton *)createButtonWithImage:(id)imageNameOrImage andSeletor : (SEL)selector
{
    UIImage *addImage = nil;
    if ([imageNameOrImage isKindOfClass:[NSString class]]) {
        addImage = [UIImage imageNamed:imageNameOrImage];
    }
    else if([imageNameOrImage isKindOfClass:[UIImage class]])
    {
        addImage = imageNameOrImage;
    }
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setBackgroundImage:addImage forState:UIControlStateNormal];
    [addBtn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    addBtn.tag = self.subviews.count;
    
    // 添加长按手势,用作删除.加号按钮不添加
    if(addBtn.tag != 0)
    {
        UILongPressGestureRecognizer *gester = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        [addBtn addGestureRecognizer:gester];
    }
    return addBtn;
    
}


// 长按添加删除按钮
- (void)longPress : (UIGestureRecognizer *)gester
{
    if (gester.state == UIGestureRecognizerStateBegan)
    {
        UIButton *btn = (UIButton *)gester.view;
        
        UIButton *dele = [UIButton buttonWithType:UIButtonTypeCustom];
        dele.bounds = CGRectMake(0, 0, deleImageWH, deleImageWH);
        [dele setImage:[UIImage imageNamed:kAdeleImage] forState:UIControlStateNormal];
        [dele addTarget:self action:@selector(deletePic:) forControlEvents:UIControlEventTouchUpInside];
        dele.frame = CGRectMake(btn.frame.size.width - dele.frame.size.width, 0, dele.frame.size.width, dele.frame.size.height);
        
        [btn addSubview:dele];
        [self start : btn];
        
        
    }
    
}

// 长按开始抖动
- (void)start : (UIButton *)btn {
    double angle1 = -5.0 / 180.0 * M_PI;
    double angle2 = 5.0 / 180.0 * M_PI;
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    anim.keyPath = @"transform.rotation";
    
    anim.values = @[@(angle1),  @(angle2), @(angle1)];
    anim.duration = 0.25;
    // 动画的重复执行次数
    anim.repeatCount = MAXFLOAT;
    
    // 保持动画执行完毕后的状态
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    
    [btn.layer addAnimation:anim forKey:@"shake"];
}

// 停止抖动
- (void)stop : (UIButton *)btn{
    [btn.layer removeAnimationForKey:@"shake"];
}

// 删除图片
- (void)deletePic : (UIButton *)btn
{
    [self.images removeObject:[(UIButton *)btn.superview imageForState:UIControlStateNormal]];
    [btn.superview removeFromSuperview];
    if ([[self.subviews lastObject] isHidden]) {
        [[self.subviews lastObject] setHidden:NO];
    }
    
    
}

// 对所有子控件进行布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    int count = self.subviews.count;
    CGFloat btnW = imageW;
    CGFloat btnH = imageH;
    int maxColumn = kMaxColumn > self.frame.size.width / imageW ? self.frame.size.width / imageW : kMaxColumn;
//    CGFloat marginX = (self.frame.size.width - maxColumn * btnW) / (count + 1);
//    CGFloat marginY = marginX;
    for (int i = 0; i < count; i++) {
        UIButton *btn = self.subviews[i];
        CGFloat btnX = (i % maxColumn) * (10 + btnW) + ZGPaddingMax;
        CGFloat btnY = (i / maxColumn) * (10 + btnH);
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
    
}

#pragma mark - UIImagePickerController 代理方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerEditedImage];
    if (editTag == -1) {
        // 创建一个新的控件
        UIButton *btn = [self createButtonWithImage:image andSeletor:@selector(changeOld:)];
        [self insertSubview:btn atIndex:self.subviews.count - 1];
        [self.images addObject:image];
        if (self.subviews.count - 1 == MaxImageCount) {
            [[self.subviews lastObject] setHidden:YES];
            
        }
    }
    else
    {
        // 根据tag修改需要编辑的控件
        UIButton *btn = (UIButton *)[self viewWithTag:editTag];
//        NSUInteger index = [self.images indexOfObject:[btn imageForState:UIControlStateNormal]];
        [self.images removeObjectAtIndex:editTag - 1];
        [btn setBackgroundImage:image forState:UIControlStateNormal];
        [self.images insertObject:image atIndex:editTag - 1];
    }
    // 退出图片选择控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerDidFinished:(JFImagePickerController *)picker {
    
    NSMutableArray *temp = [NSMutableArray arrayWithCapacity:9];
    
    for (ALAsset *asset in picker.assets) {
        [[JFImageManager sharedManager] thumbWithAsset:asset resultHandler:^(UIImage *result) {
            [temp addObject:result];
        }];
    }
    
//    self.multiSelectImageView.arrImages = temp;
//    self.multiSelectImageHeight.constant = self.multiSelectImageView.frame.size.height;
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerDidCancel:(JFImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}



@end
