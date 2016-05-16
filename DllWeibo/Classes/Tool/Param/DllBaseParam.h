//
//  DllBaseParam.h
//  DllWeibo
//
//  Created by zcdll on 16/5/12.
//  Copyright © 2016年 ZC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DllBaseParam : NSObject

/**
 *  采用OAuth授权方式为必填参数，OAuth授权后获得。
 */
@property (nonatomic, copy) NSString *access_token;

+ (instancetype)param;

@end
