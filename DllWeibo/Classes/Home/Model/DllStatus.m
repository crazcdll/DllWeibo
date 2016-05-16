//
//  DllStatus.m
//  DllWeibo
//
//  Created by zcdll on 16/5/11.
//  Copyright © 2016年 ZC. All rights reserved.
//

#import "DllStatus.h"
#import "DllPhoto.h"
#import "MJExtension.h"
#import "NSDate+MJ.h"

@implementation DllStatus
// 实现这个方法，就会自动把数组中的字典转换成对应的模型
+(NSDictionary *)mj_objectClassInArray{
    
    return @{@"pic_urls":[DllPhoto class]};
    
}

- (NSString *)created_at{
    
    // NSLog(@"%@",_created_at);
    // Sat May 14 00:41:14 +0800 2016
    
    // 字符串转换为NSDate
//    NSLog(@"0000_created_at====%@", _created_at);
    
    //NSCalendar *calendar = [NSCalendar currentCalendar];
    //newDate = [calender]
    
    // 日期字符串格式
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    
    fmt.dateFormat = @"EEE MMM d HH:mm:ss Z yyyy";
    //[fmt setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:3600 * 8]];
//    [fmt setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    // 设置日期格式本地化，日期格式字符串
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    NSDate *created_at = [fmt dateFromString:_created_at];
    
    NSTimeInterval hoursToAddInSeconds = 8 * 3600;
    created_at = [created_at dateByAddingTimeInterval:hoursToAddInSeconds];
    //NSLog(@"newDate====%@", newDate);
    //created_at = newDate;
    
//    NSLog(@"1111created_at====%@",created_at);
    
    if ([created_at isThisYear]) { // 今年
        
        if ([created_at isToday]) { // 今天
            
            // 计算跟当前时间的差距
            NSDateComponents *cmp = [created_at deltaWithNow];
            
//            NSLog(@"%ld===%ld====", cmp.hour, cmp.minute);
            
            if (cmp.hour >= 1) {
                return [NSString stringWithFormat:@"%ld小时之前", cmp.hour];
            }else if(cmp.minute > 1){
                return [NSString stringWithFormat:@"%ld分钟之前", cmp.minute];
            }else{
                return @"刚刚";
            }
            
        } else if([created_at isYesterday]) { // 昨天
            
            fmt.dateFormat = @"昨天  HH:mm";
            return [fmt stringFromDate:created_at];
            
        } else { // 前天
            
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:created_at];
            
        }
        
    } else { // 不是今年
        
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:created_at];
    }
    
        return _created_at;
    
}

- (void)setSource:(NSString *)source{
    
    NSRange range = [source rangeOfString:@">"];
    source = [source substringFromIndex:range.location + range.length];
    range = [source rangeOfString:@"<"];
    source = [source substringToIndex:range.location];
    source = [NSString stringWithFormat:@"来自%@", source];
    
    _source = source;
}

// 给转发微博的昵称增加 @ 符号
- (void)setRetweeted_status:(DllStatus *)retweeted_status{
    
    _retweeted_status = retweeted_status;
    
    _retweetName = [NSString stringWithFormat:@"@%@",retweeted_status.user.name];
    
}

@end
