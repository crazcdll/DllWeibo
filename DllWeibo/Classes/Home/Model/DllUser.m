//
//  DllUser.m
//  DllWeibo
//
//  Created by zcdll on 16/5/11.
//  Copyright © 2016年 ZC. All rights reserved.
//

#import "DllUser.h"

@implementation DllUser

- (void)setMbtype:(int)mbtype{
    
    _mbtype = mbtype;
    _vip = mbtype > 2;
    
}

@end
