//
//  WLWalletViewController.m
//  MyBoRuiSi
//
//  Created by wsl on 16/8/3.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "UIImage+Image.h"
#import "KxMenu.h"

#import "WLWalletViewController.h"
#import "WLWalletViewCell.h"
#import "WLSufficientViewCell.h"
#import "WLConsumeViewController.h"
#import "WLIncomeViewController.h"
#import "WLModifyViewController.h"
#import "WLForgetViewController.h"
@interface WLWalletViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView_main;

@end

@implementation WLWalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置在头部
    WLWalletViewCell *header = [[[NSBundle mainBundle]loadNibNamed:@"WLWalletViewCell" owner:nil options:nil]lastObject];
    self.tableView_main.tableHeaderView = header;
    
    //设置在尾部
    WLSufficientViewCell *headers = [[[NSBundle mainBundle]loadNibNamed:@"WLSufficientViewCell" owner:nil options:nil]lastObject];
    headers.nav = self.navigationController;
    self.tableView_main.tableFooterView = headers;
    
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
    btn.backgroundColor = [UIColor clearColor];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setImage:[UIImage imageNamed:@"图层-47"] forState:UIControlStateNormal];
    [btn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
    [btn setTitle:@"我的钱包" forState:UIControlStateNormal];
    self.navigationItem.titleView = btn;
    
    //设置右边的按钮图片没有渲染
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageWithOriginalName:@"锁子"] style:UIBarButtonItemStyleDone target:self action:@selector(nav_w_add_prer)];
    
    
    [self.navigationController.navigationBar setBackgroundImage:[self createImageWithColor:RGBA(255, 255, 255, 1)] forBarMetrics:UIBarMetricsDefault];
//    //创建按钮
//    UIButton *btnone = [[UIButton alloc]init];
//    [btnone setTitle:@"爱你你" forState:UIControlStateNormal];
//    [btnone setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
//    UIImage *image = [UIImage imageNamed:@"矩形-6"];
//    [btnone setBackgroundImage:image forState:UIControlStateNormal];
//    btnone.frame = CGRectMake(120, 400, 100, 100);
//    [btnone addTarget:self action:@selector(btntow) forControlEvents:UIControlEventValueChanged];
//    [self.view addSubview:btnone];
//    
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
    @[
      
      
      
      [KxMenuItem menuItem:@"修改支付密码"
                     image:nil
                    target:self
                    action:@selector(btn_chat:)],
      
      [KxMenuItem menuItem:@"忘记支付密码"
                     image:nil
                    target:self
                    action:@selector(btn_addf:)],
      
  ];
    KxMenuItem *first = menuItems[0];
    first.foreColor = [UIColor colorWithRed:136/255.0f green:136/255.0f blue:136/255.0f alpha:1.0];
    first.alignment = NSTextAlignmentCenter;
    [KxMenu showMenuInView:self.view
                  fromRect:CGRectMake(WLScreenW - 50, -40, 40, 40)
                 menuItems:menuItems];
    
    
    
}
//分享
- (void)btn_chat:(id)sender{
    
    
    
    WLModifyViewController *Modify = [[WLModifyViewController alloc]init];
//
//
//       [share dismissViewControllerAnimated:YES completion:^{
//
//       }];
//    
//    Wallets.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [self.navigationController pushViewController:Modify animated:YES];
//    [self presentViewController:Wallets animated:YES completion:^{
//        // NSLog(@"展示完毕");
//    }];
    
    
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
    WLForgetViewController *Forget = [[WLForgetViewController alloc]init];
    
    [self.navigationController pushViewController:Forget animated:YES];
}


//MARK:tableView代理方法----------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
//添加cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    //隐藏点击cell的效果
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //添加cell的个数
    cell.textLabel.text = @"收入明细";
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"消费明细";
        }
    }
    //添加图片
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    //添加尾部图片
//    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(320, 25,10, 20)];
//    imageView.image = [UIImage imageNamed:@"素彩网www.sc115.com-138-拷贝-4"];
//    [cell.contentView addSubview:imageView];
  
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 4;
}
- (CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

//设置点击跳转到下一个界面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            WLConsumeViewController *ConsumeVC = [[WLConsumeViewController alloc]init];
            [self.navigationController pushViewController:ConsumeVC animated:YES];
        }if (indexPath.row == 1) {
            WLIncomeViewController *IncomeVC = [[WLIncomeViewController alloc]init];
            [self.navigationController pushViewController:IncomeVC animated:YES];
        }
    }
}


@end
