//
//  DllTabBar.h
//  DllWeibo
//
//  Created by zcdll on 16/5/7.
//  Copyright © 2016年 ZC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DllTabBar;

@protocol DllTabBarDelegate <NSObject>

@optional
-(void)tabBar:(DllTabBar *)tabBar didClickButton:(NSInteger)index;

/**
 *  电机加号按钮的时候调用
 *
 *  @param tabBar 传递一个按钮
 */
-(void)tabBarDidPlusButton:(DllTabBar *)tabBar;

@end

@interface DllTabBar : UIView

//@property (nonatomic, assign) NSUinteger tabBarButtonCount;
//items:保存每一个按钮对应tabBarItem模型
@property (nonatomic, strong) NSArray *items;

@property (nonatomic, weak) id<DllTabBarDelegate> delegate;

@end
