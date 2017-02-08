//
//  WLfillingViewController.m
//  MyBoRuiSi
//
//  Created by wsl on 16/8/5.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLfillingViewController.h"
#import "WLHomeDataHandle.h"
#import "WLExaminationHelper.h"

@interface WLfillingViewController ()

@property (weak, nonatomic) IBOutlet UILabel *questionLbl;
@property (weak, nonatomic) IBOutlet UILabel *indexLbl;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (weak, nonatomic) IBOutlet UIButton *preBtn;

@end

@implementation WLfillingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
    btn.backgroundColor = [UIColor clearColor];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setImage:[UIImage imageNamed:@"图层-47"] forState:UIControlStateNormal];
    [btn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
    [btn setTitle:@"填空题" forState:UIControlStateNormal];
    self.navigationItem.titleView = btn;
    
    [self.navigationController.navigationBar setBackgroundImage:[self createImageWithColor:RGBA(255, 255, 255, 1)] forBarMetrics:UIBarMetricsDefault];
    
    //
    [self loadData];
}

- (void)loadData
{
    NSDictionary *dict = self.questionArray[self.index];
    NSString *question = dict[@"title"];
    NSArray *tureAnser = dict[@"ok_answer"];
    question = [NSString stringWithFormat:@"%ld.%@", self.index + 1, question];
    self.questionLbl.text = question;
    
    NSArray *array = [question componentsSeparatedByString:@"填空处"];
    NSInteger blankCount = array.count - 1;
    
    if (self.isShowAnswer) {
        
//        NSArray *tureAnserArray = [tureAnser componentsSeparatedByString:@"|"];
        for (NSInteger i = 0; i < 6; i ++) {
            UITextField *textField = (UITextField *)[self.view viewWithTag:1000 + i];
            
            if (i < tureAnser.count) {
                textField.text = tureAnser[i];
                textField.textColor = kColor_green;
                textField.userInteractionEnabled = NO;
            }
            if (i > blankCount - 1) {
                textField.hidden = YES;
            }
        }
    }else {
        NSString *answer = [self.examHelper getAnswerByQuestionId:dict[@"id"]];
        NSArray *anserArray = [answer componentsSeparatedByString:@"|"];
        
        for (NSInteger i = 0; i < 6; i ++) {
            UITextField *textField = (UITextField *)[self.view viewWithTag:1000 + i];
            
            if (i < anserArray.count) {
                textField.text = anserArray[i];
            }
            if (i > blankCount - 1) {
                textField.hidden = YES;
            }
        }
    }
    
    self.indexLbl.text = [NSString stringWithFormat:@"%ld/%ld",self.index + 1,self.questionArray.count];
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (IBAction)preBtnAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)nextBtnAction:(id)sender {
    
    
    NSString *answerStr = @"";
    for (NSInteger i = 0; i < 6; i ++) {
        UITextField *textField = (UITextField *)[self.view viewWithTag:1000 + i];
        if (textField.hidden == NO) {
            answerStr = [answerStr stringByAppendingString:textField.text];
            answerStr = [answerStr stringByAppendingString:@"|"];
        }
    }
    answerStr = [answerStr substringToIndex:answerStr.length - 1];
    [self.examHelper addAnswer:answerStr questionId:self.questionArray[self.index][@"id"] type:@"填空题"];
    
    UIButton *button = (UIButton *)sender;
    if (button.selected) {
        [self.navigationController popToViewController:self.navigationController.childViewControllers[2] animated:YES];
        return;
    }
    WLfillingViewController *fillVC = [[WLfillingViewController alloc] init];
    fillVC.questionArray = self.questionArray;
    fillVC.kid = self.kid;
    fillVC.index = self.index + 1;
    fillVC.isShowAnswer = YES;
    [self.navigationController pushViewController:fillVC animated:YES];
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
