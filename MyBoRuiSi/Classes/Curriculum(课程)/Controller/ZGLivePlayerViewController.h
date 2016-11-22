//
//  ZGLivePlayerViewController.h
//  MyBoRuiSi
//
//  Created by Catskiy on 2016/10/12.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "ZGLivePlayerControl.h"

@interface ZGLivePlayerViewController : BaseViewController

@property(nonatomic, strong) NSString *courseId;
@property(nonatomic, strong) NSURL *url;
@property(nonatomic, strong) NSString *decodeType;
@property(nonatomic, strong) NSString *mediaType;
@property(nonatomic, strong) id<NELivePlayer> liveplayer;
@property(nonatomic, strong) UILabel *tipLbl;

- (id)initWithURL:(NSURL *)url andDecodeParm:(NSMutableArray *)decodeParm;

+ (void)presentFromViewController:(UIViewController *)viewController withTitle:(NSString *)title URL:(NSURL *)url andDecodeParm:(NSMutableArray *)decodeParm completion:(void(^)())completion;
@property(nonatomic, strong) ZGLivePlayerControl *mediaControl;

@end
