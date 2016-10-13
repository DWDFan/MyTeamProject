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

#define imageW (WLScreenW - 30 - 40)/5

@interface WLIssueArticleViewController ()<UITextViewDelegate>

@property (nonatomic, strong) UITextField *titleTF;
@property (nonatomic, strong) ZGPlaceHolderTextView *contentTV;
@property (nonatomic, strong) SZAddImage *addPhotoView;
@property (nonatomic , strong) NSMutableArray *arrSelectImgs;
@property (nonatomic , strong) NSMutableArray *imageNames;

@end

@implementation WLIssueArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setSubviews];
}

- (void)setSubviews
{
    [self setNavigationBarStyleDefultWithTitle:@"发帖"];
    
    [self.rightBtn setTitle:@"发布" forState:UIControlStateNormal];
    [self.rightBtn setTitleColor:color_red forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightBtn];
    
    self.tableViewStyle = UITableViewStyleGrouped;
    self.tableView.scrollEnabled = NO;
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
    self.arrSelectImgs = _addPhotoView.images;
    
    [self.imageNames removeAllObjects];
    
    [MOProgressHUD showWithStatus:@"正在上传图片..."];
    
    for (int i = 0; i < self.arrSelectImgs.count; i ++) {
        
        NSData *fileData = UIImageJPEGRepresentation(self.arrSelectImgs[i], 0.2);
        [WLFindDataHandle requestUploatPhotoWithFiledata:fileData uid:[WLUserInfo share].userId success:^(id responseObject) {
            
            [MOProgressHUD showSuccessWithStatus:@"上传成功"];
            [self.imageNames addObject:responseObject[@"link"]];
            if (self.imageNames.count == self.arrSelectImgs.count) {
                [self issueArticleData];
            }
        } failure:^(NSError *error) {
            [MOProgressHUD showErrorWithStatus:@"上传失败"];
        }];
    }
    
}

- (void)issueArticleData
{
    NSString *pics = self.imageNames[0];
    for (int i = 1; i < self.imageNames.count; i ++) {
        
        pics = [pics stringByAppendingString:@"|"];
        pics = [pics stringByAppendingString:self.imageNames[i]];
    }
    
    [WLFindDataHandle requestFindArticleIssueWithQid:_circleId uid:[WLUserInfo share].userId title:_titleTF.text content:_contentTV.text pics:pics success:^(id responseObject) {
        
        [MOProgressHUD showSuccessWithStatus:@"发布成功"];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        [MOProgressHUD showErrorWithStatus:error.userInfo[@"msg"]];
    }];
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

- (NSMutableArray *)imageNames
{
    if (!_imageNames) {
        _imageNames = [NSMutableArray arrayWithCapacity:0];
    }
    return _imageNames;
}

- (NSMutableArray *)arrSelectImgs
{
    if (!_arrSelectImgs) {
        _arrSelectImgs = [NSMutableArray arrayWithCapacity:0];
    }
    return _arrSelectImgs;
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
        
        _addPhotoView = [[SZAddImage alloc] initWithFrame:CGRectMake(0, self.contentTV.bottom + ZGPaddingMax, WLScreenW, 200)];
        [cell addSubview:_addPhotoView];
    }
    return cell;
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
