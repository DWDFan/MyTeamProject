//
//  WLExaminationHelper.h
//  MyBoRuiSi
//
//  Created by Magician on 2017/1/8.
//  Copyright © 2017年 itcast.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLExaminationHelper : NSObject

@property (nonatomic, strong) NSMutableArray *answerArray;
@property (nonatomic, strong) NSMutableDictionary *answerDict;

@property (nonatomic, assign) NSInteger fillCount;
@property (nonatomic, assign) NSInteger chooseCount;
@property (nonatomic, assign) NSInteger judgeCount;
@property (nonatomic, assign) NSInteger essayCount;
@property (nonatomic, strong) NSString *kid;
@property (nonatomic, assign) NSInteger timelong;
@property (nonatomic, strong) NSString *timelongStr;
@property (nonatomic, assign) BOOL isAnswer;

+ (instancetype)sharedInstance;
- (void)addAnswer:(NSString *)answer questionId:(NSString *)Id type:(NSString *)type;
- (NSString *)getAnswerByQuestionId:(NSString *)questionId;
- (void)commitAnswerCompletion:(void(^)(void))completion;
- (void)resetExaminationData;

@end
