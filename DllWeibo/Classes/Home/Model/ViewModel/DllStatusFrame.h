//
//  DllStatusFrame.h
//  DllWeibo
//
//  Created by zcdll on 16/5/13.
//  Copyright © 2016年 ZC. All rights reserved.
//  模型 + 对应空间的frame

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class DllStatus;
@interface DllStatusFrame : NSObject

/**
 *  微博数据
 */
@property (nonatomic, strong) DllStatus *status;

/**
 *  原创微博frame
 */
@property (nonatomic, assign) CGRect originalViewFrame;

/**
 *  原创微博子控件frame
 */

// 头像frame
@property (nonatomic, assign) CGRect originalIconFrame;

// 昵称frame
@property (nonatomic, assign) CGRect originalNameFrame;

// vipframe
@property (nonatomic, assign) CGRect originalVipFrame;

// 时间frame
@property (nonatomic, assign) CGRect originalTimeFrame;

// 来源frame
@property (nonatomic, assign) CGRect originalSourceFrame;

// 正文frame
@property (nonatomic, assign) CGRect originalTextFrame;

// 配图frame
@property (nonatomic, assign) CGRect originalPhotosFrame;


/**
 *  转发微博frame
 */
@property (nonatomic, assign) CGRect retweetViewFrame;

/**
 *  转发微博子控件frame
 */

// 昵称frame
@property (nonatomic, assign) CGRect retweetNameFrame;

// 正文frame
@property (nonatomic, assign) CGRect retweetTextFrame;

// 配图frame
@property (nonatomic, assign) CGRect retweetPhotosFrame;

// 工具条frame
@property (nonatomic, assign) CGRect toolBarFrame;

// cell高度
@property (nonatomic, assign) CGFloat cellHeight;

@end
