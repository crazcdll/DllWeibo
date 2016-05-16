//
//  DllAccount.m
//  DllWeibo
//
//  Created by zcdll on 16/5/10.
//  Copyright © 2016年 ZC. All rights reserved.
//

#import "DllAccount.h"

#define DllAccountTokenKey @"token"
#define DllUidKey @"uid"
#define DllExpires_inKey @"expires"
#define DllExpires_dateKey @"date"

@implementation DllAccount

+ (instancetype)accountWithDict:(NSDictionary *)dict{
    
    DllAccount *account = [[self alloc] init];
    
    [account setValuesForKeysWithDictionary:dict];
    
    return account;
    
}

// 保存时间
-(void)setExpires_in:(NSString *)expires_in{
    
    _expires_in = expires_in;
    
    // 计算过期的时间 = 当前时间 + 有效期
    _expires_date = [NSDate dateWithTimeIntervalSinceNow:[expires_in longLongValue]];
    
}

// 归档的时候调用：告诉系统哪个属性需要归档，如何归档
-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:_access_token forKey:DllAccountTokenKey];
    [aCoder encodeObject:_uid forKey:DllUidKey];
    [aCoder encodeObject:_expires_in forKey:DllExpires_inKey];
    [aCoder encodeObject:_expires_date forKey:DllExpires_dateKey];
    
}

// 解档的时候调用：告诉系统哪个属性需要解档，如何解档
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        
        // 一定要记得赋值
        _access_token = [coder decodeObjectForKey:DllAccountTokenKey];
        
        _expires_in = [coder decodeObjectForKey:DllExpires_inKey];
        
        _uid = [coder decodeObjectForKey:DllUidKey];
        
        _expires_date = [coder decodeObjectForKey:DllExpires_dateKey];
        
    }
    return self;
}

/**
 *  KVC底层实现：遍历字典里的所有key(uid)
 一个一个获取key，会去模型里查找setKey: setUid:,直接调用这个方法，赋值 setUid:obj
 寻找有没有带下划线_key,_uid ,直接拿到属性赋值
 寻找有没有key的属性，如果有，直接赋值
 在模型里面找不到对应的Key,就会报错.
 */

@end
