//
//  DllTextView.m
//  DllWeibo
//
//  Created by zcdll on 16/5/15.
//  Copyright © 2016年 ZC. All rights reserved.
//

#import "DllTextView.h"
#import "UIView+Frame.h"

@interface DllTextView()

@property (nonatomic, weak) UILabel *placeHolderLabel;

@end

@implementation DllTextView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.font = [UIFont systemFontOfSize:12];
        
    }
    return self;
}

- (UILabel *)placeHolderLabel{
    
    if (_placeHolder == nil) {
        
        UILabel *label = [[UILabel alloc] init];
        
        [self addSubview:label];
        
        _placeHolderLabel = label;
        
    }
    return _placeHolderLabel;
}

- (void)setFont:(UIFont *)font{
    
    [super setFont:font];
    self.placeHolderLabel.font = font;
    [self.placeHolderLabel sizeToFit];
    
}

- (void)setPlaceHolder:(NSString *)placeHolder{
    
    _placeHolder = placeHolder;
    
    self.placeHolderLabel.text = placeHolder;
    
    // label的尺寸跟文字一样
    [self.placeHolderLabel sizeToFit];
    
}

- (void)setHidePlaceHolder:(BOOL)hidePlaceHolder{
    
    _hidePlaceHolder = hidePlaceHolder;
    
    self.placeHolderLabel.hidden = hidePlaceHolder;
    
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.placeHolderLabel.x = 5;
    self.placeHolderLabel.y = 8;
    
}

@end
