//
//  ZGDownLoadUtil.m
//  MyBoRuiSi
//
//  Created by Catskiy on 2016/10/14.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "ZGDownLoadUtil.h"


@interface ZGDownLoadUtil ()<NSURLConnectionDataDelegate>

@property (nonatomic, copy) void(^completion)(BOOL isComplete);

@end

@implementation ZGDownLoadUtil

- (void)downLoadFileWithUrl:(NSURL *)url completion:(void(^)(BOOL isComplete))completion
{
    _completion = completion;
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection connectionWithRequest:request delegate:self];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // 文件路径
    NSString* ceches = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString* filepath = [ceches stringByAppendingPathComponent:response.suggestedFilename];
    WLLog(@"===================%@",filepath);
    // 创建一个空的文件到沙盒中
    NSFileManager* mgr = [NSFileManager defaultManager];
    [mgr createFileAtPath:filepath contents:nil attributes:nil];
    
    // 创建一个用来写数据的文件句柄对象
    self.writeHandle = [NSFileHandle fileHandleForWritingAtPath:filepath];
    
    // 获得文件的总大小
    self.totalLength = response.expectedContentLength;
    
}

/**
 *  2.当接收到服务器返回的实体数据时调用（具体内容，这个方法可能会被调用多次）
 *
 *  @param data       这次返回的数据
 */
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // 移动到文件的最后面
    [self.writeHandle seekToEndOfFile];
    
    // 将数据写入沙盒
    [self.writeHandle writeData:data];
    
    // 累计写入文件的长度
    self.currentLength += data.length;
}

/**
 *  3.加载完毕后调用（服务器的数据已经完全返回后）
 */
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    self.currentLength = 0;
    self.totalLength = 0;
    
    // 关闭文件
    [self.writeHandle closeFile];
    self.writeHandle = nil;
    
    self.completion ? self.completion(YES) : nil;
}

+ (BOOL)hadDownloadFile:(NSString *)fileUrlStr
{
    NSString *fileName = [fileUrlStr lastPathComponent];
    NSFileManager *file_manager = [NSFileManager defaultManager];
    return [file_manager fileExistsAtPath:[self get_filename:fileName]];
}


+ (NSString *)get_filename:(NSString *)name
{
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
            stringByAppendingPathComponent:name];
}



@end
