//
//  DllOriginalView.m
//  DllWeibo
//
//  Created by zcdll on 16/5/13.
//  Copyright © 2016年 ZC. All rights reserved.
//

#import "DllOriginalView.h"
#import "DllStatusFrame.h"
#import "DllStatus.h"
#import "UIImageView+WebCache.h"
#import "Dll.pch"
#import "DllPhotosView.h"

@interface DllOriginalView()

@property (nonatomic, weak) UIImageView *iconView;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UIImageView *vipView;
@property (nonatomic, weak) UILabel *timeLabel;
@property (nonatomic, weak) UILabel *sourceLabel;
@property (nonatomic, weak) UILabel *textLabel;
@property (nonatomic, weak) DllPhotosView *photosView;

@end

@implementation DllOriginalView

- (instancetype) initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        // 添加所有子控件
        [self setUpAllChildView];
        
        // 添加两个微博中间的分割区域
        self.userInteractionEnabled = YES;
        self.image = [UIImage imageNamed:@"timeline_card_top_background"];
        
    }
    return self;
}

- (void)setUpAllChildView{
    
    // 头像
    UIImageView *iconView = [[UIImageView alloc] init];
    [self addSubview:iconView];
    _iconView = iconView;
    
    // 昵称
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = DllNameFont;
    [self addSubview:nameLabel];
    _nameLabel = nameLabel;
    
    // vip
    UIImageView *vipView = [[UIImageView alloc] init];
    [self addSubview:vipView];
    _vipView = vipView;
    
    // 时间
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.font = DllTimeFont;
    [self addSubview:timeLabel];
    _timeLabel = timeLabel;
    
    // 来源
    UILabel *sourceLabel = [[UILabel alloc] init];
    sourceLabel.font = DllSourceFont;
    sourceLabel.textColor = [UIColor lightGrayColor];
    [self addSubview:sourceLabel];
    _sourceLabel = sourceLabel;
    
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
    
    // 设置frame
    [self setUpFrame];
    
    // 设置数据
    [self setUpData];

}



- (void)setUpFrame{
    
    // 头像
    _iconView.frame = _statusF.originalIconFrame;
    
    // 昵称
    _nameLabel.frame = _statusF.originalNameFrame;
    
    //vip
    if (_statusF.status.user.vip) { // 是vip
        
        _vipView.hidden = NO;
        _vipView.frame = _statusF.originalVipFrame;
        
    }else{
        
        _vipView.hidden = YES;
        
    }
    
    // 时间 每次有新的时间都需要计算时间frame
    DllStatus *status = _statusF.status;
    CGFloat timeX = _nameLabel.frame.origin.x;
    CGFloat timeY = CGRectGetMaxY(_nameLabel.frame) + DllStatusCellMargin * 0.5;
    CGSize timeSize = [status.created_at sizeWithAttributes:@{NSFontAttributeName:DllTimeFont}];
    _timeLabel.frame = (CGRect){{timeX, timeY}, timeSize};
//    _timeLabel.frame = _statusF.originalTimeFrame;
    
    // 来源 每次有新的来源都需要计算来源frame
    CGFloat sourceX = CGRectGetMaxX(_timeLabel.frame) + DllStatusCellMargin;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithAttributes:@{NSFontAttributeName:DllSourceFont}];
    _sourceLabel.frame = (CGRect){{sourceX, sourceY}, sourceSize};
//    _sourceLabel.frame = _statusF.originalSourceFrame;
    
    // 正文
    _textLabel.frame = _statusF.originalTextFrame;
    
    // 配图
    _photosView.frame = _statusF.originalPhotosFrame;
    
}

- (void)setUpData{
    
    DllStatus *status = _statusF.status;
    // 头像
    [_iconView sd_setImageWithURL:status.user.profile_image_url placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    // 昵称
    _nameLabel.text = status.user.name;
    if (status.user.vip) {
        
        _nameLabel.textColor = [UIColor redColor];
        
    }else{
        
        _nameLabel.textColor = [UIColor blackColor];
        
    }
    
    // vip
    NSString *imageName = [NSString stringWithFormat:@"common_icon_membership_level%d", status.user.mbrank];
    _vipView.image = [UIImage imageNamed:imageName];
    
    // 时间
    _timeLabel.text = status.created_at;
    _timeLabel.textColor = [UIColor orangeColor];
    
    // 来源
    _sourceLabel.text = status.source;
    
    // 正文
    _textLabel.text = status.text;

    // 配图
    _photosView.pic_urls = status.pic_urls;
    
}

@end
