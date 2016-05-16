//
//  DllCover.m
//  DllWeibo
//
//  Created by zcdll on 16/5/8.
//  Copyright © 2016年 ZC. All rights reserved.
//

#import "DllCover.h"
#import "UIView+Frame.h"
#import "UIImage+Image.h"
#import "Dll.pch"

@implementation DllCover

// 设置浅灰色蒙版
-(void)setDimBackground:(BOOL)dimBackground{
    
    _dimBackground = dimBackground;
    
    if (dimBackground) {
        
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.5;

    } else {
        
        self.alpha = 1;
        self.backgroundColor = [UIColor clearColor];
        
    }
}

//显示蒙版
+(instancetype)show{
    
    DllCover *cover = [[DllCover alloc] initWithFrame:[UIScreen mainScreen].bounds];
    cover.backgroundColor = [UIColor clearColor];
    
    [DllKeyWindow addSubview:cover];
    
    return cover;
    
}

// 点击蒙版做的事情
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //移除蒙版
    [self removeFromSuperview];
    
    //通知代理移除菜单
    if ([_delegate respondsToSelector:@selector(coverDidClickCover:)]) {
        
        [_delegate coverDidClickCover:self];
        
    }
    
}

@end
