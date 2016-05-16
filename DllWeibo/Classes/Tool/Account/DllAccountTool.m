//
//  DllAccountTool.m
//  DllWeibo
//
//  Created by zcdll on 16/5/10.
//  Copyright © 2016年 ZC. All rights reserved.
//

#import "DllAccountTool.h"
#import "DllAccount.h"
#import "DllRootTool.h"
#import "AFNetworking.h"
#import "DllHttpTool.h"
#import "DllAccountParam.h"
#import "MJExtension.h"

#define DllAccountFileName [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"account.data"]
#define DllAuthorizeBaseUrl @"https://api.weibo.com/oauth2/authorize"
#define DllClient_id @"1446792854"
#define DllRedirect_uri @"http://www.cnblogs.com/zcdll"
#define DllClient_secret @"683649178933a3776f254972ab425a67"

// 类方法中用静态变量代替成员属性
static DllAccount *_account;

@implementation DllAccountTool

+(void)saveAccount:(DllAccount *)account{
    
    [NSKeyedArchiver archiveRootObject:account toFile:DllAccountFileName];
    
}

+(DllAccount *)account{
    
    if (_account == nil) {
        
        _account = [NSKeyedUnarchiver unarchiveObjectWithFile:DllAccountFileName];
        
        // 取得时候判断账号是否过期，如果过期直接返回nil
        // 2015 2017
        if ([[NSDate date] compare:_account.expires_date]  != NSOrderedAscending) { // 过期
            
            return nil;
            
        }
        
    }
    return _account;
}

+ (void)accountWithCode:(NSString *)code success:(void (^)())success failure:(void (^)(NSError *))failure{
    
    // 创建参数模型
    DllAccountParam *param = [[DllAccountParam alloc] init];
    param.client_id = DllClient_id;
    param.client_secret = DllClient_secret;
    param.grant_type = @"authorization_code";
    param.code = code;
    param.redirect_uri = DllRedirect_uri;
    
    [DllHttpTool POST:@"https://api.weibo.com/oauth2/access_token" parameters:param.mj_keyValues success:^(id responseObject) {
        
        // 字典转模型
        DllAccount *account = [DllAccount accountWithDict:responseObject];
        
        // 保存账号信息：数据存储一般我们开发中会搞一个业务类，专门处理数据的存储
        // 以后不用归档，用数据库，直接改业务类
        
        [DllAccountTool saveAccount:account];
        
        if (success) {
            
            success();
            
        }
        
    } failure:^(NSError *error) {
        
        if (failure) {
            
            failure(error);
            
        }
    }];
}

@end
