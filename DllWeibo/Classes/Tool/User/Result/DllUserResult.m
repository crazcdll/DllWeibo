//
//  DllUserResult.m
//  DllWeibo
//
//  Created by zcdll on 16/5/12.
//  Copyright © 2016年 ZC. All rights reserved.
//

#import "DllUserResult.h"

@implementation DllUserResult

- (int)messageCount{
    
    return _cmt + _dm + _mention_cmt + _mention_status;
    
}
-(int)totalCount{
    
    return self.messageCount + _status + _follower;
    
}


@end
