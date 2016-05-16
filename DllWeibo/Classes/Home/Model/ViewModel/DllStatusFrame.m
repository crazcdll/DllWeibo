//
//  DllStatusFrame.m
//  DllWeibo
//
//  Created by zcdll on 16/5/13.
//  Copyright © 2016年 ZC. All rights reserved.
//

#import "DllStatusFrame.h"
#import "DllStatus.h"
#import "DllUser.h"
#import "Dll.pch"


@implementation DllStatusFrame

-(void)setStatus:(DllStatus *)status{
    
    _status = status;
    
    // 计算原创微博
    [self setUpOriginalViewFrame];
    
    CGFloat toolBarY = CGRectGetMaxY(_originalViewFrame);
    
    if (status.retweeted_status) {
        
        // 计算转发微博
        [self setUpRetweetViewFrame];
        toolBarY = CGRectGetMaxY(_retweetViewFrame);
    }
    
    // 计算工具条
    CGFloat toolBarX = 0;
    CGFloat toolBarW = DllScreenW;
    CGFloat toolBarH = 35;
    _toolBarFrame = CGRectMake(toolBarX, toolBarY - 2, toolBarW, toolBarH);
    
    // 计算cell高度
    _cellHeight = CGRectGetMaxY(_toolBarFrame);
}

#pragma mark - 计算原创微博
- (void)setUpOriginalViewFrame{
    
    // 头像frame
    CGFloat imageX = DllStatusCellMargin;
    CGFloat imageY = DllStatusCellMargin + 10;
    CGFloat imageWH = 35;
    _originalIconFrame = CGRectMake(imageX, imageY, imageWH, imageWH);
    
    // 昵称frame
    // 这个长度也有问题，如果很长就不行了。
    CGFloat nameX = CGRectGetMaxX(_originalIconFrame) + DllStatusCellMargin;
    CGFloat nameY = imageY;
//    CGSize nameSize = [_status.user.name sizeWithFont:DllNameFont];
    CGSize nameSize = [_status.user.name sizeWithAttributes:@{NSFontAttributeName:DllNameFont}];
    _originalNameFrame = (CGRect){{nameX, nameY}, nameSize};
    
    // vipframe
    if (_status.user.vip) {
        
        CGFloat vipX = CGRectGetMaxX(_originalNameFrame) + DllStatusCellMargin;
        CGFloat vipY = imageY;
        CGFloat vipWH = 14;
        _originalVipFrame = CGRectMake(vipX, vipY, vipWH, vipWH);
        
    }
    // 不能这么只算一次，需要每次都计算。因为每次的时间和来源label的frame都不一样。
    // 时间frame
//    CGFloat timeX = nameX;
//    CGFloat timeY = CGRectGetMaxY(_originalNameFrame) + DllStatusCellMargin * 0.5;
//    CGSize timeSize = [_status.created_at sizeWithAttributes:@{NSFontAttributeName:DllTimeFont}];
//    _originalTimeFrame = (CGRect){{timeX, timeY}, timeSize};
    
    // 来源frame
//    CGFloat sourceX = CGRectGetMaxX(_originalTimeFrame) + DllStatusCellMargin;
//    CGFloat sourceY = timeY;
//    CGSize sourceSize = [_status.source sizeWithAttributes:@{NSFontAttributeName:DllSourceFont}];
//    _originalSourceFrame = (CGRect){{sourceX, sourceY}, sourceSize};
    
    // 正文frame
    CGFloat textX = imageX;
    CGFloat textY = CGRectGetMaxY(_originalIconFrame) + DllStatusCellMargin;
    CGFloat screenW = DllScreenW;
    CGFloat textW = screenW - 2 * DllStatusCellMargin;
    //CGSize textSize = [_status.text sizeWithAttributes:@{NSFontAttributeName:DllTextFont} boundingRectWithSize];
    
    // iOS7之后只能使用 boundingRectWithSize 方法获取label或者控件的大小。
    // 或者使用 sizeWithAttributes 方法
    // sizeWithFont 和 constrainedToSize:CGSizeMake 方法都已经不支持
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:_status.text];
    
    NSRange allRange = [_status.text rangeOfString:_status.text];
    
    [attrStr addAttribute:NSFontAttributeName value:DllTextFont range:allRange];
    
    [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:allRange];
    
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    
    CGRect textSize = [attrStr boundingRectWithSize:CGSizeMake(textW, MAXFLOAT) options:options context:nil];
    _originalTextFrame = CGRectMake(textX, textY, textSize.size.width, textSize.size.height);
    
    CGFloat originH = CGRectGetMaxY(_originalTextFrame) + DllStatusCellMargin;
    
    // 配图
    if (_status.pic_urls.count) {
        
        CGFloat photosX = DllStatusCellMargin;
        CGFloat photosY = CGRectGetMaxY(_originalTextFrame) + DllStatusCellMargin;
        
        CGSize photosSize = [self photosSizeWithCount:(int)_status.pic_urls.count];
        _originalPhotosFrame = (CGRect){{photosX, photosY}, photosSize};
        
        originH = CGRectGetMaxY(_originalPhotosFrame) + DllStatusCellMargin;
    }
    
    
    // 原创微博的frame
    CGFloat originX = 0;
    CGFloat originY = 10;
    CGFloat originW = DllScreenW;
    
    _originalViewFrame = CGRectMake(originX, originY, originW, originH);
    
    
}

