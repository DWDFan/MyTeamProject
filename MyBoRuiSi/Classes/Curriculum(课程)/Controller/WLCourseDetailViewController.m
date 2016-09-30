//
//  WLCourseDetailViewController.m
//  MyBoRuiSi
//
//  Created by Catskiy on 16/9/23.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLCourseDetailViewController.h"
#import "WLSharetowViewController.h"
#import "WLCourceOutlineVIewController.h"
#import "WLDgViewController.h"
#import "WLorganVC.h"
#import "WLLookTableViewCell.h"
#import "WLCommetCell.h"
#import "WLPurchaseBottomView.h"
#import "WLHomeDataHandle.h"
#import "WLCourceModel.h"
#import "KxMenu.h"

#import "WLOrderDataHandle.h"

@interface WLCourseDetailViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *headerImgV;
@property (nonatomic, strong) WLCourceModel *course;
@property (nonatomic, weak) UILabel *titleLbl;
@property (nonatomic, weak) UILabel *introLbl;
@property (nonatomic, weak) UILabel *disPriLbl;
@property (nonatomic, weak) UIButton *menberBtn;


@end

@implementation WLCourseDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setSubviews];
    
    [self requestData];
}

- (void)setSubviews
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WLScreenW, WLScreenH - 64 - 50) style:UITableViewStyleGrouped];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _headerImgV = [[UIImageView alloc] init];
    _headerImgV.frame = CGRectMake(0, 0, WLScreenW, 200);
    _headerImgV.layer.masksToBounds = YES;
    _headerImgV.contentMode = UIViewContentModeScaleAspectFill;
    _tableView.tableHeaderView = _headerImgV;
    
    WLLookTableViewCell *footer = [[[NSBundle mainBundle]loadNibNamed:@"WLLookTableViewCell" owner:nil options:nil]lastObject];
    footer.courseId = _courseId;
    footer.nvc = self.navigationController;
    _tableView.tableFooterView = footer;
    
    WLPurchaseBottomView *bottomView = [[WLPurchaseBottomView alloc] initWithFrame:CGRectMake(0, WLScreenH - 64 - 50, WLScreenW, 50)];
    __weak typeof(self) weakSelf = self;
    bottomView.joinShopCarBlock = ^(){
        //request 加入购物车
        [weakSelf requestJoinShopCarWithGoodId:weakSelf.courseId];
    };
    [self.view addSubview:bottomView];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
    btn.backgroundColor = [UIColor clearColor];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setImage:[UIImage imageNamed:@"图层-47"] forState:UIControlStateNormal];
    [btn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
    [btn setTitle:@"课程详情" forState:UIControlStateNormal];
    self.navigationItem.titleView = btn;
    
    [self.navigationController.navigationBar setBackgroundImage:[MOTool createImageWithColor:RGBA(255, 255, 255, 1)] forBarMetrics:UIBarMetricsDefault];
    
    //设置右边的按钮图片没有渲染
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageWithOriginalName:@"素彩网www.sc115.com-136"] style:UIBarButtonItemStyleDone target:self action:@selector(nav_w_add_prer)];
}

