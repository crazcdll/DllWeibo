//
//  DllUserParam.h
//  DllWeibo
//
//  Created by zcdll on 16/5/12.
//  Copyright © 2016年 ZC. All rights reserved.
//  用户未读数请求的参数模型

#import <Foundation/Foundation.h>
#import "DllBaseParam.h"

@interface DllUserParam : DllBaseParam
/**
*  当前用户登录的唯一标示符
*/
@property (nonatomic, copy) NSString *uid;

@end
