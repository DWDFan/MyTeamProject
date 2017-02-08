//
//  ZGDownLoadUtil.h
//  MyBoRuiSi
//
//  Created by Catskiy on 2016/10/14.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZGDownLoadUtil : NSObject

@property (nonatomic, strong) NSFileHandle *writeHandle;
@property (nonatomic, assign) long long currentLength;
@property (nonatomic, assign) long long totalLength;

- (void)downLoadFileWithUrl:(NSURL *)url completion:(void(^)(BOOL isComplete))completion;

+ (BOOL)hadDownloadFile:(NSString *)fileUrlStr;
+ (NSString *)get_filename:(NSString *)name;
@end
