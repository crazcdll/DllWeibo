//
//  UIImage+Image.h
//  DllWeibo
//
//  Created by zcdll on 16/5/7.
//  Copyright © 2016年 ZC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Image)
//instancetype 默认会识别当前是哪个类或者对象调用，就会转换成对应的类的对象
//UImage *
+(instancetype)imageWithOriginalName:(NSString *)imageName;

+(instancetype)imageWithStretchableName:(NSString *)imageName;

@end
