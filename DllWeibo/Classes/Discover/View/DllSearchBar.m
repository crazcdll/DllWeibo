//
//  DllSearchBar.m
//  DllWeibo
//
//  Created by zcdll on 16/5/9.
//  Copyright © 2016年 ZC. All rights reserved.
//

#import "DllSearchBar.h"
#import "UIImage+Image.h"
#import "UIView+Frame.h"

@implementation DllSearchBar

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        // 创建搜索框
        
        self.font = [UIFont boldSystemFontOfSize:13];
        
        self.background = [UIImage imageWithStretchableName:@"searchbar_textfield_background"];
        
        // 设置搜索框左边的view
        UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
        imageV.width += 10;
        imageV.contentMode = UIViewContentModeCenter;
        self.leftView = imageV;
        
        // 一定要设置，想要显示搜索框左边的视图，一定要设置左边试图的模式
        self.leftViewMode = UITextFieldViewModeAlways;
        
    }
    return self;
}

@end
