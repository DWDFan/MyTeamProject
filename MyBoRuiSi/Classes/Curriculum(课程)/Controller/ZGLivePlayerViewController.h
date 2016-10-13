//
//  ZGLivePlayerViewController.h
//  MyBoRuiSi
//
//  Created by Catskiy on 2016/10/12.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZGLivePlayerControl.h"

@interface ZGLivePlayerViewController : UIViewController

@property(nonatomic, strong) NSURL *url;
@property(nonatomic, strong) NSString *decodeType;
@property(nonatomic, strong) NSString *mediaType;
@property(nonatomic, strong) id<NELivePlayer> liveplayer;

- (id)initWithURL:(NSURL *)url andDecodeParm:(NSMutableArray *)decodeParm;

+ (void)presentFromViewController:(UIViewController *)viewController withTitle:(NSString *)title URL:(NSURL *)url andDecodeParm:(NSMutableArray *)decodeParm completion:(void(^)())completion;
@property(nonatomic, strong) ZGLivePlayerControl *mediaControl;

@end
