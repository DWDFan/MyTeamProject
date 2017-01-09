//
//  WLExaminationHelper.m
//  MyBoRuiSi
//
//  Created by Magician on 2017/1/8.
//  Copyright © 2017年 itcast.com. All rights reserved.
//

#import "WLExaminationHelper.h"
#import "WLHomeDataHandle.h"

@interface WLExaminationHelper ()

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation WLExaminationHelper

+ (instancetype)sharedInstance
{
    static WLExaminationHelper* instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [WLExaminationHelper new];
    });
    
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _answerArray = [NSMutableArray arrayWithCapacity:64];
        _answerDict = [NSMutableDictionary dictionaryWithCapacity:64];
    }
    return self;
}

- (void)addAnswer:(NSString *)answer questionId:(NSString *)Id type:(NSString *)type
{
    if ([type isEqualToString:@"选择题"] && ![self.answerDict objectForKey:Id]) {
        self.chooseCount ++;
    }
    else if ([type isEqualToString:@"判断题"] && ![self.answerDict objectForKey:Id]) {
        self.judgeCount ++;
    }
    else if ([type isEqualToString:@"填空题"] && ![self.answerDict objectForKey:Id]) {
        self.fillCount ++;
    }
    else if ([type isEqualToString:@"问答题"] && ![self.answerDict objectForKey:Id]) {
        self.essayCount ++;
    }
    self.isAnswer = YES;
//    [self.answerDict setObject:@[type, answer] forKey:Id];
    [self.answerDict setValue:@[type, answer] forKey:Id];
}

- (void)commitAnswerCompletion:(void(^)(void))completion
{
    for (NSString *key in self.answerDict) {
        [self.answerArray addObject:@{key:self.answerDict[key]}];
    }
    [MOProgressHUD showWithStatus:@"正在提交试卷..."];
    [WLHomeDataHandle requestExaminationSubmitWithUid:[WLUserInfo share].userId kid:self.kid data:self.answerArray success:^(id responseObject) {
        
        [self resetExaminationData];
        [MOProgressHUD showSuccessWithStatus:@"提交试卷成功!"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            completion ? completion() : nil;
        });
    } failure:^(NSError *error) {
        [self resetExaminationData];
        [MOProgressHUD showSuccessWithStatus:error.userInfo[@"msg"]];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            completion ? completion() : nil;
        });
    }];
}

- (void)resetExaminationData
{
    [self.answerDict removeAllObjects];
    [self.answerArray removeAllObjects];
    self.fillCount = 0;
    self.chooseCount = 0;
    self.judgeCount = 0;
    self.essayCount = 0;
    self.isAnswer = NO;
    self.kid = nil;
    [self.timer invalidate];
    self.timer = nil;
    self.timelong = 0;
    self.timelongStr = nil;
}

- (void)setTimelong:(NSInteger)timelong
{
    _timelong = timelong;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        
        _timelong --;
        _timelongStr = [self getTimelongStringWithSecond:_timelong];
        if (_timelong == 0) {
            //考试时间到
            [_timer invalidate];
            _timer = nil;
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"examinationEnd" object:nil userInfo:nil];
        }
    }];
}

- (NSString *)getTimelongStringWithSecond:(NSInteger)second
{
    NSInteger h = second/60/60;
    NSInteger m = second/60%60;
    NSInteger s = second%60;
    NSString *timeString = [NSString stringWithFormat:@"%.2ld:%.2ld:%.2ld",h,m,s];
    return timeString;
}

- (NSString *)getAnswerByQuestionId:(NSString *)questionId
{
    NSArray *answerArray = [self.answerDict objectForKey:questionId];
    return [answerArray lastObject];
}

@end
