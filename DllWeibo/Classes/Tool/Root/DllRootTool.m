//
//  DllRootTool.m
//  DllWeibo
//
//  Created by zcdll on 16/5/10.
//  Copyright © 2016年 ZC. All rights reserved.
//

#import "DllRootTool.h"
#import "DllTabBarController.h"
#import "DllNewFeatureController.h"

#define DllVersionKey @"version"

@implementation DllRootTool


// 选择根控制器
+ (void)chooseRootViewController:(UIWindow *)window{
    
    // 1.获取当前版本号
    NSString *currentVersion = [NSBundle mainBundle] .infoDictionary[@"CFBundleVersion"];
    //    NSLog(@"currentVersion---%@", currentVersion);
    
    // 2.获取上一次的版本号
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:DllVersionKey];
    //    NSLog(@"lastVersion---%@", lastVersion);
    
    // 判断当前是否有新版本
    if ([currentVersion isEqualToString:lastVersion]) { // 没有最新版本号
        
        // 创建tabBarVc
        DllTabBarController *tabBarVc = [[DllTabBarController alloc] init];
        
        // 设置窗口的根控制器
        window.rootViewController = tabBarVc;
        
        
    } else { // 有新特性版本号
        
        // 如果有新特性，进入新特性界面
        DllNewFeatureController *vc = [[DllNewFeatureController alloc] init];
        
        window.rootViewController = vc;
        
        // 保存当前的版本，用偏好设置
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:DllVersionKey];
        
        //        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        //
        //        NSString *key = [defaults valueForKey:DllVersionKey];
        //
        //        NSLog(@"key---%@",key);
    }
    
    
    //    // 如果有新特性，进入新特性界面
    //    DllNewFeatureController *vc = [[DllNewFeatureController alloc] init];
    //
    //    self.window.rootViewController = vc;
    //
    //    // 保存当前的版本，用偏好设置
    //    [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:DllVersionKey];
    
}
@end