#pragma mark - 计算配图的尺寸
- (CGSize)photosSizeWithCount:(int)count{
    
    // 获取纵列数
    int cols = count == 4 ? 2 : 3;
    
    // 获取纵列数
    int rows = (count - 1) / cols + 1;
    
    CGFloat photoWH = 100;
    CGFloat w = cols * photoWH + (cols - 1) * DllStatusCellMargin;
    CGFloat h = rows * photoWH + (rows - 1) * DllStatusCellMargin;
    
    return CGSizeMake(w, h);
    
    
}

#pragma mark - 计算转发微博
- (void)setUpRetweetViewFrame{
    
    // 昵称frame
    CGFloat nameX = DllStatusCellMargin;
    CGFloat nameY = nameX;
    // 一定要注意是转发微博的昵称
    CGSize nameSize = [_status.retweetName sizeWithAttributes:@{NSFontAttributeName:DllNameFont}];
    _retweetNameFrame = (CGRect){{nameX, nameY}, nameSize};
    
    //正文frame
    CGFloat textX = nameX;
    CGFloat textY = CGRectGetMaxY(_retweetNameFrame) + DllStatusCellMargin;
    CGFloat textW = DllScreenW - 2 * DllStatusCellMargin;
    // 一定要注意是转发微博的正文
    //CGSize textSize = [_status.retweeted_status.text sizeWithFont:DllTextFont constrainedToSize:CGSizeMake(textW, MAXFLOAT)];
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:_status.retweeted_status.text];
    
    NSRange allRange = [_status.retweeted_status.text rangeOfString:_status.retweeted_status.text];
    
    [attrStr addAttribute:NSFontAttributeName value:DllTextFont range:allRange];
    
    [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:allRange];
    
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    
    CGRect textSize = [attrStr boundingRectWithSize:CGSizeMake(textW, MAXFLOAT) options:options context:nil];
    
    _retweetTextFrame = CGRectMake(textX, textY, textSize.size.width, textSize.size.height);
    
    CGFloat retweetH = CGRectGetMaxY(_retweetTextFrame) + DllStatusCellMargin;
    
    // 配图
    int count = (int)_status.retweeted_status.pic_urls.count;
    if (count) {
        
        CGFloat photosX = DllStatusCellMargin;
        CGFloat photosY = CGRectGetMaxY(_retweetTextFrame) + DllStatusCellMargin;
        
        CGSize photosSize = [self photosSizeWithCount:count];
        _retweetPhotosFrame = (CGRect){{photosX, photosY}, photosSize};
        
        retweetH = CGRectGetMaxY(_retweetPhotosFrame) + DllStatusCellMargin;
    }
    
    // 转发微博的frame
    CGFloat retweetX = 0;
    CGFloat retweetY = CGRectGetMaxY(_originalViewFrame);
    CGFloat retweetW = DllScreenW;
    
    _retweetViewFrame = CGRectMake(retweetX, retweetY, retweetW, retweetH);
    
    
}

@end
