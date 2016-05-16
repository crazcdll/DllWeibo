//
//  DllStatusTool.h
//  DllWeibo
//
//  Created by zcdll on 16/5/11.
//  Copyright © 2016年 ZC. All rights reserved.
//  处理微博数据

#import <Foundation/Foundation.h>

@interface DllStatusTool : NSObject
/**
 *  请求更新的微博数据
 *
 *  @param sinceId 返回比这个更大的微博数据
 *  @param success 请求成功的时候回调（statuses(DllStatus模型)）
 *  @param failure 请求失败的时候回调，错误传递为外界
 */
+(void)newStatusWithSinceID:(NSString *)sinceId success:(void(^)(NSArray *statuses))success failure:(void(^)(NSArray *error))failure;
/**
 *  <#Description#>
 *
 *  @param sinceId 返回比这个更旧(小)的数据
 *  @param success 请求成功的时候回调（statuses(DllStatus模型)）
 *  @param failure 请求失败的时候回调，错误传递为外界
 */
+(void)moreStatusWithMaxID:(NSString *)maxId success:(void(^)(NSArray *statuses))success failure:(void(^)(NSArray *error))failure;

@end
