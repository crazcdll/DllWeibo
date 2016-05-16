//
//  DllBadgeView.m
//  DllWeibo
//
//  Created by zcdll on 16/5/8.
//  Copyright © 2016年 ZC. All rights reserved.
//

#import "DllBadgeView.h"

#define DllBadgeViewFont [UIFont systemFontOfSize:11]

@implementation DllBadgeView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.userInteractionEnabled = NO;
        
        [self setBackgroundImage:[UIImage imageNamed:@"main_badge"] forState:UIControlStateNormal];
        
        //设置字体大小
        self.titleLabel.font = DllBadgeViewFont;
        
        [self sizeToFit];
        
    }
    return self;
    
}

-(void)setBadgeValue:(NSString *)badgeValue{
    
    _badgeValue = badgeValue;
    
    //判断badgeValue是否有内容
    if (badgeValue.length == 0 || [badgeValue isEqualToString:@"0"]) { //没有内容或者空字符串，等于0
        
        self.hidden = YES;
        
    }else{
        
        self.hidden = NO;
        
    }
    
    CGSize size = [badgeValue sizeWithAttributes:@{NSFontAttributeName:DllBadgeViewFont}];
//    NSLog(@"%f--%f", size.width,self.frame.size.width);
    
    if (size.width > self.frame.size.width) { //文字的尺寸大于控件的宽度
        
        [self setImage:[UIImage imageNamed:@"new_dot"] forState:UIControlStateNormal];
        [self setTitle:nil forState:UIControlStateNormal];
        [self setBackgroundImage:nil forState:UIControlStateNormal];
        
    } else {
        [self setBackgroundImage:[UIImage imageNamed:@"main_badge"] forState:UIControlStateNormal];
        [self setTitle:badgeValue forState:UIControlStateNormal];
        [self setImage:nil forState:UIControlStateNormal];
        
    }
    
}



@end
