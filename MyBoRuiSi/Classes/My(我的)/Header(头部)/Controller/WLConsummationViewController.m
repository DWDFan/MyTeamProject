//
//  WLConsummationViewController.m
//  MyBoRuiSi
//
//  Created by wsl on 16/8/4.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLConsummationViewController.h"
#import "ASBirthSelectSheet.h"

#import "WLLoginDataHandle.h"

#import "UIActionSheet+camera.h"
@interface WLConsummationViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
//头像
@property (weak, nonatomic) IBOutlet UIButton *photo;
//性别
@property (weak, nonatomic) IBOutlet UILabel *sex;
@property (weak, nonatomic) IBOutlet UILabel *label;
//呢称
@property (weak, nonatomic) IBOutlet UITextField *nickname;
//职业
@property (weak, nonatomic) IBOutlet UITextField *job;
//地址
@property (weak, nonatomic) IBOutlet UITextField *address;

@property (nonatomic, copy) NSString *photoUrl;//头像url
@property (nonatomic, copy) NSString *year;//年
@property (nonatomic, copy) NSString *month;//月
@property (nonatomic, copy) NSString *day;//日
@property (nonatomic, strong) UIImage *image;//头像
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
    if (indexPath.row == 0) {
       //调用相机
        UIActionSheet *cameraActionSheet = [UIActionSheet showCameraActionSheet];
        cameraActionSheet.targer = self;
        [cameraActionSheet showInView:self.view];
    }else if (indexPath.row == 2){
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"男",@"女", nil];
        [sheet showInView:self.view];
    }else if (indexPath.row == 3) {
        
        [self chooseBirthdayAction];
        
    }
}


-(void)chooseBirthdayAction{
    ASBirthSelectSheet *datesheet = [[ASBirthSelectSheet alloc] initWithFrame:self.view.bounds];
    
        __weak typeof(self) weakSelf = self;
    
    datesheet.GetSelectDate = ^(NSString *dateStr) {
        
        NSArray *array = [dateStr componentsSeparatedByString:@"-"];
        
        weakSelf.label.text = [NSString stringWithFormat:@"%@年%@月%@日",array[0],array[1],array[2]];
        
        weakSelf.year = array[0];
        weakSelf.month = array[1];
        weakSelf.day = array[2];
        
         NSIndexPath *indexPath=[NSIndexPath indexPathForRow:3 inSection:0];
         [weakSelf.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];

        NSLog(@"ok Date:%@", dateStr);
    };
    [self.view addSubview:datesheet];
}

#pragma mark - UIActionSheet Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //呼出的菜单按钮点击后的响应
    if (buttonIndex == actionSheet.cancelButtonIndex){
        NSLog(@"取消");
    }
    switch (buttonIndex){
        case 0:
           self.sex.text = @"男";
            break;
            
        case 1:
           self.sex.text = @"女";
            break;
    }
}
#pragma mark - UIImagePickerController Delegate
//当选择一张图片后进入这里
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        //先把图片转成NSData
        _image = [info objectForKey:UIImagePickerControllerEditedImage];
        
        //压缩图片
        NSData *imageNewData = UIImageJPEGRepresentation(_image, 0.5);
        //上传到阿里云
        [self requestCommitImageData:imageNewData];
        
        //关闭相册界面
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}

/** 取消相机 */
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Request
/** 上传头像 */
-  (void)  requestCommitImageData:(NSData *)imageData{
   [WLLoginDataHandle requestUploadPhotoWithUid:self.id filedata:imageData success:^(id responseObject) {
       NSDictionary *dic = responseObject;
       if ([dic[@"code"]integerValue ] == 1) {
           [self.photo setImage:self.image forState:UIControlStateNormal];
           [MOProgressHUD showSuccessWithStatus:@"上传成功"];
           [MOProgressHUD dismiss];
           
           self.photoUrl = dic[@"link"];
       }else{
           [MOProgressHUD showErrorWithStatus:dic[@"msg"]];
           [MOProgressHUD dismissWithDelay:1];
       }
   } failure:^(NSError *error) {
       
   }];
}


/** 信息完成 */
- (IBAction)requestUserInfoCommit{
    [MOProgressHUD show];
    [WLLoginDataHandle requestPerfectPersonalInfoWithUid:self.id photo:self.photoUrl sex:self.sex.text nickname:self.nickname.text year:self.year month:self.month day:self.day job:self.job.text address:self.address.text success:^(id responseObject) {
        NSDictionary *dic = responseObject;
        if ([dic[@"code"]integerValue ] == 1) {
          [MOProgressHUD dismiss];
            
        }else{
            [MOProgressHUD showErrorWithStatus:dic[@"msg"]];
            [MOProgressHUD dismissWithDelay:1];
        }
 
    } failure:^(NSError *error) {
        [MOProgressHUD dismiss];
    }];
}
@end
