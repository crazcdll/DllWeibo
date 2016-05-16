//
//  DllComposePhotosView.m
//  DllWeibo
//
//  Created by zcdll on 16/5/15.
//  Copyright © 2016年 ZC. All rights reserved.
//

#import "DllComposePhotosView.h"
#import "Dll.pch"

@implementation DllComposePhotosView

- (void)setImage:(UIImage *)image{
    
    _image = image;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = image;
    [self addSubview:imageView];
    
}

// 每添加一个子控件的时候会调用，特殊：如果在viewDidLoad中添加子控件，就不会调用
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    NSUInteger cols = 3;
    CGFloat wh = (self.width - (cols -1) * DllStatusCellMargin ) / cols;
    
    CGFloat x = 0;
    CGFloat y = 0;
    NSUInteger col = 0;
    NSUInteger row = 0;
    
    for (int i = 0; i < self.subviews.count; i++) {
        
        UIImageView *imageV = self.subviews[i];
        col = i % cols;
        row = i / cols;
        x = col * (DllStatusCellMargin + wh);
        y = row * (DllStatusCellMargin + wh);
        imageV.frame = CGRectMake(x, y, wh, wh);
        
    }
    
}

@end
