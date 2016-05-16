//
//  DllPopMenu.h
//  DllWeibo
//
//  Created by zcdll on 16/5/8.
//  Copyright © 2016年 ZC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DllPopMenu : UIImageView

/**
 *  显示弹出菜单
 */
+(instancetype)showInRect:(CGRect)rect;

/**
 *  隐藏弹出菜单
 */
+(void)hide;

//内容视图
@property (nonatomic, weak) UIView *contentView;

@end
