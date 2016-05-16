//
//  DllUserTool.h
//  DllWeibo
//
//  Created by zcdll on 16/5/12.
//  Copyright © 2016年 ZC. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DllUserResult, DllUser;

@interface DllUserTool : NSObject

/**
 *  请求用户的未读消息数
 *
 *  @param success 请求成功的回调
 *  @param failure 请求失败的回调
 */
+ (void)unreadWithSuccess:(void(^)(DllUserResult *result))success failure:(void(^)(NSError *error))failure;

/**
 *  请求用户的信息
 *
 *  @param success 请求成功的回调
 *  @param failure 请求失败的回调
 */
+ (void)userInfoWithSuccess:(void(^)(DllUser *user))success failure:(void(^)(NSError *error))failure;

@end
