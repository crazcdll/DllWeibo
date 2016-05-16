//
//  DllBaseParam.m
//  DllWeibo
//
//  Created by zcdll on 16/5/12.
//  Copyright © 2016年 ZC. All rights reserved.
//

#import "DllBaseParam.h"
#import "DllAccountTool.h"
#import "DllAccount.h"

@implementation DllBaseParam

+(instancetype)param{
    
    DllBaseParam *param = [[self alloc] init];
    
    param.access_token = [DllAccountTool account].access_token;
    
    return param;
    
}

@end
