//
//  UIBarButtonItem+Item.h
//  DllWeibo
//
//  Created by zcdll on 16/5/8.
//  Copyright © 2016年 ZC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Item)


+(UIBarButtonItem *)barButtonItemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

@end
