//
//  ZGLivePlayerControl.h
//  MyBoRuiSi
//
//  Created by Catskiy on 2016/10/13.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NELivePlayer;

@interface ZGLivePlayerControl : UIControl

@property(nonatomic, weak) id<NELivePlayer> delegatePlayer;

@end
