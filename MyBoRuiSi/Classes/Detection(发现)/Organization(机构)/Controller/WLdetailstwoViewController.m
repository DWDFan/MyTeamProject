//
//  WLdetailstwoViewController.m
//  MyBoRuiSi
//
//  Created by wsl on 16/8/4.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLdetailstwoViewController.h"

#import "UIImage+Image.h"
#import "KxMenu.h"

#import "WLSharetowViewController.h"
#import "WLLookTableViewCell.h"

#import "WLorganVC.h"
#import "WLDgViewController.h"
#import "WLHomeDataHandle.h"
#import "WLCourseDataHandle.h"
#import "WLCourceModel.h"

@interface WLdetailstwoViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tables_mian;
@property (nonatomic, strong) UIImageView *headerImgV;
@property (nonatomic, strong) WLCourceModel *course;

@end

@implementation WLdetailstwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _headerImgV = [[UIImageView alloc] init];
    _headerImgV.frame = CGRectMake(0, 0, WLScreenW, 200);
    _headerImgV.layer.masksToBounds = YES;
    _headerImgV.contentMode = UIViewContentModeScaleAspectFill;
    self.tables_mian.tableHeaderView = _headerImgV;
    
    //设置在尾部
    WLLookTableViewCell *footer = [[[NSBundle mainBundle]loadNibNamed:@"WLLookTableViewCell" owner:nil options:nil]lastObject];
    footer.nvc = self.navigationController;
    self.tables_mian.tableFooterView = footer;
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
    btn.backgroundColor = [UIColor clearColor];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setImage:[UIImage imageNamed:@"图层-47"] forState:UIControlStateNormal];
    [btn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
    [btn setTitle:@"课程详情" forState:UIControlStateNormal];
    self.navigationItem.titleView = btn;
    
    [self.navigationController.navigationBar setBackgroundImage:[self createImageWithColor:RGBA(255, 255, 255, 1)] forBarMetrics:UIBarMetricsDefault];
    
//    //设置右边的按钮图片没有渲染
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageWithOriginalName:@"素彩网www.sc115.com-136"] style:UIBarButtonItemStyleDone target:self action:@selector(nav_w_add_prer)];
    
    [self requestData];
}

- (void)requestData
{
    [WLHomeDataHandle requestHomeClassDetailWithCourseId:self.courseId success:^(id responseObject) {
        
        _course = [WLCourceModel mj_objectWithKeyValues:responseObject[@"data"]];
        [_headerImgV sd_setImageWithURL:[NSURL URLWithString:_course.photo] placeholderImage:[UIImage imageNamed:@"photo_defult"]];
        [self.tables_mian reloadData];

    } failure:^(NSError *error) {
        WLLog(@"%@",error);
    }];
}
//颜色转图片
- (UIImage*) createImageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage*theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
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

/**
 *  收藏
 *
 */
- (void)btn_addf:(id)sender{
    
   
}

