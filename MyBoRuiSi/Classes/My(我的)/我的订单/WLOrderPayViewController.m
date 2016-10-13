//
//  WLOrderPayViewController.m
//  MyBoRuiSi
//
//  Created by 莫瑞伟 on 16/8/4.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLOrderPayViewController.h"
#import "WLOrderPayOKViewController.h"

#import "WLOrderDataHandle.h"

#import "Pingpp.h"

#define kUrlScheme      @"demoapp001"
@interface WLOrderPayViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView_main;
@property (nonatomic, strong) UIAlertView *alertView;
@property (nonatomic, strong) UIButton *selectFalg;

@property (nonatomic,strong) NSMutableArray *arr_str;
@property (nonatomic, strong) NSString *channel;

@end

@implementation WLOrderPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSelf];
    NSString *orderName = [NSString stringWithFormat:@"订单编号:  %@",self.orderId];
    NSString *amountStr = [NSString stringWithFormat:@"订单总价:  ￥%@",self.amountStr];
    NSString *accountStr = [NSString stringWithFormat:@"账户余额:  ￥%@",[WLUserInfo share].money ? [WLUserInfo share].money : @"0"];
    NSString *needMoneyStr = [NSString stringWithFormat:@"还需支付: ￥%@",self.needMoney];
    self.arr_str = [NSMutableArray arrayWithArray:@[@[orderName,amountStr,accountStr],
                                                    @[needMoneyStr],
                                                    @[@"支付宝支付",@"微信支付",@"银联支付"]]];
    
}
- (void)clickBalancePay:(UIButton *)button
{
    switch (button.tag) {
        case 0:
            self.channel = @"alipay";
            break;
        case 1:
            self.channel = @"wx";
            break;
        case 2:
            self.channel = @"upacp";
            break;
        case 100:
            if (![WLUserInfo share].money) return;  //余额为0 return
            self.channel = @"selfPay";//selfPay 自定义 与Ping++支付渠道无关
            break;
        
        default:
            break;
    }
    self.selectFalg.selected = NO;
    button.selected = YES;
    self.selectFalg = button;
}
- (IBAction)clickOKPay:(UIButton *)sender {
    if(!self.channel){
        [MOProgressHUD showErrorWithStatus:@"请选择支付方式"];
    }else if([self.channel isEqualToString:@"selfPay"]){
        //request dapay
        [self dopay];
    }else{
        __weak typeof(self) weakSelf = self;
        [MOProgressHUD showImage:nil withStatus:@"正在获取支付凭据,请稍后..."];
        [WLOrderDataHandle requestAddCartWithUid:[WLUserInfo share].userId channel:self.channel amount:self.amountStr success:^(id responseObject) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MOProgressHUD dismiss];
                [Pingpp createPayment:responseObject
                       viewController:weakSelf
                         appURLScheme:kUrlScheme
                       withCompletion:^(NSString *result, PingppError *error) {
                           if ([result isEqualToString:@"success"]) {
                               // 支付成功 调用dopay接口
                               [self dopay];
                               
                           } else if ([result isEqualToString:@"cancel"]){
                               //支付取消
                               [MOProgressHUD showErrorWithStatus:@"支付取消"];
                           }else if ([result isEqualToString:@"fail"]){
                               // 支付失败
                               [MOProgressHUD showErrorWithStatus:@"支付失败"];
                               
                           }
                       }];
            });
            
        } failure:^(NSError *error) {
            
        }];

    }
    
    
}

//MARK:tableView代理方法----------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arr_str[section] count];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.arr_str.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSString *str_title = self.arr_str[indexPath.section][indexPath.row];
    cell.textLabel.text = str_title;
    
    if (indexPath.section == 0) {
        if (indexPath.row == 2) {
            UIButton *button_option = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 44)];
            button_option.tag = 100;
            [button_option addTarget:self action:@selector(clickBalancePay:) forControlEvents:UIControlEventTouchUpInside];
            [button_option setImage:[UIImage imageNamed:@"椭圆-2"] forState:UIControlStateNormal];
            [button_option setImage:[UIImage imageNamed:@"tick"] forState:UIControlStateSelected];
            if(self.type == rechargeType){
                button_option.userInteractionEnabled = NO;
            }
            cell.accessoryView = button_option;
        }
    }
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            cell.imageView.image = [UIImage imageNamed:@"支付宝组-4"];
        }
        if (indexPath.row == 1) {
            cell.imageView.image = [UIImage imageNamed:@"微信组-5"];
        }
        if (indexPath.row == 2) {
            cell.imageView.image = [UIImage imageNamed:@"银联"];
        }
        UIButton *button_option = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 44)];
        button_option.tag = indexPath.row;
        [button_option addTarget:self action:@selector(clickBalancePay:) forControlEvents:UIControlEventTouchUpInside];
        [button_option setImage:[UIImage imageNamed:@"椭圆-2"] forState:UIControlStateNormal];
        [button_option setImage:[UIImage imageNamed:@"tick"] forState:UIControlStateSelected];
        cell.accessoryView = button_option;
    }
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 2) {
        return @"支付方式";
    }
    else{
        return @"";
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 2) {
        return 30;
    }
   return 0.01;
}
- (CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 1){
        return 0.01;
    }
    return 10;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (void)showAlertWait
{
    self.alertView = [[UIAlertView alloc] initWithTitle:@"正在获取支付凭据,请稍后..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
    [self.alertView show];
    UIActivityIndicatorView* aiv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    aiv.center = CGPointMake(self.alertView.frame.size.width / 2.0f - 15, self.alertView.frame.size.height / 2.0f + 10 );
    [aiv startAnimating];
    [self.alertView addSubview:aiv];
}

- (void)hideAlert
{
    if (self.alertView != nil)
    {
        [self.alertView dismissWithClickedButtonIndex:0 animated:YES];
        self.alertView = nil;
    }
}
- (void)initSelf{
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
    btn.backgroundColor = [UIColor clearColor];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setImage:[UIImage imageNamed:@"图层-47"] forState:UIControlStateNormal];
    [btn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
    [btn setTitle:@" 支付订单" forState:UIControlStateNormal];
    self.navigationItem.titleView = btn;
}

#pragma mark - Request
- (void)dopay{
    [WLOrderDataHandle requestDopayWithUid:[WLUserInfo share].userId oid:self.orderId success:^(id responseObject) {
        NSDictionary *dict = responseObject;
        if ([dict[@"code"]integerValue] == 1) {
            WLOrderPayOKViewController *vc = [[WLOrderPayOKViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            [MOProgressHUD showErrorWithStatus:dict[@"msg"]];
        }
    } failure:^(NSError *error) {
        
    }];
}

@end
