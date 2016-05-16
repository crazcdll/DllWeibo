//
//  UIBarButtonItem+Item.m
//  DllWeibo
//
//  Created by zcdll on 16/5/8.
//  Copyright © 2016年 ZC. All rights reserved.
//

#import "UIBarButtonItem+Item.h"

@implementation UIBarButtonItem (Item)

+(UIBarButtonItem *)barButtonItemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents{
    
    //btn
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [btn setBackgroundImage:highImage forState:UIControlStateHighlighted];
    [btn sizeToFit];
    
    [btn addTarget:target action:action forControlEvents:controlEvents];
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
    
}

@end
