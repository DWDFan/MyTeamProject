//
//  WLFindDataHandle.m
//  MyBoRuiSi
//
//  Created by Catskiy on 2016/10/8.
//  Copyright © 2016年 itcast.com. All rights reserved.
//

#import "WLFindDataHandle.h"

@implementation WLFindDataHandle


/**
 获取讲师列表
 
 @param sort    排序类型  star 按照好评度 follow 关注量
 @param level   等级
 @param success
 @param failure
 */
+ (void)requestFindLectureListWithSort:(NSString *)sort
                                 level:(NSNumber *)level
                               success:(void (^)(id responseObject))success
                               failure:(void (^)(NSError *error))failure
{
    NSDictionary *param = @{@"sort" : [MOTool getNULLString:sort],
                            @"level" : level ? level : [NSNull null]};
    
    [MOHTTP GET:@"API/index.php?action=Teacher&do=getList" parameters:param success:^(id responseObject) {
        
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/**
 获取机构列表
 
 @param sort    排序类型 member 员工数 follow 关注
 @param gsType  企业性质
 @param success
 @param failure
 */
+ (void)requestFindInstitutionListWithSort:(NSString *)sort
                                    gsType:(NSNumber *)gsType
                                   success:(void (^)(id responseObject))success
                                   failure:(void (^)(NSError *error))failure
{
    NSDictionary *param = @{@"sort" : [MOTool getNULLString:sort],
                            @"gsType" : gsType ? gsType : [NSNull null]};
    
    [MOHTTP GET:@"API/index.php?action=Teacher&do=getJigou" parameters:param success:^(id responseObject) {
        
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}


@end
