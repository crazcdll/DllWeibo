//
//  DllComposeTool.h
//  DllWeibo
//
//  Created by zcdll on 16/5/15.
//  Copyright © 2016年 ZC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DllComposeTool : NSObject

/**
 *  发送文字
 *
 *  @param status  发送的微博内容
 *  @param success 发送成功的回调
 *  @param failure 发送失败的回调
 */
+ (void)composeWithStatus:(NSString *)status success:(void(^)())success failure:(void(^)(NSError *error))failure;

/**
 *  发送图片
 *
 *  @param status  发送微博的文字内容
 *  @param image   发送微博的图片内容
 *  @param success 发送成功的回调
 *  @param failure 发送失败的回调
 */ 
+ (void)composeWithPics:(NSString *)status image:(UIImage *)image success:(void(^)())success failure:(void(^)(NSError *error))failure;

@end
