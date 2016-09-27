//
//  MOHTTP.h
//  E农会
//
//  Created by 莫瑞伟 on 16/5/29.
//  Copyright © 2016年 莫瑞伟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MOHTTP : NSObject

/**
 *  发送get请求
 *
 *  @param URLString  请求的基本的url
 *  @param parameters 请求的参数字典
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
+ (void)GET:(NSString *)URLString
 parameters:(id)parameters
    success:(void (^)(id responseObject))success
    failure:(void (^)(NSError *error))failure;


/**
 *  发送post请求
 *
 *  @param URLString  请求的基本的url
 *  @param parameters 请求的参数字典
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
+ (void)Post:(NSString *)URLString
  parameters:(id)parameters
     success:(void (^)(id responseObject))success
     failure:(void (^)(NSError *error))failure;

/*  上传
 *  urlString  url
 *  fileURL 上传路径
 *
 */
- (NSURLSessionUploadTask *)uploadTaskWithUrlString:(NSString *)urlString
                                         parameters:( id)parameters
                                           mimeType:(NSString *)mimeType
                                         sourceData:(NSData*)sourceData
                                           progress:(NSProgress * __autoreleasing *)downloadProgress
                                  completionHandler:(void (^)(NSURLResponse *response, id responseObject, NSError *error))completionHandler;
@end
