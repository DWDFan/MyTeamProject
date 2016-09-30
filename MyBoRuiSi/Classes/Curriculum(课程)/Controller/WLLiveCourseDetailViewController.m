//
//  WLLiveCourseDetailViewController.m
//  MyBoRuiSi
//
//  Created by Catskiy on 2016/9/29.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLLiveCourseDetailViewController.h"
#import "WLLookTableViewCell.h"
#import "WLAuthorCell.h"
#import "WLCommetCell.h"
#import "WLPurchaseBottomView.h"
#import "WLHomeDataHandle.h"
#import "WLCommetCell.h"

@interface WLLiveCourseDetailViewController ()
{
    UILabel *_titleLbl;
    UILabel *_introLbl;
}
@property (nonatomic, strong) UIImageView *headerImgV;
@property (nonatomic, strong) WLCourceModel *course;

@end

@implementation WLLiveCourseDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setSubviews];
}

- (void)setSubviews
{
    self.tableViewStyle = UITableViewStyleGrouped;
    
    [self.view addSubview:self.tableView];
    
    _headerImgV = [[UIImageView alloc] init];
    _headerImgV.frame = CGRectMake(0, 0, WLScreenW, 150);
    _headerImgV.layer.masksToBounds = YES;
    _headerImgV.contentMode = UIViewContentModeScaleAspectFill;
    self.tableView.tableHeaderView = _headerImgV;
    
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
    [WLHomeDataHandle requestHomeClassDetailWithCourseId:_courseId success:^(id responseObject) {
        
        _course = [WLCourceModel mj_objectWithKeyValues:responseObject[@"data"]];
        [_headerImgV sd_setImageWithURL:[NSURL URLWithString:_course.photo] placeholderImage:[UIImage imageNamed:@"icon"]];
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)rightBtnAction:(id)sender
{
    
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
        return _course.comment.count;
    }
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
            cell.avatarImgV.image = [UIImage imageNamed:@"icon"];
            cell.starView.showStar = 4.5 * 20;
            return cell;
        }
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:normalCellId];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:normalCellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            cell.textLabel.textColor = COLOR_WORD_BLACK;
        }
        [[cell viewWithTag:666] removeFromSuperview];
        
        if (indexPath.row == 0) {
            
            cell.textLabel.text = @"iOS基础大讲堂";
            
        }else if (indexPath.row == 1) {
            
            cell.textLabel.text = @"￥640";
            cell.textLabel.font = [UIFont systemFontOfSize:16];
            cell.textLabel.textColor = KColorOrigin;
            [cell.textLabel sizeToFit];
            
            if (_course.disPrice.length > 0) {
                
                UILabel *disPricsLbl = [[UILabel alloc] init];
                disPricsLbl.frame = CGRectMake(cell.textLabel.x + ZGPaddingMax, cell.textLabel.y, 100, cell.textLabel.height);
                disPricsLbl.textColor = COLOR_WORD_GRAY_2;
                disPricsLbl.font = [UIFont systemFontOfSize:12];
                NSString *disPriStr = [NSString stringWithFormat:@"￥%@",@100];
                NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
                NSAttributedString *attStr = [[NSAttributedString alloc] initWithString:disPriStr attributes:attribtDic];
                disPricsLbl.attributedText = attStr;
                disPricsLbl.tag = 666;
                [cell addSubview:disPricsLbl];
            }
            
        }else if (indexPath.row == 2) {
        
            cell.textLabel.text = [NSString stringWithFormat:@"发布 : %@",@"云帆培训机构"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else if (indexPath.row == 3) {
        
            cell.textLabel.text = [NSString stringWithFormat:@"直播时间 : %@",@"2015-8-8 20:00-21:00"];
        }else if (indexPath.row == 4) {
            
            cell.textLabel.text = [NSString stringWithFormat:@"名额 : %@",@"20人（已报名18人）"];
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
            cell.textLabel.font = [UIFont systemFontOfSize:15];
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
            UILabel *introLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(_titleLbl.frame) + 15, 150, 12)];
            introLbl.font = [UIFont systemFontOfSize:12];
            introLbl.textColor = COLOR_WORD_GRAY_1;
            introLbl.numberOfLines = 0;
            [cell addSubview:introLbl];
            _introLbl = introLbl;
        }
        CGFloat height = [MOTool MOtextSizeH:_course.desc WithWidth:WLScreenW - 30 WithFount:_introLbl.font];
        _introLbl.height = height;
//        _introLbl.text = _course.desc;
        _introLbl.text = @"卡单方面靠大家疯狂的健身房";
        return cell;

    }else {
        
        WLCommetCell *cell = [tableView dequeueReusableCellWithIdentifier:commentCellId];
        if (!cell) {
            cell = [[WLCommetCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:commentCellId];
        }
        return cell;
    }
}

@end
