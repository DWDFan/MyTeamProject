//
//  MOHTTP.m
//  E农会
//
//  Created by 莫瑞伟 on 16/5/29.
//  Copyright © 2016年 莫瑞伟. All rights reserved.
//

#import "MOHTTP.h"
#import "AFNetworking.h"

@implementation MOHTTP
+ (void)GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 创建请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    //拼接URL
    NSString *URLStr = [NSString stringWithFormat:@"%@%@",PostUrl,URLString];
    NSLog(@"%@+++",URLStr);
    NSLog(@"%@---",parameters);
    [mgr GET:URLStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (!responseObject) {
            NSError *error = [NSError errorWithDomain:@"nil" code:00000 userInfo:nil];
            failure(error);
            return ;
        }
        
        NSInteger code = [responseObject[@"code"] integerValue];
        if (code == 1) {
            if (success) {
                NSString *str_status = [NSString stringWithFormat:@"%@",[responseObject valueForKey:@"statusCode"]];
                NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:responseObject];
                [dic setObject:str_status forKey:@"statusCode"];
                success(dic);
            }
        }else {
            if (failure) {
                NSError *error = [NSError errorWithDomain:@"error" code:code userInfo:@{@"msg":responseObject[@"msg"]}];
                failure(error);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
    
}

+ (void)Post:(NSString *)URLString parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    
    // 创建请求管理者
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    //拼接URL
    NSString *URLStr = [NSString stringWithFormat:@"%@%@",PostUrl,URLString];
    NSLog(@"%@+++",URLStr);
    NSLog(@"%@---",parameters);
    [mgr POST:URLStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            
            NSString *str_status = [NSString stringWithFormat:@"%@",[responseObject valueForKey:@"statusCode"]];
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:responseObject];
            [dic setObject:str_status forKey:@"statusCode"];
            success(dic);
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [MOProgressHUD dismiss];
         
        if (failure) {
            NSLog(@"%@",error);
            failure(error);
            
            return ;
        }
    }];
    
}

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
                                  completionHandler:(void (^)(NSURLResponse *response, id responseObject, NSError *error))completionHandler{
    
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSMutableURLRequest *request = [manager.requestSerializer
                                    multipartFormRequestWithMethod:@"POST"
                                    URLString:urlString
                                    parameters:parameters
                                    constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                                        [formData appendPartWithFileData:sourceData name:@"Filedata" fileName:@"file123123" mimeType:mimeType];
                                    } error:nil];
    
    NSURLSessionUploadTask *tak = [manager uploadTaskWithStreamedRequest:request progress:downloadProgress completionHandler:completionHandler];
    [tak resume];
    
    return tak;
}
@end
