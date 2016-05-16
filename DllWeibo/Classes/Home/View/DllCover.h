//
//  DllCover.h
//  DllWeibo
//
//  Created by zcdll on 16/5/8.
//  Copyright © 2016年 ZC. All rights reserved.
//

#import "UIKit/UIKit.h"

//代理什么时候用，一般自定义控件的时候都用代理
//为什么？因为一个控件定义以后可能要扩充新的功能，为了程序的扩展性，一般用代理

@class DllCover;
@protocol DllCoverDelegate <NSObject>

@optional
// 点击蒙版的时候调用
-(void)coverDidClickCover:(DllCover *)cover;

@end

@interface DllCover : UIView

/**
 *  显示蒙版
 */
+(instancetype)show;

//设置浅灰色蒙版
@property (nonatomic, assign) BOOL dimBackground;

@property (nonatomic, weak) id<DllCoverDelegate> delegate;


@end