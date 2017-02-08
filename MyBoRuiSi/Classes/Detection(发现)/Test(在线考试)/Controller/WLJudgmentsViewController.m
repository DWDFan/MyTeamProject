//
//  WLJudgmentsViewController.m
//  MyBoRuiSi
//
//  Created by wsl on 16/8/6.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLJudgmentsViewController.h"
#import "WLExaminationHelper.h"

@interface WLJudgmentsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *questionLbl;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (weak, nonatomic) IBOutlet UIButton *preBtn;
@property (weak, nonatomic) IBOutlet UILabel *indexBtn;
@property (weak, nonatomic) IBOutlet UIButton *faultBtn;
@property (weak, nonatomic) IBOutlet UIButton *tureBtn;

@end

@implementation WLJudgmentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
    btn.backgroundColor = [UIColor clearColor];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setImage:[UIImage imageNamed:@"图层-47"] forState:UIControlStateNormal];
    [btn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
    [btn setTitle:@"判断题" forState:UIControlStateNormal];
    self.navigationItem.titleView = btn;
    
    
    
    [self.navigationController.navigationBar setBackgroundImage:[self createImageWithColor:RGBA(255, 255, 255, 1)] forBarMetrics:UIBarMetricsDefault];
    
    [self loadData];
    
}

- (void)loadData
{
    NSDictionary *dict = self.questionArray[self.index];
    NSString *question = dict[@"title"];
    NSArray *tureAnser = dict[@"ok_answer"];
    question = [NSString stringWithFormat:@"%ld.%@", self.index + 1, question];
    self.questionLbl.text = question;
    
    
    if (self.isShowAnswer) {
        self.tureBtn.enabled = NO;
        self.faultBtn.enabled = NO;
        if ([tureAnser[0] isEqualToString:@"是"]) {
            [self.tureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
            self.tureBtn.backgroundColor = kColor_green;
            self.faultBtn.selected = NO;
            self.faultBtn.backgroundColor = [UIColor whiteColor];
        }else {
            self.tureBtn.selected = NO;
            self.tureBtn.backgroundColor = [UIColor whiteColor];
            [self.faultBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
            self.faultBtn.backgroundColor = kColor_green;
        }
    }else {
        NSString *answer = [self.examHelper getAnswerByQuestionId:dict[@"id"]];
        if ([answer isEqualToString:@"是"]) {
            self.tureBtn.selected = YES;
            self.tureBtn.backgroundColor = kColor_button_bg;
            self.faultBtn.selected = NO;
            self.faultBtn.backgroundColor = [UIColor whiteColor];
        }else if ([answer isEqualToString:@"否"]){
            self.tureBtn.selected = NO;
            self.tureBtn.backgroundColor = [UIColor whiteColor];
            self.faultBtn.selected = YES;
            self.faultBtn.backgroundColor = kColor_button_bg;
        }
    }
    
    
    self.indexBtn.text = [NSString stringWithFormat:@"%ld/%ld",self.index + 1,self.questionArray.count];
    if (self.index == self.questionArray.count - 1) {
        self.nextBtn.selected = YES;
    }
    if (self.index == 0) {
        self.preBtn.enabled = NO;
    }
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)faultBtnAction:(id)sender {
    
    
    self.faultBtn.selected = YES;
    self.faultBtn.backgroundColor = kColor_button_bg;
    self.tureBtn.selected = NO;
    self.tureBtn.backgroundColor = [UIColor whiteColor];
    
    [[WLExaminationHelper sharedInstance] addAnswer:@"否"
                                         questionId:self.questionArray[self.index][@"id"]
                                               type:@"判断题"];
    
    if (self.nextBtn.selected) {
        [self.navigationController popToViewController:self.navigationController.childViewControllers[2] animated:YES];
        return;
    }
    WLJudgmentsViewController *vc = [[WLJudgmentsViewController alloc] init];
    vc.questionArray = self.questionArray;
    vc.kid = self.kid;
    vc.index = self.index + 1;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)tureBtnAction:(id)sender {
    
    
    self.tureBtn.selected = YES;
    self.tureBtn.backgroundColor = kColor_button_bg;
    self.faultBtn.selected = NO;
    self.faultBtn.backgroundColor = [UIColor whiteColor];

    [[WLExaminationHelper sharedInstance] addAnswer:@"是"
                                         questionId:self.questionArray[self.index][@"id"]
                                               type:@"判断题"];
    
    if (self.nextBtn.selected) {
        [self.navigationController popToViewController:self.navigationController.childViewControllers[2] animated:YES];
        return;
    }
    WLJudgmentsViewController *vc = [[WLJudgmentsViewController alloc] init];
    vc.questionArray = self.questionArray;
    vc.kid = self.kid;
    vc.index = self.index + 1;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)nextBtnAction:(id)sender {
    UIButton *button = (UIButton *)sender;
    
    if (button.selected) {
        [self.navigationController popToViewController:self.navigationController.childViewControllers[2] animated:YES];
        return;
    }
    WLJudgmentsViewController *vc = [[WLJudgmentsViewController alloc] init];
    vc.questionArray = self.questionArray;
    vc.kid = self.kid;
    vc.index = self.index + 1;
    vc.isShowAnswer = self.isShowAnswer;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)preBtnAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
