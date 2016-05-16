//
//  DllNewFeatureCell.h
//  DllWeibo
//
//  Created by zcdll on 16/5/10.
//  Copyright © 2016年 ZC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DllNewFeatureCell : UICollectionViewCell
@property (nonatomic, strong) UIImage *image;

// 判断是否是最后一页
- (void)setIndexPath:(NSIndexPath *)indexPath count:(int)count;
@end
