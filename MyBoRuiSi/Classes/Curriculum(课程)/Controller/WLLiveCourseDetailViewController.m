//
//  WLLiveCourseDetailViewController.m
//  MyBoRuiSi
//
//  Created by Catskiy on 2016/9/29.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLLiveCourseDetailViewController.h"
#import "ZGLivePlayerViewController.h"
#import "WLLookTableViewCell.h"
#import "WLSharetowViewController.h"
#import "WLOrderPayViewController.h"
#import "WLShoppingsTableViewController.h"

#import "WLorganVC.h"
#import "WLAuthorCell.h"
#import "WLCommetCell.h"
#import "WLPurchaseBottomView.h"
#import "WLHomeDataHandle.h"
#import "WLCourseDataHandle.h"
#import "WLOrderDataHandle.h"
#import "WLCommetCell.h"
#import "KxMenu.h"

@interface WLLiveCourseDetailViewController ()
{
    UILabel *_titleLbl;
    UILabel *_introLbl;
    UILabel *_disPriLbl;
    
}
@property (nonatomic, strong) UIImageView *headerImgV;
@property (nonatomic, strong) WLCourceModel *course;
@property (nonatomic, strong) WLPurchaseBottomView *purchaseView;
@property (nonatomic, strong) UIButton *joinBtn;

@property (nonatomic, assign) float amount;

@end

@implementation WLLiveCourseDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setSubviews];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self requestData];
}


- (void)setSubviews
{
    self.tableViewStyle = UITableViewStyleGrouped;
    
    [self.view addSubview:self.tableView];
    
    _headerImgV = [[UIImageView alloc] init];
    _headerImgV.frame = CGRectMake(0, 0, WLScreenW, 200);
    _headerImgV.layer.masksToBounds = YES;
    _headerImgV.contentMode = UIViewContentModeScaleAspectFill;
    self.tableView.tableHeaderView = _headerImgV;
    self.tableView.frame = CGRectMake(0, 0, WLScreenW, WLScreenH - 64 - 50);
    self.tableView.showsVerticalScrollIndicator = NO;
    
    WLLookTableViewCell *footer = [[[NSBundle mainBundle]loadNibNamed:@"WLLookTableViewCell" owner:nil options:nil]lastObject];
    footer.courseId = _courseId;
    footer.nvc = self.navigationController;
    self.tableView.tableFooterView = footer;
    
    WLPurchaseBottomView *bottomView = [[WLPurchaseBottomView alloc] initWithFrame:CGRectMake(0, WLScreenH - 64 - 50, WLScreenW, 50) style:WLPurchaseViewStyleLive];
    __weak typeof(self) weakSelf = self;
    
    [bottomView setBottomViewBLock:^(NSUInteger index) {
        if (![WLUserInfo share].isLogin) {
            [self alertLogin];
            return ;
        }
        switch (index) {
            case 1000:
                //request 加入购物车
                [weakSelf requestJoinShopCarWithGoodId:weakSelf.courseId];
                break;
            case 1002:
                // 立即购买
                [weakSelf requestBuyWithGoodId:weakSelf.courseId];
                break;
            case 1003:
                [weakSelf joinCourse];
                break;
            default:
                break;
        }
    }];
    [self.view addSubview:bottomView];
    _purchaseView = bottomView;
    
//    if (_isMine) {
//        UIButton *joinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        joinBtn.frame = CGRectMake(0, WLScreenH - 64 - 50, WLScreenW, 50);
//        [joinBtn setBackgroundColor:[UIColor lightGrayColor]];
//        [joinBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [joinBtn addTarget:self action:@selector(joinBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//        joinBtn.titleLabel.font = [UIFont systemFontOfSize:16];
//        joinBtn.enabled = NO;
//        [self.view addSubview:joinBtn];
//        _joinBtn = joinBtn;
//        _purchaseView.hidden = YES;
//    }
    
    [self setNavigationBarStyleDefultWithTitle:@"课程详情"];
    
    //设置右边的按钮图片没有渲染
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageWithOriginalName:@"素彩网www.sc115.com-136"] style:UIBarButtonItemStyleDone target:self action:@selector(rightBtnAction:)];
}

// 进入直播
- (void)joinCourse
{
    NSMutableArray *decodeParm = [[NSMutableArray alloc] init];
    [decodeParm addObject:@"software"];
    [decodeParm addObject:@"livestream"];
    NSString *urlStr = [MOTool getNULLString:_course.v2];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    ZGLivePlayerViewController *playerVC = [[ZGLivePlayerViewController alloc] initWithURL:url andDecodeParm:decodeParm];
    playerVC.courseId = _courseId;
    [self.navigationController pushViewController:playerVC animated:YES];
}

