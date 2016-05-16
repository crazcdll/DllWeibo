//
//  DllUserResult.h
//  DllWeibo
//
//  Created by zcdll on 16/5/12.
//  Copyright © 2016年 ZC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DllUserResult : NSObject
/**
 *  新微博未读数
 */
@property (nonatomic, assign) int status;
/**
 *  新粉丝数
 */
@property (nonatomic, assign) int follower;
/**
 *  新评论数
 */
@property (nonatomic, assign) int cmt;
/**
 *  新私信数
 */
@property (nonatomic, assign) int dm;
/**
 *  新提及我的微博数
 */
@property (nonatomic, assign) int mention_status;
/**
 *  新提及我的评论数
 */
@property (nonatomic, assign) int mention_cmt;
/**
 *  消息的总和
 *
 *  @return cmt + dm + mention_status + mention_cmt;
 */
- (int)messageCount;
/**
 *  未读数综合
 *
 *  @return messageCount + status + follower
 */
- (int)totalCount;

@end
