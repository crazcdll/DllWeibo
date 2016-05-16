//
//  DllComposeTool.m
//  DllWeibo
//
//  Created by zcdll on 16/5/15.
//  Copyright © 2016年 ZC. All rights reserved.
//

#import "DllComposeTool.h"
#import "DllHttpTool.h"
#import "DllComposeParam.h"
#import "MJExtension.h"
#import "AFNetworking.h"
#import "DllUploadParam.h"

@implementation DllComposeTool

#pragma mark - 发送文字微博
+(void)composeWithStatus:(NSString *)status success:(void (^)())success failure:(void (^)(NSError *))failure{
    
    DllComposeParam *param = [DllComposeParam param];
    param.status = status;
    
    [DllHttpTool POST:@"https://api.weibo.com/2/statuses/update.json" parameters:param.mj_keyValues success:^(id responseObject) {
        
        if (success) {
            success();
        }
        
    } failure:^(NSError *error) {
        
        if (failure) {
            failure(error);
        }
        
    }];
}

#pragma mark - 发送图片微博
+(void)composeWithPics:(NSString *)status image:(id)image success:(void (^)())success failure:(void (^)(NSError *))failure{
    
    // 创建参数模型
    DllComposeParam *param = [DllComposeParam param];
    param.status = status;
    
    // 创建上传模型
    DllUploadParam *uploadP = [[DllUploadParam alloc] init];
    uploadP.data = UIImagePNGRepresentation(image);
    uploadP.name = @"pic";
    uploadP.fileName = @"image.png";
    uploadP.mimeType = @"image/png";
    
    // 注意：如果一个方法要传很多参数，就把参数包装成一个模型
    [DllHttpTool Upload:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:param.mj_keyValues uploadParam:uploadP success:^(id responseObject) {
        
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
