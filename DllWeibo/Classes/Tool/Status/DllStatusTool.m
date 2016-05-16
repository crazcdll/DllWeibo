//
//  DllStatusTool.m
//  DllWeibo
//
//  Created by zcdll on 16/5/11.
//  Copyright © 2016年 ZC. All rights reserved.
//

#import "DllStatusTool.h"
#import "DllHttpTool.h"
#import "DllAccountTool.h"
#import "DllStatus.h"
#import "DllAccount.h"
#import "DllStatusParam.h"
#import "MJExtension.h"
#import "DllStatusResult.h"

@implementation DllStatusTool

+ (void)newStatusWithSinceID:(NSString *)sinceId success:(void (^)(NSArray *))success failure:(void (^)(NSArray *))failure{
    
    // 创建参数模型
    DllStatusParam *param = [[DllStatusParam alloc] init];
    param.access_token = [DllAccountTool account].access_token;
    
    // 创建一个参数字典
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"access_token"] = [DllAccountTool account].access_token;
    
    if (sinceId) {  // 有微博数据，才需要下拉刷新
        
        param.since_id = sinceId;
        
    }
    
    [DllHttpTool GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:param.mj_keyValues success:^(id responseObject) {  // HttpTool请求成功的回调
        
        //请求成功代码先保存
        
        DllStatusResult *result = [DllStatusResult mj_objectWithKeyValues:responseObject];
        
        // 获取到微博数据，转换成模型
        // 获取微博字典数组
//        NSArray *dictArr = responseObject[@"statuses"];
        // 把字典数组转换为模型数组
//        NSArray *statuses = (NSMutableArray *)[DllStatus mj_objectArrayWithKeyValuesArray:dictArr];
        
//        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, statuses.count)];
        
        if (success) {
            
            success(result.statuses);
            
        }
        
    } failure:^(NSError *error) {
        
        // 请求失败的回调
        if (failure) {
            
            failure(error);
            
        }
    }];
}

+ (void)moreStatusWithMaxID:(NSString *)maxId success:(void (^)(NSArray *))success failure:(void (^)(NSArray *))failure{
    
    DllStatusParam *param = [[DllStatusParam alloc] init];
    param.access_token = [DllAccountTool account].access_token;
    // 创建一个参数字典
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"access_token"] = [DllAccountTool account].access_token;
    
    if (maxId) {  // 有微博数据，才需要下拉刷新
        
        param.max_id = maxId;
        
    }
    
    [DllHttpTool GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:param.mj_keyValues success:^(id responseObject) {  // HttpTool请求成功的回调
        
        //请求成功代码先保存
        
        DllStatusResult *result = [DllStatusResult mj_objectWithKeyValues:responseObject];
        // 获取到微博数据，转换成模型
//        // 获取微博字典数组
//        NSArray *dictArr = responseObject[@"statuses"];
//        // 把字典数组转换为模型数组
//        NSArray *statuses = (NSMutableArray *)[DllStatus mj_objectArrayWithKeyValuesArray:dictArr];
//        
//        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, statuses.count)];
        
        if (success) {
            
            success(result.statuses);
            
            
        }
        
    } failure:^(NSError *error) {
        
        // 请求失败的回调
        if (failure) {
            
            failure(error);
            
        }
    }];
}
@end
