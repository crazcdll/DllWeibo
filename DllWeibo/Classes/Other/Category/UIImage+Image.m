//
//  UIImage+Image.m
//  DllWeibo
//
//  Created by zcdll on 16/5/7.
//  Copyright © 2016年 ZC. All rights reserved.
//

#import "UIImage+Image.h"

@implementation UIImage (Image)

+(instancetype)imageWithOriginalName:(NSString *)imageName{
    
    UIImage *image = [UIImage imageNamed:imageName];
    
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    
}

+(instancetype)imageWithStretchableName:(NSString *)imageName{
    
    UIImage *image = [UIImage imageNamed:imageName];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
    
}

@end
