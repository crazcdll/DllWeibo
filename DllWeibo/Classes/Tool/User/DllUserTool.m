//
//  DllUserTool.m
//  DllWeibo
//
//  Created by zcdll on 16/5/12.
//  Copyright © 2016年 ZC. All rights reserved.
//  处理用户的业务，未读消息数

#import "DllUserTool.h"
#import "DllHttpTool.h"
#import "DllUserParam.h"
#import "DllUserResult.h"
#import "DllAccount.h"
#import "DllAccountTool.h"
#import "MJExtension.h"
#import "DllUser.h"

@implementation DllUserTool

+ (void)unreadWithSuccess:(void (^)(DllUserResult *))success failure:(void (^)(NSError *))failure{
    
    // 创建参数模型
    DllUserParam *param = [DllUserParam param];
    param.uid = [DllAccountTool account].uid;
    
    [DllHttpTool GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:param.mj_keyValues success:^(id responseObject) {
        
       //字典转模型
        DllUserResult *result = [DllUserResult mj_objectWithKeyValues:responseObject];
        
        if (success) {
            success(result);
        }
        
    } failure:^(NSError *error) {
        
        if (failure) {
            failure(error);
        }
        
    }];
}

+(void)userInfoWithSuccess:(void (^)(DllUser *))success failure:(void (^)(NSError *))failure{
    
    // 创建参数模型
    DllUserParam *param = [DllUserParam param];
    param.uid = [DllAccountTool account].uid;
    
    [DllHttpTool GET:@"https://api.weibo.com/2/users/show.json" parameters:param.mj_keyValues success:^(id responseObject) {
        
       // 用户字典转模型
        DllUser *user = [DllUser mj_objectWithKeyValues:responseObject];
        
        if (success) {
            
            success(user);
            
        }
        
    } failure:^(NSError *error) {
        
        if (failure) {
            
            failure(error);
            
        }
        
    }];
    
    
}

@end
