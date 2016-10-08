//
//  WLLiveCourseDetailViewController.m
//  MyBoRuiSi
//
//  Created by Catskiy on 2016/9/29.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLLiveCourseDetailViewController.h"
#import "WLLookTableViewCell.h"
#import "WLSharetowViewController.h"
#import "WLorganVC.h"
#import "WLAuthorCell.h"
#import "WLCommetCell.h"
#import "WLPurchaseBottomView.h"
#import "WLHomeDataHandle.h"
#import "WLCourseDataHandle.h"
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

@end

@implementation WLLiveCourseDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setSubviews];
    
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
    
    WLPurchaseBottomView *bottomView = [[WLPurchaseBottomView alloc] initWithFrame:CGRectMake(0, WLScreenH - 64 - 50, WLScreenW, 50)];
    [self.view addSubview:bottomView];
    
    [self setNavigationBarStyleDefultWithTitle:@"课程详情"];
    
    //设置右边的按钮图片没有渲染
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageWithOriginalName:@"素彩网www.sc115.com-136"] style:UIBarButtonItemStyleDone target:self action:@selector(rightBtnAction:)];
}

- (void)requestData
{
    [WLCourseDataHandle requestCourseLiveDetailWithId:_courseId success:^(id responseObject) {
        
        _course = [WLCourceModel mj_objectWithKeyValues:responseObject[@"data"]];
        [_headerImgV sd_setImageWithURL:[NSURL URLWithString:_course.photo] placeholderImage:[UIImage imageNamed:@"photo_defult"]];
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
                     image:[UIImage imageNamed:@"组-5@2x_80"]
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
    
    share.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    
    [self presentViewController:share animated:YES completion:^{
    }];

}

- (void)collectBtnAction:(id)sender
{
    [WLCourseDataHandle requestCollectCourseWithCourseId:_courseId uid:[WLUserInfo share].userId success:^(id responseObject) {
        
        [MOProgressHUD showSuccessWithStatus:@"收藏成功"];
    } failure:^(NSError *error) {
        [MOProgressHUD showErrorWithStatus:error.localizedDescription];
    }];
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
        return [MOTool MOtextSizeH:_course.desc WithWidth:WLScreenW - 30 WithFount:[UIFont systemFontOfSize:14]] + 15 * 3 + 14;
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
            }
            cell.avatarImgV.image = PHOTO_AVATAR;
            cell.nameLbl.text = _course.author;
            cell.starView.showStar = 4.5 * 20;
            cell.starLbl.text = @"4.5分";
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
            
            cell.textLabel.text = _course.disPrice;
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
        
            cell.textLabel.text = [NSString stringWithFormat:@"发布 : %@",_course.author];
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
        CGFloat height = [MOTool MOtextSizeH:_course.desc WithWidth:WLScreenW - 30 WithFount:_introLbl.font];
        _introLbl.height = height;
        _introLbl.text = _course.desc;
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

@end
