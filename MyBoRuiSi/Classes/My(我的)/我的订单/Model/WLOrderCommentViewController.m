//
//  WLOrderCommentViewController.m
//  MyBoRuiSi
//
//  Created by Magician on 2017/1/9.
//  Copyright © 2017年 itcast.com. All rights reserved.
//

#import "WLOrderCommentViewController.h"
#import "StarGradeView.h"
#import "UIPlaceHolderTextView.h"
#import "WLOrderDataHandle.h"

@interface WLOrderCommentViewController ()<StarGradeViewDelegate>

@property (nonatomic, strong) NSString *star;
@property (nonatomic, strong) UIPlaceHolderTextView *commentTF;

@end

@implementation WLOrderCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self configureUI];
}

- (void)configureUI
{
    self.view.backgroundColor = kColor_backgroud;
    
    [self setNavigationBarStyleDefultWithTitle:@"评价"];
    
    [self.rightBtn setTitle:@"提交" forState:UIControlStateNormal];
    [self.rightBtn setTitleColor:kColor_button_bg forState:UIControlStateNormal];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WLScreenW, kAdaptedHeight(150))];
    headerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headerView];
    
    StarGradeView *starView = [[StarGradeView alloc] initWithFrame:CGRectMake(0, 40, [UIScreen mainScreen].bounds.size.width, 40) withtNumberOfPart:5];
    starView.delegate = self;
    [headerView addSubview:starView];
    
    UILabel *tipLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, starView.bottom + 30, WLScreenW - 40, 12)];
    tipLbl.textAlignment = NSTextAlignmentCenter;
    tipLbl.textColor = COLOR_WORD_BLACK;
    tipLbl.font = [UIFont systemFontOfSize:12];
    tipLbl.text = @"请滑动星星评分";
    [headerView addSubview:tipLbl];
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, headerView.bottom + 10, WLScreenW, 100)];
    footerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:footerView];
    
    self.commentTF = [[UIPlaceHolderTextView alloc] initWithFrame:CGRectMake(10, headerView.bottom + 10, WLScreenW - 20, 100)];
    self.commentTF.backgroundColor = [UIColor whiteColor];
    self.commentTF.placeholder = @"亲，您的评价对其他买家有很大帮助~~";
    self.commentTF.textColor = COLOR_WORD_GRAY_1;
    self.commentTF.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:self.commentTF];
}

- (void)didSelectedIndex:(NSString *)index{
    
    self.star = [NSString stringWithFormat:@"%ld",[index integerValue]];
}

- (void)rightBtnAction:(id)sender
{
    if (self.commentTF.text.length == 0) {
        [MOProgressHUD showErrorWithStatus:@"您还没有输入评价哦~~"];
        return;
    }
    [MOProgressHUD showWithStatus:@"正在提交..."];
    [WLOrderDataHandle requestOrderComment:[WLUserInfo share].userId
                                       oid:self.orderId
                                       msg:self.commentTF.text
                                      star:self.star
                                   success:^(id responseObject) {
                                       
        [MOProgressHUD showSuccessWithStatus:@"评论成功！"];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        [MOProgressHUD showErrorWithStatus:error.userInfo[@"msg"]];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
