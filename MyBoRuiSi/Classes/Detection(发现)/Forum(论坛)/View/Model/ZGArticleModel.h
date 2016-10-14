//
//  ZGArticleModel.h
//  MyBoRuiSi
//
//  Created by Catskiy on 16/9/26.
//  Copyright © 2016年 itcast.com. All rights reserved.
//
//"photo": null,
//"id": "2",
//"name": null,
//"desc": null,
//"addtime": "2016-09-09 12:10:00",
//"title": "好的",
//"content": "吃反反复复",
//"images": [ ],
//"zanNum": 100,
//"cmtNum": 81,
//"viewNum": 9999
#import <Foundation/Foundation.h>

@interface ZGImageModel : NSObject

@property (nonatomic, strong) NSString *addtime;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *tid;
@property (nonatomic, strong) NSString *image;

@end

@interface ZGArticleModel : NSObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *tid;
@property (nonatomic, strong) NSString *photo;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *addtime;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSNumber *zanNum;
@property (nonatomic, strong) NSNumber *cmtNum;
@property (nonatomic, strong) NSNumber *replyNum;
@property (nonatomic, strong) NSNumber *viewNum;
@property (nonatomic, strong) NSNumber *view;
@property (nonatomic, strong) NSArray *image;

@property (nonatomic, strong) NSString *qid;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, assign) BOOL selfZan;

@end

@interface ZGArticleViewModel : NSObject

@property (nonatomic, strong) ZGArticleModel *article;
@property (nonatomic, assign) CGRect avatarFrame;
@property (nonatomic, assign) CGRect timeFrame;
@property (nonatomic, assign) CGRect nameFrame;
@property (nonatomic, assign) CGRect titleFrame;
@property (nonatomic, assign) CGRect contentFrame;
@property (nonatomic, assign) CGRect imageVFrame;
@property (nonatomic, assign) CGRect praIconFrame;
@property (nonatomic, assign) CGRect cmtIconFrame;
@property (nonatomic, assign) CGRect readIconFrame;
@property (nonatomic, assign) CGRect praFrame;
@property (nonatomic, assign) CGRect cmtFrame;
@property (nonatomic, assign) CGRect readFrame;
@property (nonatomic, assign) CGRect moreBtnFrame;
@property (nonatomic, assign) CGFloat cellHeight;

@end
