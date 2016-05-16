//
//  DllUser.h
//  DllWeibo
//
//  Created by zcdll on 16/5/11.
//  Copyright © 2016年 ZC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DllUser : NSObject
/**
 *  微博昵称
 */
@property (nonatomic, copy) NSString *name;
/**
 *  微博头像
 */
@property (nonatomic, strong) NSURL *profile_image_url;
/**
 *  会员类型，>2代表是会员
 */
@property (nonatomic, assign) int mbtype;
/**
 *  会员等级
 */
@property (nonatomic, assign) int mbrank;
/**
 *  判断VIP的标志
 */
@property (nonatomic, assign, getter = isVip) BOOL vip;
@end
