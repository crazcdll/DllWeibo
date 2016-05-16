//
//  DllHttpTool.m
//  DllWeibo
//
//  Created by zcdll on 16/5/11.
//  Copyright © 2016年 ZC. All rights reserved.
// 处理网络的请求

#import "DllHttpTool.h"
#import "AFNetworking.h"
#import "DllUploadParam.h"

@implementation DllHttpTool

// get请求
/**
 *  get请求
 *  不需要返回值:1.网络的数据会延迟，并不会马上返回。
 *  异步
 */
+ (void)GET:(NSString *)URLString parameters:(id)parameters  success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure{

    // 创建请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    [mgr GET:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
       // 先把请求成功要做的事情保存到这个代码块
        if (success) {
            
            success(responseObject);
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (failure) {
            
            failure(error);
            
        }
    }];
}

+ (void)POST:(NSString *)URLString parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    // 创建请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    [mgr POST:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (success) {
            
            success(responseObject);
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (failure) {
            
            failure(error);
            
        }
    }];
}

+ (void)Upload:(NSString *)URLString parameters:(id)parameters uploadParam:(DllUploadParam *)uploadParam success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    // 创建请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    [mgr POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        [formData appendPartWithFileData:uploadParam.data name:uploadParam.name fileName:uploadParam.fileName mimeType:uploadParam.mimeType];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (success) {
            
            success(responseObject);
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (failure) {
            
            failure(error);
            
        }
    }];
}

@end
