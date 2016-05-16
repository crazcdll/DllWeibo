//
//  DllStatus.h
//  DllWeibo
//
//  Created by zcdll on 16/5/11.
//  Copyright © 2016年 ZC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DllUser.h"
#import "MJExtension.h"
/**
 user	object	微博作者的用户信息字段 详细
 retweeted_status	object	被转发的原微博信息字段，当该微博为转发微博时返回 详细
 pic_urls 配图数组
 
 */

@interface DllStatus : NSObject<MJKeyValue>
/**
 *  微博创建时间
 */
@property (nonatomic, copy) NSString *created_at;
/**
 *  字符串型的微博ID
 */
@property (nonatomic, copy) NSString *idstr;
/**
 *  微博信息内容
 */
@property (nonatomic, copy) NSString *text;
/**
 *  微博来源
 */
@property (nonatomic, copy) NSString *source;
/**
 *  转发数
 */
@property (nonatomic, assign) int reposts_count;
/**
 *  评论数
 */
@property (nonatomic, assign) int comments_count;
/**
 *  表态数
 */
@property (nonatomic, assign) int attitudes_count;
/**
 *  配图数组(DllPhoto模型)
 */
@property (nonatomic, strong) NSArray *pic_urls;
/**
 *  用户
 */
@property (nonatomic, strong) DllUser *user;
/**
 *  转发微博
 */
@property (nonatomic, strong) DllStatus *retweeted_status;

/**
 *  转发微博昵称
 */
@property (nonatomic, copy) NSString *retweetName;

@end
