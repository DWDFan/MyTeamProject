//
//  ThePersonalDataTableViewController.m
//  MyBoRuiSi
//
//  Created by 莫 on 16/8/2.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "ThePersonalDataTableViewController.h"
#import "ThePersonalDataTableViewCell.h"
#import "WLThePersonalDataTableViewCellTwo.h"

#import "WLLoginDataHandle.h"
#import "WLMyDataHandle.h"

#import "UIAlertView+Block.h"
#import "ASBirthSelectSheet.h"
#import "UIActionSheet+camera.h"
@interface ThePersonalDataTableViewController ()<UIAlertViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) UIImage *image;//头像
@end

@implementation ThePersonalDataTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"个人资料";
    
    //获取用户信息
    //[self requestGetUserInfo];
}

#pragma mark - Private Method
-(void)chooseBirthdayAction{
    ASBirthSelectSheet *datesheet = [[ASBirthSelectSheet alloc] initWithFrame:self.view.bounds];
    
    __weak typeof(self) weakSelf = self;
    
    datesheet.GetSelectDate = ^(NSString *dateStr) {
        //reqeust
        [weakSelf requestUpdateInfoWithKey:@"birth" val:dateStr];//生日
    };
    [self.view addSubview:datesheet];
}



#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    id cell;
    
    
    
    if (indexPath.row == 0) {
        
        NSString *ID = @"WLThePersonalDataTableViewCellTwo";
        WLThePersonalDataTableViewCellTwo *cells = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cells) {
            cells = [[[NSBundle mainBundle] loadNibNamed:ID owner:nil options:nil] lastObject];
        }
        
        cells.describeLabel.text = @"头像:";
        [cells.imageName sd_setImageWithURL:[NSURL URLWithString:[WLUserInfo share].photo]];
        
        cell = cells;
        
    }else{
        
        
        NSString *ID = @"ThePersonalDataTableViewCell";
        ThePersonalDataTableViewCell *cells = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cells) {
            cells = [[[NSBundle mainBundle] loadNibNamed:ID owner:nil options:nil] lastObject];
        }
        
        if (indexPath.row == 1) {
            cells.describeLabel.text = @"昵称:";
            cells.contentLabel.text = [WLUserInfo share].nickname ? [WLUserInfo share].nickname : @"";
            
        }else if (indexPath.row == 2) {
            
            cells.describeLabel.text = @"性别:";
            cells.contentLabel.text = [WLUserInfo share].sex ? [WLUserInfo share].sex : @"";
            
            
        }else if (indexPath.row == 3) {
            
            cells.describeLabel.text = @"生日:";
            cells.contentLabel.text = [WLUserInfo share].birth ? [WLUserInfo share].birth : @"";
            
            
        }else if (indexPath.row == 4) {
            
            cells.describeLabel.text = @"所在公司:";
            cells.contentLabel.text = [WLUserInfo share].company ? [WLUserInfo share].company : @"";
            
            
        }else if (indexPath.row == 5) {
            
            cells.describeLabel.text = @"职业:";
            cells.contentLabel.text = [WLUserInfo share].job ? [WLUserInfo share].job : @"";
            
            
        }else{
            
            cells.describeLabel.text = @"地址:";
            cells.contentLabel.text = [WLUserInfo share].address ? [WLUserInfo share].address : @"";
            
            
            
        }
        
        cell = cells;
        
        
    }
    
    
   
    
    
    return  cell;
    
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    int a = 45;
    if (indexPath.row == 0) {
        
        a = 60;
    }
    
    return 60;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return  0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
        {
            //调用相机
            UIActionSheet *cameraActionSheet = [UIActionSheet showCameraActionSheet];
            cameraActionSheet.targer = self;
            [cameraActionSheet showInView:self.view];
        }
            break;
            
        case 1:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alert.tag = indexPath.row;
            alert.alertViewStyle = UIAlertViewStylePlainTextInput;
            UITextField *textField = [alert textFieldAtIndex:0];
            textField.text = [WLUserInfo share].nickname;
            [alert show];
        }
            break;
        case 2:
        {
            UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"男",@"女", nil];
            [sheet showInView:self.view];
        }
            break;
        case 3:
        {
            [self chooseBirthdayAction];
        }
            break;
        case 4:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alert.tag = indexPath.row;
            alert.alertViewStyle = UIAlertViewStylePlainTextInput;
            UITextField *textField = [alert textFieldAtIndex:0];
            textField.text = [WLUserInfo share].company;
            [alert show];
        }
            break;
        case 5:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alert.tag = indexPath.row;
            alert.alertViewStyle = UIAlertViewStylePlainTextInput;
            UITextField *textField = [alert textFieldAtIndex:0];
            textField.text = [WLUserInfo share].job;
            [alert show];
        }
            break;
        case 6:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alert.tag = indexPath.row;
            alert.alertViewStyle = UIAlertViewStylePlainTextInput;
            UITextField *textField = [alert textFieldAtIndex:0];
            textField.text = [WLUserInfo share].address;
            [alert show];
        }
            break;
            
        default:
            break;
    }
    
}


