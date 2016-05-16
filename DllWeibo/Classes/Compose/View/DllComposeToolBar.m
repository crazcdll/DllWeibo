//
//  DllComposeToolBar.m
//  DllWeibo
//
//  Created by zcdll on 16/5/15.
//  Copyright © 2016年 ZC. All rights reserved.
//

#import "DllComposeToolBar.h"
#import "UIView+Frame.h"

@implementation DllComposeToolBar

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        // 添加所有的子控件
        [self setUpAllChildView];
        
    }
    return self;
}

#pragma mark - 添加所有的子控件
- (void)setUpAllChildView{
    
    // 相册
    [self setUpButtonWithImage:[UIImage imageNamed:@"compose_toolbar_picture"] highImage:[UIImage imageNamed:@"compose_toolbar_picture_highlighted"] target:self action:@selector(btnClick:)];
    
    // @
    [self setUpButtonWithImage:[UIImage imageNamed:@"compose_mentionbutton_background"] highImage:[UIImage imageNamed:@"compose_mentionbutton_background_highlighted"] target:self action:@selector(btnClick:)];
    
    // 话题
    [self setUpButtonWithImage:[UIImage imageNamed:@"compose_trendbutton_background"] highImage:[UIImage imageNamed:@"compose_trendbutton_background_highlighted"] target:self action:@selector(btnClick:)];
    
    // 表情
    [self setUpButtonWithImage:[UIImage imageNamed:@"compose_emoticonbutton_background"] highImage:[UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"] target:self action:@selector(btnClick:)];
    
    // 键盘
    [self setUpButtonWithImage:[UIImage imageNamed:@"compose_keyboardbutton_background"] highImage:[UIImage imageNamed:@"compose_keyboardbutton_background_highlighted"] target:self action:@selector(btnClick:)];
    
}

- (void)setUpButtonWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action{
    
    //btn
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];

    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:highImage forState:UIControlStateHighlighted];
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:btn];
    
}

-(void)btnClick:(UIButton *)button{
    
    // 点击工具条的时候
    if ([_delegate respondsToSelector:@selector(composeToolBar:didClickBtn:)]) {
        
        [_delegate composeToolBar:self didClickBtn:button.tag];
        
    }
    
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    NSUInteger count = self.subviews.count;
    
    CGFloat w = self.width / count;
    CGFloat h = self.height;
    CGFloat x = 0;
    CGFloat y = 0;
    
    for (int i = 0; i < self.subviews.count ; i++) {
        
        UIButton *btn = self.subviews[i];
        
        x = i * w;
        
        btn.frame = CGRectMake(x, y, w, h);
        
    }
    
}

@end