- (void)requestData
{
    [WLHomeDataHandle requestHomeClassDetailWithCourseId:_courseId success:^(id responseObject) {
        
        _course = [WLCourceModel mj_objectWithKeyValues:responseObject[@"data"]];
        [_headerImgV sd_setImageWithURL:[NSURL URLWithString:_course.photo] placeholderImage:[UIImage imageNamed:@"icon"]];
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}

//设置右边的按钮
-(void)nav_w_add_prer{
    
    //右边 + 号弹出的控制器
    
    NSArray *menuItems =
    @[[KxMenuItem menuItem:@"分享"
                     image:[UIImage imageNamed:@"图层-48346"]
                    target:self
                    action:@selector(btn_chat:)],
      
      [KxMenuItem menuItem:@"收藏"
                     image:[UIImage imageNamed:@"组-5@2x_80"]
                    target:self
                    action:@selector(btn_addf:)]];
    
    KxMenuItem *first = menuItems[0];
    first.foreColor = [UIColor colorWithRed:136/255.0f green:136/255.0f blue:136/255.0f alpha:1.0];
    first.alignment = NSTextAlignmentCenter;
    [KxMenu showMenuInView:self.view
                  fromRect:CGRectMake(WLScreenW - 50, -40, 40, 40)
                 menuItems:menuItems];
}

//分享
- (void)btn_chat:(id)sender{
    
    
    
    WLSharetowViewController *share = [[WLSharetowViewController alloc]init];
    
    //
    //    [share dismissViewControllerAnimated:YES completion:^{
    //
    //    }];
    
    share.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    
    [self presentViewController:share animated:YES completion:^{
        // NSLog(@"展示完毕");
    }];
    
}
////点击屏幕退出
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)btn_addf:(id)sender{
    
}

#pragma mark - tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row = 1;
    if (section == 0) {
        row = 4;
    }else if (section == 3) {
        row = _course.comment.count + 1;
    }else if (section == 2) {
        row = 2;
    }
    return row;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        return [MOTool MOtextSizeH:_course.desc WithWidth:WLScreenW - 30 WithFount:[UIFont systemFontOfSize:14]] + 15 * 3 + 14;
    }else if (indexPath.section == 3 && indexPath.row != 0) {
        return [MOTool MOtextSizeH:[_course.comment[indexPath.row - 1] msg] WithWidth:WLScreenW - 30 WithFount:[UIFont systemFontOfSize:12]] + 15 * 3 + 12;
    }
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 3) {
        
        if (indexPath.row == 0) {
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
            cell.textLabel.text = [NSString stringWithFormat:@"评价(%@)",[MOTool getNULLString:_course.cmtNum]];
            cell.textLabel.textColor = COLOR_WORD_BLACK;
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            return cell;
        }
        
        NSString *ID = [NSString stringWithFormat:@"commentCell"];
        WLCommetCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell = [[WLCommetCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.comment = _course.comment[indexPath.row - 1];
        return cell;
        
    }else {
        
        NSString *ID = [NSString stringWithFormat:@"%ld%ldcell",indexPath.section,indexPath.row];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.textLabel.textColor = COLOR_WORD_BLACK;
        }
        
        if (indexPath.section == 0) {
            
            if (indexPath.row == 0) {
                cell.textLabel.text = _course.name;
            }else if (indexPath.row == 1) {
                
                NSString *priceStr = [NSString stringWithFormat:@"优惠价 : ￥%@",[MOTool getNULLString:_course.price]];
                NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:priceStr];
                [attStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, 6)];
                [attStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(6, attStr.length - 6)];
                cell.textLabel.attributedText = attStr;
                cell.textLabel.textColor = KColorOrigin;
                [cell.textLabel sizeToFit];
                
                if (_course.disPrice && !_disPriLbl) {
                    
                    NSString *priceStr = [NSString stringWithFormat:@"￥%@",[MOTool getNULLString:_course.disPrice]];
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
                
                if (!_menberBtn) {
                    UIButton *menberBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                    menberBtn.frame = CGRectMake(0, 10, 60, 24);
                    menberBtn.backgroundColor = KColorPink;
                    menberBtn.layer.cornerRadius = 4.0;
                    menberBtn.layer.borderWidth = 0.5;
                    menberBtn.layer.borderColor = KColorOrigin.CGColor;
                    menberBtn.titleLabel.font = [UIFont systemFontOfSize:12];
                    [menberBtn setTitle:@"会员免费" forState:UIControlStateNormal];
                    [menberBtn setTitleColor:color_red forState:UIControlStateNormal];
                    menberBtn.tag = 1000;
                    //            [menberBtn addTarget:self action:@selector(<#selector#>) forControlEvents:UIControlEventTouchUpInside];
                    menberBtn.hidden = YES;
                    [cell addSubview:menberBtn];
                    _menberBtn = menberBtn;
                }
                _menberBtn.x = _disPriLbl ? _disPriLbl.x + _disPriLbl.width + 15: cell.textLabel.x + cell.textLabel.width + 15;
                if (_course.vipFree) {
                    _menberBtn.hidden = NO;
                }
                
            }else if (indexPath.row == 2) {
                cell.textLabel.text = [NSString stringWithFormat:@"有效期 : %@个月",[MOTool getNULLString:_course.period]];
            }else {
                cell.textLabel.text = [NSString stringWithFormat:@"发布 : %@",[MOTool getNULLString:_course.author]];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            
        }else if(indexPath.section == 1) {
            
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
            
        }else {
            
            if (indexPath.row == 0) {
                cell.textLabel.text = @"教学大纲";
            }else {
                cell.textLabel.text = @"相关课件";
            }
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return section == 3 ? 0.000001 : 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.000001;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        
        if (indexPath.row == 0) {   // 课程大纲
            WLCourceOutlineVIewController *VC = [[WLCourceOutlineVIewController alloc] init];
            VC.courseId = _courseId;
            [self.navigationController pushViewController:VC animated:YES];
            
        }else {                     // 相关课件
            
        }
    }else if (indexPath.row == 3) { // 机构详情
        WLorganVC *vc = [[WLorganVC alloc]init];
        vc.institutionId = _course.author;
        [self.navigationController pushViewController:vc animated:YES];
    }
}


#pragma mark - Request
- (void)requestJoinShopCarWithGoodId:(NSString *)goodId{
    [MOProgressHUD show];
    [WLOrderDataHandle requestAddCartWithUid:[WLUserInfo share].userId goodid:goodId success:^(id responseObject) {
        NSDictionary *dict = responseObject;
        if ([dict[@"code"]integerValue] == 1) {
            [MOProgressHUD showSuccessWithStatus:@"加入成功"];
            [MOProgressHUD dismissWithDelay:1];
        }else{
            [MOProgressHUD showErrorWithStatus:dict[@"msg"]];
            [MOProgressHUD dismissWithDelay:1];
        }
    } failure:^(NSError *error) {
        [MOProgressHUD showErrorWithStatus:error.userInfo[@"msg"]];
        [MOProgressHUD dismissWithDelay:1];
    }];
}


@end
