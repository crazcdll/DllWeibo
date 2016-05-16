//
//  DllPhotosView.m
//  DllWeibo
//
//  Created by zcdll on 16/5/15.
//  Copyright © 2016年 ZC. All rights reserved.
//

#import "DllPhotosView.h"
#import "DllPhoto.h"
#import "UIImageView+WebCache.h"
#import "Dll.pch"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "DllPhotoView.h"


@implementation DllPhotosView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        // 添加9个子控件
        [self setUpAllChildView];
        
    }
    return self;
}

// 添加9个子控件
- (void)setUpAllChildView{
    
    for (int i = 0; i < 9; i++) {
        
        DllPhotoView *imageV = [[DllPhotoView alloc] init];
                imageV.tag = i;
        
        // 添加点按手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [imageV addGestureRecognizer:tap];
        
        [self addSubview:imageV];
        
    }
    
}

- (void)tap:(UITapGestureRecognizer *)tap{
    
    UIImageView *tapView = tap.view;
    // DllPhoto -> MJPhoto
    int i = 0;
    NSMutableArray *arrM = [NSMutableArray array];
    for (DllPhoto *photo in _pic_urls) {
        
        MJPhoto *p = [[MJPhoto alloc] init];
        NSString *urlStr = photo.thumbnail_pic.absoluteString;
        urlStr = [urlStr stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        p.url = [NSURL URLWithString:urlStr];
        p.index = i;
        p.srcImageView = tapView;
        
        [arrM addObject:p];
        
        i++;
    }
    
    
    // 弹出图片浏览器
    // 创建浏览器对象
    MJPhotoBrowser *brower = [[MJPhotoBrowser alloc] init];
    brower.photos = arrM;
    brower.currentPhotoIndex = tapView.tag;
    [brower show];
    
    
}

- (void)setPic_urls:(NSArray *)pic_urls{
    
    _pic_urls = pic_urls;
    
    int count = (int)self.subviews.count;
    for (int i = 0; i < count; i++) {
        
        DllPhotoView *imageV = self.subviews[i];
        
        if (i < pic_urls.count) { // 显示
            
            imageV.hidden = NO;
            
            // 获取DllPhoto模型
            DllPhoto *photo = _pic_urls[i];
            
            imageV.photo = photo;
            
            
        }else{ // 隐藏
            
            imageV.hidden = YES;
            
        }
        
    }
    
}

// 计算尺寸
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = 100;
    CGFloat h = 100;
    int col = 0;
    int row = 0;
    int cols = _pic_urls.count==4?2:3;
    
    
    // 计算需要显示出来的imageView
    for (int i = 0; i < _pic_urls.count; i++) {
        
        col = i % cols;
        row = i / cols;
        UIImageView *imageV = self.subviews[i];
        x = col * (w + DllStatusCellMargin);
        y = row * (h + DllStatusCellMargin);
        imageV.frame = CGRectMake(x, y, w, h);
        
    }
    
}

@end
