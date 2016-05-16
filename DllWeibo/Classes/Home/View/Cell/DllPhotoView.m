//
//  DllPhotoView.m
//  DllWeibo
//
//  Created by zcdll on 16/5/15.
//  Copyright © 2016年 ZC. All rights reserved.
//

#import "DllPhotoView.h"
#import "UIView+Frame.h"
#import "UIImageView+WebCache.h"
#import "DllPhoto.h"

@interface DllPhotoView()

@property (nonatomic, weak) UIImageView *gifView;

@end

@implementation DllPhotoView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.userInteractionEnabled = YES;
        // 裁剪图片，超出控件的部分裁掉
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
        UIImageView *gifView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_image_gif"]];
        [self addSubview:gifView];
        _gifView = gifView;
        
    }
    return self;
}

- (void)setPhoto:(DllPhoto *)photo{
    
    _photo = photo;
    // 赋值
    [self sd_setImageWithURL:photo.thumbnail_pic placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    // 判断是否是gif图片
    NSString *urlStr = photo.thumbnail_pic.absoluteString;
    if ([urlStr hasSuffix:@".gif"]) {
        
        self.gifView.hidden = NO;
        
    } else {
        self.gifView.hidden = YES;
    }
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    // 设置gif的位置
    self.gifView.x = self.width - self.gifView.width;
    self.gifView.y = self.height - self.gifView.height;
    
}

@end
