//
//  WLIssueArticleViewController.m
//  MyBoRuiSi
//
//  Created by Catski on 2016/10/10.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLIssueArticleViewController.h"
#import "WLFindDataHandle.h"
#import "ZGPlaceHolderTextView.h"
#import "SZAddImage.h"
#import "DWDMultiSelectImageView.h"
#import "JFImagePickerController.h"

#define imageW (WLScreenW - 30 - 40)/5

@interface WLIssueArticleViewController ()<UITextViewDelegate, DWDMultiSelectImageViewDelegate, JFImagePickerDelegate>

@property (nonatomic, strong) UITextField *titleTF;
@property (nonatomic, strong) ZGPlaceHolderTextView *contentTV;
@property (nonatomic, strong) SZAddImage *addPhotoView;
@property (nonatomic, strong) DWDMultiSelectImageView *multiSelectView;
@property (nonatomic, strong) NSMutableArray *selectImages;
@property (nonatomic, strong) NSMutableArray *imageNames;
@property (nonatomic, strong) NSMutableArray *sourceImages;
@property (nonatomic, strong) NSMutableArray *allImages;

@end

@implementation WLIssueArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setSubviews];
}

- (void)setSubviews
{
    self.tableViewStyle = UITableViewStyleGrouped;
    self.tableView.scrollEnabled = NO;
    
    if (_type == EditTypeEdit) {
        [self setNavigationBarStyleDefultWithTitle:@"修改"];
        
        self.titleTF.text = self.articleViewModel.article.title;
        self.contentTV.text = self.articleViewModel.article.content;
        [self.multiSelectView clearAllPhotos];
        self.sourceImages = [NSMutableArray arrayWithArray:self.articleViewModel.article.image];
        self.multiSelectView.arrImages = self.sourceImages;
        
        UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        sureBtn.frame = CGRectMake(0, WLScreenH - IOS7_TOP_Y - 49, WLScreenW, 49);
        sureBtn.backgroundColor = color_red;
        [sureBtn setTitle:@"确认" forState:UIControlStateNormal];
        [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [sureBtn addTarget:self action:@selector(rightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:sureBtn];
    }else {
        [self setNavigationBarStyleDefultWithTitle:@"发帖"];
        [self.rightBtn setTitle:@"发布" forState:UIControlStateNormal];
        [self.rightBtn setTitleColor:color_red forState:UIControlStateNormal];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightBtn];
    }
}

- (void)rightBtnAction:(id)sender
{
    if (_titleTF.text.length == 0) {
        [MOProgressHUD showErrorWithStatus:@"请输入标题"];
        return;
    }else if (_contentTV.text.length == 0){
        [MOProgressHUD showErrorWithStatus:@"请输入内容"];
        return;
    }
    
    [self uploadPhoto];
}



- (void)uploadPhoto
{
    
    [self.imageNames removeAllObjects];
    
    [MOProgressHUD showWithStatus:@"正在上传图片..."];
    
    if (self.selectImages.count == 0) {
        [self issueArticleData];
        return;
    }
    
    for (int i = 0; i < self.selectImages.count; i ++) {
        
        NSData *fileData = UIImageJPEGRepresentation(self.selectImages[i], 0.2);
        [WLFindDataHandle requestUploatPhotoWithFiledata:fileData uid:[WLUserInfo share].userId success:^(id responseObject) {
            
            [self.imageNames addObject:responseObject[@"link"]];
            WLLog(@"*******************************%@",responseObject[@"link"]);
            if (self.imageNames.count == self.selectImages.count) {
                [self issueArticleData];
            }
        } failure:^(NSError *error) {
            [MOProgressHUD showErrorWithStatus:@"上传失败"];
        }];
    }
    
}

- (void)issueArticleData
{
    NSMutableString *pics = [NSMutableString string];
    
    for (int i = 0; i < self.sourceImages.count; i ++) {
        
        ZGImageModel *imageM = self.sourceImages[i];
        NSString *imageName = imageM.image;
        [pics appendString:imageName];
        [pics appendString:@"|"];
    }
    
    for (int i = 0; i < self.imageNames.count; i ++) {
        
        [pics appendString:self.imageNames[i]];
        [pics appendString:@"|"];
    }
    
    if (pics.length > 0) {
        [pics deleteCharactersInRange:NSMakeRange(pics.length - 1, 1)];
    }
    
    if (_type == EditTypeEdit) {
        
        [WLFindDataHandle requestFindArticleEditWithQid:_articleViewModel.article.qid
                                                    uid:[WLUserInfo share].userId
                                                  title:_titleTF.text
                                                content:_contentTV.text
                                                   pics:pics
                                                    tid:_articleViewModel.article.tid
                                                success:^(id responseObject) {
            
            [MOProgressHUD showSuccessWithStatus:@"修改成功"];
            [self.navigationController popViewControllerAnimated:YES];
            
        } failure:^(NSError *error) {
            [MOProgressHUD showErrorWithStatus:error.userInfo[@"msg"]];
        }];
    }else {
        
        [WLFindDataHandle requestFindArticleIssueWithQid:_circleId
                                                     uid:[WLUserInfo share].userId
                                                   title:_titleTF.text
                                                 content:_contentTV.text
                                                    pics:pics
                                                 success:^(id responseObject) {
            
            [MOProgressHUD showSuccessWithStatus:@"发布成功"];
            [self.navigationController popViewControllerAnimated:YES];
        } failure:^(NSError *error) {
            [MOProgressHUD showErrorWithStatus:error.userInfo[@"msg"]];
        }];
    }
}

- (UITextField *)titleTF
{
    if (!_titleTF) {
        _titleTF = [[UITextField alloc] init];
        _titleTF.frame = CGRectMake(ZGPaddingMax, 0, WLScreenW - ZGPaddingMax * 2, 50);
        _titleTF.placeholder = @"请输入标题";
        _titleTF.font = [UIFont systemFontOfSize:14];
        _titleTF.textColor = COLOR_WORD_BLACK;
    }
    return _titleTF;
}

- (ZGPlaceHolderTextView *)contentTV
{
    if (!_contentTV) {
        _contentTV = [[ZGPlaceHolderTextView alloc] init];
        _contentTV.frame = CGRectMake(ZGPaddingMax, ZGPadding, WLScreenW - ZGPaddingMax * 2, 120);
        _contentTV.placeholder = @"请输入内容";
        _contentTV.font = [UIFont systemFontOfSize:14];
        _contentTV.textColor = COLOR_WORD_BLACK;
        _contentTV.delegate = self;
    }
    return _contentTV;
}

- (DWDMultiSelectImageView *)multiSelectView
{
    if (!_multiSelectView) {
        _multiSelectView = [[DWDMultiSelectImageView alloc] init];
        _multiSelectView.frame = CGRectMake(0, 120 + ZGPadding + ZGPaddingMax, WLScreenW, 200);
        _multiSelectView.delegate = self;
    }
    return _multiSelectView;
}

- (NSMutableArray *)imageNames
{
    if (!_imageNames) {
        _imageNames = [NSMutableArray arrayWithCapacity:0];
    }
    return _imageNames;
}

- (NSMutableArray *)selectImages
{
    if (!_selectImages) {
        _selectImages = [NSMutableArray arrayWithCapacity:0];
    }
    return _selectImages;
}

- (NSMutableArray *)sourceImages
{
    if (!_sourceImages) {
        _sourceImages = [NSMutableArray arrayWithCapacity:0];
    }
    return _sourceImages;
}

- (NSMutableArray *)allImages
{
    if (!_allImages) {
        _allImages = [NSMutableArray arrayWithArray:self.sourceImages];
    }
    return _allImages;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 50;
    }else {
        return 300;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.section == 0) {
        
        [cell addSubview:self.titleTF];
    }else {
        [cell addSubview:self.contentTV];

        [cell addSubview:self.multiSelectView];
    }
    return cell;
}


