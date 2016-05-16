//
//  DllStatusResult.h
//  DllWeibo
//
//  Created by zcdll on 16/5/12.
//  Copyright © 2016年 ZC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface DllStatusResult : NSObject<MJKeyValue>
/**
 *  用户的微博数组（DllStatus）
 */
@property (nonatomic, strong) NSArray *statuses;
/**
 *  用户最近的微博总数
 */
@property (nonatomic, assign) int total_number;

@end
