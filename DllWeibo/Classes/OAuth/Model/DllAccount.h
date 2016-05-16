//
//  DllAccount.h
//  DllWeibo
//
//  Created by zcdll on 16/5/10.
//  Copyright © 2016年 ZC. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  "access_token" = "2.00ixpd3BcuauZB30711e53140NKu6n";
 "expires_in" = 157679999;
 "remind_in" = 157679999;
 uid = 1250706762;
 */
@interface DllAccount : NSObject<NSCoding>
/**
 *  获取数据的访问命令牌
 */
@property (nonatomic, copy) NSString *access_token;
/**
 *  账号的有效期
 */
@property (nonatomic, copy) NSString *expires_in;
/**
 *  账号的有效期
 */
@property (nonatomic, copy) NSString *remind_in;
/**
 *  用户的唯一标示符
 */
@property (nonatomic, copy) NSString *uid;
/**
 *  过期时间 = 当前保存时间 + 有效期
 */
@property (nonatomic, strong) NSDate *expires_date;

+(instancetype) accountWithDict:(NSDictionary *)dict;



@end
