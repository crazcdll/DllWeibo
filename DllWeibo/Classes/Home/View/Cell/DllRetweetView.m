//
//  DllRetweetView.m
//  DllWeibo
//
//  Created by zcdll on 16/5/13.
//  Copyright © 2016年 ZC. All rights reserved.
//

#import "DllRetweetView.h"
#import "DllStatusFrame.h"
#import "DllStatus.h"
#import "Dll.pch"
#import "DllPhotosView.h"

@interface DllRetweetView()

@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *textLabel;
@property (nonatomic, weak) DllPhotosView *photosView;

@end

@implementation DllRetweetView

- (instancetype) initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        // 添加所有子控件
        [self setUpAllChildView];
        self.userInteractionEnabled = YES;
        self.image = [UIImage imageWithStretchableName:@"timeline_retweet_background"];
        
    }
    return self;
}

- (void)setUpAllChildView{
 
    // 昵称
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = DllNameFont;
    nameLabel.textColor = [UIColor blueColor];
    [self addSubview:nameLabel];
    _nameLabel = nameLabel;
    
    // 正文
    UILabel *textLabel = [[UILabel alloc] init];
    textLabel.font = DllTextFont;
    textLabel.numberOfLines = 0;
    [self addSubview:textLabel];
    _textLabel = textLabel;
    
    // 配图
    DllPhotosView *photosView = [[DllPhotosView alloc] init];
    [self addSubview:photosView];
    _photosView = photosView;
}

- (void)setStatusF:(DllStatusFrame *)statusF{
    
    _statusF = statusF;
    
    DllStatus *status = statusF.status;
    
    // 昵称
    _nameLabel.frame = statusF.retweetNameFrame;
//    _nameLabel.text = [NSString stringWithFormat:@"@%@", status.retweeted_status.user.name];
    _nameLabel.text = status.retweetName;
    
    // 正文
    _textLabel.frame = statusF.retweetTextFrame;
    _textLabel.text = status.retweeted_status.text;
    
    // 配图
    _photosView.frame = _statusF.retweetPhotosFrame;
    _photosView.pic_urls = status.retweeted_status.pic_urls;
}

@end
