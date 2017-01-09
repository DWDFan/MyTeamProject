//
//  WLTestDetailViewController.h
//  MyBoRuiSi
//
//  Created by Magician on 2017/1/6.
//  Copyright © 2017年 itcast.com. All rights reserved.
//

#import "BaseViewController.h"

@interface WLTestDetailViewController : BaseViewController

@property (nonatomic, strong) NSString *questionId;
@property (nonatomic, strong) NSArray *questionsArray; 
@property (nonatomic, strong) NSString *testId;
@property (nonatomic, strong) NSString *testPaperId;
@property (nonatomic, assign) NSUInteger questionIndex; 

@end
