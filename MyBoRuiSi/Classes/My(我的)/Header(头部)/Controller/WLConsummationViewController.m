//
//  WLConsummationViewController.m
//  MyBoRuiSi
//
//  Created by wsl on 16/8/4.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLConsummationViewController.h"
#import "ASBirthSelectSheet.h"

@interface WLConsummationViewController ()
//头像
@property (weak, nonatomic) IBOutlet UIButton *photo;
//性别
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sex;
@property (weak, nonatomic) IBOutlet UILabel *label;
//呢称
@property (weak, nonatomic) IBOutlet UITextField *nickname;
//职业
@property (weak, nonatomic) IBOutlet UITextField *job;
//地址
@property (weak, nonatomic) IBOutlet UITextField *address;
@end

@implementation WLConsummationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
    btn.backgroundColor = [UIColor clearColor];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setImage:[UIImage imageNamed:@"图层-47"] forState:UIControlStateNormal];
    [btn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
    [btn setTitle:@"完善资料" forState:UIControlStateNormal];
    self.navigationItem.titleView = btn;
    
    
    
    [self.navigationController.navigationBar setBackgroundImage:[self createImageWithColor:RGBA(255, 255, 255, 1)] forBarMetrics:UIBarMetricsDefault];
    
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


#pragma mark 点击cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.row == 3) {
        
        
        [self chooseBirthdayAction];
        
    }
}


-(void)chooseBirthdayAction{
    ASBirthSelectSheet *datesheet = [[ASBirthSelectSheet alloc] initWithFrame:self.view.bounds];
    
        __weak typeof(self) weakSelf = self;
    
    datesheet.GetSelectDate = ^(NSString *dateStr) {
        
        NSArray *array = [dateStr componentsSeparatedByString:@"-"];
        
        weakSelf.label.text = [NSString stringWithFormat:@"%@年%@月%@日",array[0],array[1],array[2]];
        
         NSIndexPath *indexPath=[NSIndexPath indexPathForRow:3 inSection:0];
         [weakSelf.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];

        NSLog(@"ok Date:%@", dateStr);
    };
    [self.view addSubview:datesheet];
}

@end
