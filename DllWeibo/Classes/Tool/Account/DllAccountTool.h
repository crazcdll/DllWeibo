//
//  DllAccountTool.h
//  DllWeibo
//
//  Created by zcdll on 16/5/10.
//  Copyright © 2016年 ZC. All rights reserved.
// 专门处理账号的业务 账号存储和读取

#import <Foundation/Foundation.h>

@class DllAccount;
@interface DllAccountTool : NSObject

+(void)saveAccount:(DllAccount *)account;

+(DllAccount *)account;

+ (void)accountWithCode:(NSString *)code success:(void(^)())success failure:(void(^)(NSError *error))failure;

@end
