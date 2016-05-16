//
//  DllStatusResult.m
//  DllWeibo
//
//  Created by zcdll on 16/5/12.
//  Copyright © 2016年 ZC. All rights reserved.
//

#import "DllStatusResult.h"
#import "DllStatus.h"

@implementation DllStatusResult

+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"statuses":[DllStatus class]};
    
}

@end