#pragma mark - UIAlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        //request
        UITextField *textField = [alertView textFieldAtIndex:0];
        switch (alertView.tag) {
            case 0:
                
                break;
            case 1:
                [self requestUpdateInfoWithKey:@"nickname" val:textField.text];//昵称
                break;
            case 4:
                [self requestUpdateInfoWithKey:@"company" val:textField.text];//公司
                break;
            case 5:
                [self requestUpdateInfoWithKey:@"job" val:textField.text];//职业
                break;
            case 6:
                [self requestUpdateInfoWithKey:@"address" val:textField.text];//地址
                break;
                
            default:
                break;
        }
        
    }
}

#pragma mark - UISheet Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        [self requestUpdateInfoWithKey:@"sex" val:@"男"];//性别
    }else{
        [self requestUpdateInfoWithKey:@"sex" val:@"女"];//性别
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
//- (void)requestGetUserInfo
//{
//    [WLLoginDataHandle requestGetUserInfoWithUid:[WLUserInfo share].userId success:^(id responseObject) {
//        
//    } failure:^(NSError *error) {
//        
//    }];
//}
/** 上传头像 */
-  (void)  requestCommitImageData:(NSData *)imageData{
    [WLLoginDataHandle requestUploadPhotoWithUid:[WLUserInfo share].userId filedata:imageData success:^(id responseObject) {
        NSDictionary *dic = responseObject;
        if ([dic[@"code"]integerValue ] == 1) {
            [MOProgressHUD showSuccessWithStatus:@"上传成功"];
            [MOProgressHUD dismiss];
            
           [WLUserInfo share].photo = dic[@"link"];
            [[WLUserInfo share] reArchivUserInfo];
            
            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
            [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
            
            //call back
             !self.reloadDataBlock ?: self.reloadDataBlock();
        }else{
            [MOProgressHUD showErrorWithStatus:dic[@"msg"]];
            [MOProgressHUD dismissWithDelay:1];
        }
    } failure:^(NSError *error) {
        
    }];
}
/** 更新资料*/
- (void)requestUpdateInfoWithKey:(NSString *)key val:(NSString *)val{
    [WLMyDataHandle requestUpdateInfoWithUid:[WLUserInfo share].userId key:key val:val success:^(id responseObject) {
        if([key isEqualToString:@"nickname"]){
            [WLUserInfo share].nickname = val;
        }else if([key isEqualToString:@"sex"]){
            [WLUserInfo share].sex = val;
        }else if([key isEqualToString:@"birth"]){
            [WLUserInfo share].birth = val;
        }else if([key isEqualToString:@"company"]){
            [WLUserInfo share].company = val;
        }else if([key isEqualToString:@"job"]){
            [WLUserInfo share].job = val;
        }else if([key isEqualToString:@"address"]){
            [WLUserInfo share].address = val;
        }
        [[WLUserInfo share] reArchivUserInfo];
        [self.tableView reloadData];
        
         //call back
        !self.reloadDataBlock ?: self.reloadDataBlock();
    } failure:^(NSError *error) {
        
    }];
}
@end
