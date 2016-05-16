//
//  DllStatusToolBar.m
//  DllWeibo
//
//  Created by zcdll on 16/5/13.
//  Copyright © 2016年 ZC. All rights reserved.
//

#import "DllStatusToolBar.h"
#import "Dll.pch"
#import "DllStatus.h"

@interface DllStatusToolBar()

@property (nonatomic, strong) NSMutableArray *btns;
@property (nonatomic, strong) NSMutableArray *divideViews;

@property (nonatomic, weak) UIButton *retweet;
@property (nonatomic, weak) UIButton *comment;
@property (nonatomic, weak) UIButton *unlike;

@end


@implementation DllStatusToolBar

- (NSMutableArray *)btns{
    
    if (_btns == nil) {
        
        _btns = [NSMutableArray array];
        
    }
    return _btns;
}

- (NSMutableArray *)divideViews{
    
    if (_divideViews == nil) {
        
        _divideViews = [NSMutableArray array];
        
    }
    return _divideViews;
}

- (instancetype) initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        // 添加所有子控件
        [self setUpAllChildView];
        self.userInteractionEnabled = YES;
        self.image = [UIImage imageWithStretchableName:@"timeline_card_bottom_background"];
        
    }
    return self;
}

- (void)setUpAllChildView{
    
    // 转发
    UIButton *retweet = [self setUpOneButton:@"转发" image:[UIImage imageNamed:@"timeline_icon_retweet"]];
    _retweet = retweet;
    
    // 评论
    UIButton *comment = [self setUpOneButton:@"评论" image:[UIImage imageNamed:@"timeline_icon_comment"]];
    _comment = comment;
    
    // 攒
    UIButton *unlike = [self setUpOneButton:@"赞" image:[UIImage imageNamed:@"timeline_icon_unlike"]];
    _unlike = unlike;
    
    for (int i = 0; i < 2; i ++) {
        
        UIImageView *divideView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_card_bottom_line"]];
        
        [self addSubview:divideView];
        [self.divideViews addObject:divideView];
        
    }
    
    
}

- (UIButton *)setUpOneButton:(NSString *)title image:(UIImage *)image{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    
    // 设置边距
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    
    [self addSubview:btn];
    
    [self.btns addObject:btn];
    
    return btn;
    
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    // 设置按钮的frame
    NSUInteger count = self.btns.count;
    CGFloat w = DllScreenW / count;
    CGFloat h = self.height;
    CGFloat x = 0;
    CGFloat y = 0;
    
    for (int i = 0; i < count; i ++) {
        
        UIButton *btn = self.btns[i];
        x = i * w;
        btn.frame = CGRectMake(x, y, w, h);
        
    }
    
    // 设置分割线的位置
    int i = 1;
    for (UIImageView *divide in self.divideViews) {
        
        UIButton *btn = self.btns[i];
        divide.x = btn.x;
        i++;
        
    }
}

- (void)setStatus:(DllStatus *)status{
    
    _status = status;
    
//    status.reposts_count = 10001;
    // 设置转发数
    [self setBtnWithTitle:_retweet title:status.reposts_count];
    
    // 设置评论数
    [self setBtnWithTitle:_comment title:status.comments_count];
    
    // 设置赞数
    [self setBtnWithTitle:_unlike title:status.attitudes_count];
    
}

// 设置按钮的标题
- (void)setBtnWithTitle:(UIButton *)btn title:(int)count{
    
    NSString *title = nil;
    
    if (count) {
        if(count > 10000) {
            
            CGFloat floatCount = count / 10000.0;
            title = [NSString stringWithFormat:@"%.1fW", floatCount];
            
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
            
        }else{
            
            title = [NSString stringWithFormat:@"%d",count];
            
        }
        
        // 设置数量
        [btn setTitle:title forState:UIControlStateNormal];
        
    }
    
}

@end