- (void)requestData
{
    [WLCourseDataHandle requestCourseLiveDetailWithId:_courseId success:^(id responseObject) {
        
        _course = [WLCourceModel mj_objectWithKeyValues:responseObject[@"data"]];
        [_headerImgV sd_setImageWithURL:[NSURL URLWithString:_course.photo] placeholderImage:[UIImage imageNamed:@"photo_defult"]];
        _purchaseView.canplay = _course.canBuy;
        
//        // 直播按钮
//        if ([_course.zbStatus integerValue] == 0) {
//            [_joinBtn setTitle:@"未开始" forState:UIControlStateNormal];
//        }else if([_course.zbStatus integerValue] == 1) {
//            [_joinBtn setTitle:@"进入直播" forState:UIControlStateNormal];
//            [_joinBtn setBackgroundColor:color_red];
//            _joinBtn.enabled = YES;
//        }else {
//            [_joinBtn setTitle:@"已结束" forState:UIControlStateNormal];
//        }
        
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

- (void)rightBtnAction:(id)sender
{
    NSArray *menuItems =
    @[[KxMenuItem menuItem:@"分享"
                     image:[UIImage imageNamed:@"图层-48346"]
                    target:self
                    action:@selector(shareBtnAction:)],
      
      [KxMenuItem menuItem:@"收藏"
                     image:[UIImage imageNamed:@"icon_collect_select"]
                    target:self
                    action:@selector(collectBtnAction:)]];
    
    KxMenuItem *first = menuItems[0];
    first.foreColor = [UIColor colorWithRed:136/255.0f green:136/255.0f blue:136/255.0f alpha:1.0];
    first.alignment = NSTextAlignmentCenter;
    [KxMenu showMenuInView:self.view
                  fromRect:CGRectMake(WLScreenW - 50, -40, 40, 40)
                 menuItems:menuItems];
    
}

- (void)shareBtnAction:(id)sender
{
    WLSharetowViewController *share = [[WLSharetowViewController alloc]init];
    
    share.shareTitle = _course.name;
    share.descStr = _course.desc;
    share.imageUrl = _course.photo;
    share.webpageUrl = [NSString stringWithFormat:@"http://brs.che1988.com/zbdetails?id=%@",self.courseId];
    
    share.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    
    [self presentViewController:share animated:YES completion:^{
    }];
    
}

- (void)collectBtnAction:(id)sender
{
    if (![WLUserInfo share].isLogin) {
        [self alertLogin];
        return ;
    }

    [WLCourseDataHandle requestCollectCourseWithCourseId:_courseId uid:[WLUserInfo share].userId success:^(id responseObject) {
        
        [MOProgressHUD showSuccessWithStatus:@"收藏成功"];
    } failure:^(NSError *error) {
        [MOProgressHUD showErrorWithStatus:error.userInfo[@"msg"]];
    }];
}

- (void)alertLogin
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"您需要登陆后才能进行操作！" delegate:self cancelButtonTitle:@"暂不登录" otherButtonTitles:@"去登陆", nil];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [MOTool pushLoginViewControllerWithController:self];
    }else if(alertView.tag == 1000) {
        // 前往结算
//        self.navigationController.tabBarController.selectedIndex = 3;
//        UINavigationController *nav = self.navigationController.tabBarController.childViewControllers[3];
//        WLShoppingsTableViewController *vc = [[WLShoppingsTableViewController alloc]init];
//        vc.selectedIndex = 1;
//        [nav pushViewController:vc animated:YES];
    }

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 7;
    }else if (section == 1) {
        return 1;
    }else {
        return _course.comment.count + 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
//        return [MOTool MOtextSizeH:_course.desc WithWidth:WLScreenW - 30 WithFount:[UIFont systemFontOfSize:14]] + 15 * 3 + 14;
        NSMutableAttributedString *htmlString =[[NSMutableAttributedString alloc] initWithData:[_course.desc dataUsingEncoding:NSUTF8StringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute:[NSNumber numberWithInt:NSUTF8StringEncoding]} documentAttributes:NULL error:nil];
        
        [htmlString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} range:NSMakeRange(0, htmlString.length)];
        
        CGSize textSize = [htmlString boundingRectWithSize:(CGSize){WLScreenW - 30, CGFLOAT_MAX} options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        
        return textSize.height + 15 * 3 + 14;
        
    }else if (indexPath.section == 2 && indexPath.row != 0) {
        return [MOTool MOtextSizeH:[_course.comment[indexPath.row - 1] msg] WithWidth:WLScreenW - 30 WithFount:[UIFont systemFontOfSize:12]] + 15 * 3 + 12;
    }else if (indexPath.section == 0 && indexPath.row == 6) {
        return 100;
    }
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *normalCellId = @"normalCell";
    static NSString *authorCellId = @"authorCell";
    static NSString *commentCellId = @"commentCell";
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 6) {
            
            WLAuthorCell *cell = [tableView dequeueReusableCellWithIdentifier:authorCellId];
            if (!cell) {
                cell = [[WLAuthorCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:authorCellId];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            WLAuthorModel *author = _course.other;
            [cell.avatarImgV sd_setImageWithURL:[NSURL URLWithString:author.photo] placeholderImage:PHOTO_PLACE];
            cell.nameLbl.text = author.nickname;
            cell.star = [author.star floatValue] * 20;
            cell.starLbl.text = [NSString stringWithFormat:@"%@分",author.star];
            return cell;
        }
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:normalCellId];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:normalCellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.textLabel.textColor = COLOR_WORD_BLACK;
        }
        [[cell viewWithTag:666] removeFromSuperview];
        
        if (indexPath.row == 0) {
            
            cell.textLabel.text = _course.name;
            
        }else if (indexPath.row == 1) {
            
            cell.textLabel.text = [NSString stringWithFormat:@"￥%@",[MOTool getNULLString:_course.disPrice]];
            cell.textLabel.font = [UIFont systemFontOfSize:16];
            cell.textLabel.textColor = KColorOrigin;
            [cell.textLabel sizeToFit];
            
            if (_course.disPrice && _course.price && !_disPriLbl) {
                
                NSString *priceStr = [NSString stringWithFormat:@"￥%@",[MOTool getNULLString:_course.price]];
                NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
                NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:priceStr attributes:attribtDic];
                
                UILabel *disPriLbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(cell.textLabel.frame) + 20, 15, 150, 14)];
                disPriLbl.font = [UIFont systemFontOfSize:12];
                disPriLbl.textColor = [UIColor grayColor];
                disPriLbl.attributedText = attStr;
                [disPriLbl sizeToFit];
                [cell addSubview:disPriLbl];
                _disPriLbl = disPriLbl;
            }
            
        }else if (indexPath.row == 2) {
            
            cell.textLabel.text = [NSString stringWithFormat:@"发布 : %@",_course.aname];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else if (indexPath.row == 3) {
            
            cell.textLabel.text = [NSString stringWithFormat:@"直播时间 : %@",_course.zhibotm];
        }else if (indexPath.row == 4) {
            
            cell.textLabel.text = [NSString stringWithFormat:@"名额 : %@人（已报名%@人）",_course.limit,_course.bm];
        }else if (indexPath.row == 5) {
            
            cell.textLabel.text = @"其他课程";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        return cell;
    }else if (indexPath.section == 1) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:normalCellId];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:normalCellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.textLabel.textColor = COLOR_WORD_BLACK;
        }
        
        if (!_titleLbl) {
            UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 150, 14)];
            titleLbl.font = [UIFont systemFontOfSize:14];
            titleLbl.textColor = COLOR_WORD_BLACK;
            titleLbl.text = @"课程介绍";
            [cell addSubview:titleLbl];
            _titleLbl = titleLbl;
        }
        if (!_introLbl) {
            UILabel *introLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(_titleLbl.frame) + 15, WLScreenW - 30, 12)];
            introLbl.font = [UIFont systemFontOfSize:12];
            introLbl.textColor = COLOR_WORD_GRAY_1;
            introLbl.numberOfLines = 0;
            [cell addSubview:introLbl];
            _introLbl = introLbl;
        }
        
        NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[_course.desc dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        
        
        NSMutableAttributedString *htmlString =[[NSMutableAttributedString alloc] initWithData:[_course.desc dataUsingEncoding:NSUTF8StringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute:[NSNumber numberWithInt:NSUTF8StringEncoding]} documentAttributes:NULL error:nil];
        
        [htmlString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} range:NSMakeRange(0, htmlString.length)];
        
        CGSize textSize = [htmlString boundingRectWithSize:(CGSize){WLScreenW - 30, CGFLOAT_MAX} options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        
        _introLbl.height = textSize.height;
        _introLbl.attributedText = attributedString;
        return cell;
        
    }else {
        
        if (indexPath.row == 0) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:normalCellId];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:normalCellId];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.textLabel.font = [UIFont systemFontOfSize:14];
                cell.textLabel.textColor = COLOR_WORD_BLACK;
            }
            cell.textLabel.text = [NSString stringWithFormat:@"评价(%@)",[MOTool getNULLString:_course.cmtNum]];
            return cell;
        }else {
            WLCommetCell *cell = [tableView dequeueReusableCellWithIdentifier:commentCellId];
            if (!cell) {
                cell = [[WLCommetCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:commentCellId];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.comment = self.course.comment[indexPath.row - 1];
            return cell;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return section == 2 ? 0.000001 : 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.000001;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 2) {
            WLorganVC *vc = [[WLorganVC alloc]init];
            vc.institutionId = _course.author;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

#pragma mark - Request
- (void)requestJoinShopCarWithGoodId:(NSString *)goodId{
    [MOProgressHUD show];
    [WLOrderDataHandle requestAddCartWithUid:[WLUserInfo share].userId goodid:goodId success:^(id responseObject) {
        NSDictionary *dict = responseObject;
        if ([dict[@"code"]integerValue] == 1) {
            [MOProgressHUD showSuccessWithStatus:@"加入成功"];
        }else{
            [MOProgressHUD showErrorWithStatus:dict[@"msg"]];
        }
    } failure:^(NSError *error) {
        [MOProgressHUD showErrorWithStatus:error.userInfo[@"msg"]];
    }];
}

/** 立即购买 */
- (void)requestBuyWithGoodId:(NSString *)goodId{
  
    
    [WLCourseDataHandle requestCourseLiveDetailWithId:_courseId success:^(id responseObject) {
        
        _course = [WLCourceModel mj_objectWithKeyValues:responseObject[@"data"]];
        
        if (self.course.vipFree && [WLUserInfo share].vip) {
            self.amount = 0;
        }else{
            self.amount = self.course.disPrice ? [self.course.disPrice floatValue] : [self.course.price floatValue];
        }
        
        [WLOrderDataHandle requestAddCartWithUid:[WLUserInfo share].userId goodid:goodId success:^(id responseObject) {
            NSDictionary *dict = responseObject;
            NSString *Gid = dict[@"data"];//data 字段是购物ID
            if ([dict[@"code"]integerValue] == 1) {
                //加入订单
                [WLOrderDataHandle requestCommitOrderWithUid:[WLUserInfo share].userId cid:Gid type:@"kecheng" jifen:nil  success:^(id responseObject) {
                    NSDictionary *dict = responseObject;
                    if ([dict[@"code"]integerValue] == 1) {
                        //支付界面
                        NSDictionary *dict = responseObject;
                        if ([dict[@"code"]integerValue] == 1) {
                            WLOrderPayViewController *vc = [[WLOrderPayViewController alloc]init];
                            vc.amountStr = [NSString stringWithFormat:@"%.2f",self.amount];
                            vc.needMoney = self.amount;
                            vc.orderId = dict[@"id"];
                            vc.type = orderPayType;
                            [self.navigationController pushViewController:vc animated:YES];
                            
                        }else{
                            [MOProgressHUD showErrorWithStatus:dict[@"msg"]];
                        }
                        
                    }else{
                        [MOProgressHUD showErrorWithStatus:dict[@"msg"]];
                    }
                } failure:^(NSError *error) {
                    [MOProgressHUD showErrorWithStatus:error.userInfo[@"msg"]];
                }];
                
            }else{
                [MOProgressHUD showErrorWithStatus:@"购买失败"];
            }
        } failure:^(NSError *error) {
            NSString *msg = error.userInfo[@"msg"];
            //你已经加入购物车了
            if ([msg isEqualToString:@"你已经加入购物车了"]) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                    message:@"你已经加入过购物车了，前往\"我的订单\"->\"待付款\"，结算后即可学习"
                                                                   delegate:self
                                                          cancelButtonTitle:@"确定"
                                                          otherButtonTitles:nil, nil];
                alertView.tag = 1000;
                [alertView show];
            }else {
                [MOProgressHUD showErrorWithStatus:msg];
            }
        }];

        
    } failure:^(NSError *error) {
        
    }];
    
}
@end