//MARK:tableView代理方法----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSUInteger row = 0;
    if (section == 0) {
        row = 4;
    }if (section == 1) {
        row = 1;
    }if (section == 2) {
        row = 1;
    }if (section == 3) {
        row = 1;
    }if (section == 4) {
        row = [_course.comment count];
    }
    return row;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"normalCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    [[cell viewWithTag:1000] removeFromSuperview];
    
    if (indexPath.section == 0) {
        
       
        
        if (indexPath.row == 0) {
            
            cell.textLabel.text = _course.name;
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }if (indexPath.row == 1) {
            
            NSString *priceStr = [NSString stringWithFormat:@"优惠价 : ￥%@",[MOTool getNULLString:_course.disPrice]];
            NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:priceStr];
            [attStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, 6)];
            [attStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(6, attStr.length - 6)];
            cell.textLabel.attributedText = attStr;
            cell.textLabel.textColor = KColorOrigin;
            [cell.textLabel sizeToFit];
            
            UIButton *menberBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            menberBtn.frame = CGRectMake(cell.textLabel.x + cell.textLabel.width + 20, 10, 60, 24);
            menberBtn.backgroundColor = KColorPink;
            menberBtn.layer.cornerRadius = 4.0;
            menberBtn.layer.borderWidth = 0.5;
            menberBtn.layer.borderColor = KColorOrigin.CGColor;
            menberBtn.titleLabel.font = [UIFont systemFontOfSize:12];
            [menberBtn setTitle:@"会员免费" forState:UIControlStateNormal];
            [menberBtn setTitleColor:color_red forState:UIControlStateNormal];
            menberBtn.tag = 1000;
            //            [menberBtn addTarget:self action:@selector(<#selector#>) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:menberBtn];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }if (indexPath.row == 2) {
            
            cell.textLabel.text = [NSString stringWithFormat:@"发布:%@",_course.author];
            //cell的最右边添加图片
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
    }else if(indexPath.section == 1) {
        
            UILabel *label_title = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, WLScreenW-15, 44)];
            label_title.text = @"详情介绍";
            [cell addSubview:label_title];
            
            UITextView *label_text = [[UITextView alloc]initWithFrame:CGRectMake(15,CGRectGetMaxY(label_title.frame)+5 , WLScreenW-15, 250-44-5)];
            label_text.text = _course.desc;
            label_text.editable = NO;
            label_text.font = [UIFont systemFontOfSize:17];
            [cell addSubview:label_text];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }else if(indexPath.section == 2){
        cell.textLabel.text = @"教学大纲";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else if (indexPath.section == 3){
            cell.textLabel.text = [NSString stringWithFormat:@"评价 (%@)",_course.cmtNum];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;;
    }else if (indexPath.section == 4){
            
            UILabel *label_title = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, WLScreenW-15, 44)];
            UILabel *label_titles = [[UILabel alloc]initWithFrame:CGRectMake(200,0, WLScreenW -15, 44)];
            label_title.text = @"张三";
            label_titles.text = @"2016-05-05  12:00";
            label_titles.font = [UIFont systemFontOfSize:13];
            [cell addSubview:label_title];
            [cell addSubview:label_titles];
            
            
            UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(70, 15, 10, 10)];
            image.image = [UIImage imageNamed:@"素彩网www.sc115.com-102"];
            [cell.contentView addSubview:image];
            UIImageView *imageone = [[UIImageView alloc]initWithFrame:CGRectMake(80, 15, 10, 10)];
            imageone.image = [UIImage imageNamed:@"素彩网www.sc115.com-102"];
            [cell.contentView addSubview:imageone];
            UIImageView *imagetow = [[UIImageView alloc]initWithFrame:CGRectMake(90, 15, 10, 10)];
            imagetow.image = [UIImage imageNamed:@"素彩网www.sc115.com-102"];
            [cell.contentView addSubview:imagetow];
            UIImageView *imagethree = [[UIImageView alloc]initWithFrame:CGRectMake(100, 15, 10, 10)];
            imagethree.image = [UIImage imageNamed:@"素彩网www.sc115.com-102"];
            [cell.contentView addSubview:imagethree];
            UIImageView *imagefour = [[UIImageView alloc]initWithFrame:CGRectMake(110, 15, 10, 10)];
            imagefour.image = [UIImage imageNamed:@"素彩网www.sc115.com-102-拷贝-3"];
            [cell.contentView addSubview:imagefour];
            
            
            UITextView *label_text = [[UITextView alloc]initWithFrame:CGRectMake(15,CGRectGetMaxY(label_title.frame)+5 , WLScreenW-15, 140-44-5)];
            label_text.text = _course.comment[indexPath.row].msg;
            //设置内容不能编辑
            label_text.editable = NO;
            //设置字体大小
            label_text.font = [UIFont systemFontOfSize:17];
            [cell addSubview:label_text];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 44;
    }if (indexPath.section == 1) {
        return 250;
    }if (indexPath.section == 2) {
        return 44;
    }if (indexPath.section == 3) {
        return 44;
    }if (indexPath.section == 4) {
        return 140;
    }
    return 44;
}
- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2) {
        WLorganVC *vc = [[WLorganVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }if (indexPath.section == 2) {
        WLDgViewController *VC = [[WLDgViewController alloc]init];
        [self.navigationController pushViewController:VC animated:YES];
    }

    
    
    
}



@end