- (void)multiSelectImageViewDidSelectAddButton:(DWDMultiSelectImageView *)multiSelectImageView {
    JFImagePickerController *picker = [[JFImagePickerController alloc] initWithRootViewController:self];
    picker.pickerDelegate = self;
    [self presentViewController:picker animated:YES completion:nil];
    
}

- (void)imagePickerDidFinished:(JFImagePickerController *)picker {
    
    [self.selectImages removeAllObjects];
    NSMutableArray *temp = [NSMutableArray arrayWithCapacity:6];
    
    for ( ALAsset *asset in picker.assets) {
        [[JFImageManager sharedManager] thumbWithAsset:asset resultHandler:^(UIImage *result) {
            [temp addObject:result];
        }];
        
        //获取资源图片的详细资源信息
        ALAssetRepresentation* representation = [asset defaultRepresentation];
        //获取资源图片的高清图
        UIImage *fullImage = [UIImage imageWithCGImage:[representation fullResolutionImage]];
        NSData *data = UIImageJPEGRepresentation(fullImage, 0.2);
        UIImage *thumbImage = [UIImage imageWithData:data];
        [self.selectImages addObject:thumbImage];
    }
    
    _allImages = [NSMutableArray arrayWithArray:self.sourceImages];
    [_allImages addObjectsFromArray:temp];
    
    [self.multiSelectView clearAllPhotos];
    self.multiSelectView.arrImages = _allImages;
    self.multiSelectView.height = self.multiSelectView.frame.size.height;
    [picker dismissViewControllerAnimated:YES completion:nil];
    [JFImagePickerController clear];
}

- (void)multiSelectImageViewDidDeleteImageAtIndex:(NSUInteger)index
{
    if (index <= self.sourceImages.count - 1 && self.sourceImages.count > 0) {
        [self.allImages removeObjectAtIndex:index];
        [self.sourceImages removeObjectAtIndex:index];
    }else {
        [self.allImages removeObjectAtIndex:index];
    }
    self.multiSelectView.arrImages = self.allImages;
}

- (void)imagePickerDidCancel:(JFImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.000001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *titleLbl = [[UILabel alloc] init];
    titleLbl.frame = CGRectMake(0, 0, WLScreenW, 40);
    titleLbl.font = [UIFont systemFontOfSize:14];
    titleLbl.textColor = COLOR_WORD_BLACK;
    
    if (section == 0) {
        titleLbl.text = @"    标题";
    }else {
        titleLbl.text = @"    内容";
    }
    return titleLbl;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    [_contentTV setNeedsDisplay];
    return YES;
}
@end
