//
//  AppDelegate.m
//  DllWeibo
//
//  Created by zcdll on 16/5/6.
//  Copyright © 2016年 ZC. All rights reserved.
//

#import "AppDelegate.h"
#import "DllOAuthViewController.h"
#import "DllAccount.h"
#import "DllAccountTool.h"
#import "DllRootTool.h"
#import "UIImageView+WebCache.h"
#import <AVFoundation/AVFoundation.h>

@interface AppDelegate ()
@property (nonatomic, strong) AVAudioPlayer *player;
@end

@implementation AppDelegate

// 偏好设置存储的好处
// 1.不需要关心文件名
// 2.快速进行键值对存储

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 注册通知
    UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
    [application registerUserNotificationSettings:(UIUserNotificationSettings *)setting];
    /*
    Use this category for background sounds such as rain, car engine noise, etc.
    Mixes with other music.
    静音模式或者锁屏下不再播放音乐，和其他app声音混合。
    1.AVF_EXPORT NSString *const AVAudioSessionCategoryAmbient;
    
    Use this category for background sounds.  Other music will stop playing.
    默认模式，静音模式或者锁屏下不再播放音乐，不和其他app声音混合。
    2.AVF_EXPORT NSString *const AVAudioSessionCategorySoloAmbient;
    
    Use this category for music tracks.
    表示对于用户切换静音模式或者锁屏 都不理睬，继续播放音乐。
    3.AVF_EXPORT NSString *const AVAudioSessionCategoryPlayback;
    */
    
    
    // 在真机上后台播放，设置音频会话
    AVAudioSession *session = [AVAudioSession sharedInstance];
    
    // 设置会话类型（后台播放）
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    [session setCategory:AVAudioSessionCategorySoloAmbient error:nil];
    
    // 激活
    [session setActive:YES error:nil];
    
    
    // 创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
//    self.window.backgroundColor = [UIColor yellowColor];
    
    // 选择根控制器
    // 判断下有没有授权
    if ([DllAccountTool account]) { // 已经授权
        
        // 选择根控制器
        [DllRootTool chooseRootViewController:self.window];
        
    } else { // 没有授权
        
        // 进行授权
        DllOAuthViewController *oauthVc = [[DllOAuthViewController alloc] init];
        
        //设置窗口的跟控制器
        self.window.rootViewController = oauthVc;
        
    }
    
    // 显示窗口
    [self.window makeKeyAndVisible];
    
    return YES;
}

//// 选择根控制器
//-(void)chooseRootViewController{
//    
//    // 1.获取当前版本号
//    NSString *currentVersion = [NSBundle mainBundle] .infoDictionary[@"CFBundleVersion"];
//    //    NSLog(@"currentVersion---%@", currentVersion);
//    
//    // 2.获取上一次的版本号
//    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:DllVersionKey];
//    //    NSLog(@"lastVersion---%@", lastVersion);
//    
//    // 判断当前是否有新版本
//    if ([currentVersion isEqualToString:lastVersion]) { // 没有最新版本号
//        
//        // 创建tabBarVc
//        DllTabBarController *tabBarVc = [[DllTabBarController alloc] init];
//        
//        // 设置窗口的根控制器
//        self.window.rootViewController = tabBarVc;
//        
//        
//    } else { // 有新特性版本号
//        
//        // 如果有新特性，进入新特性界面
//        DllNewFeatureController *vc = [[DllNewFeatureController alloc] init];
//        
//        self.window.rootViewController = vc;
//        
//        // 保存当前的版本，用偏好设置
//        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:DllVersionKey];
//        
//        //        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//        //
//        //        NSString *key = [defaults valueForKey:DllVersionKey];
//        //
//        //        NSLog(@"key---%@",key);
//    }
//    
//    
//    //    // 如果有新特性，进入新特性界面
//    //    DllNewFeatureController *vc = [[DllNewFeatureController alloc] init];
//    //
//    //    self.window.rootViewController = vc;
//    //
//    //    // 保存当前的版本，用偏好设置
//    //    [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:DllVersionKey];
//    
//}

// 接收到内存警告的时候调用
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application{
    
    // 停止所有的下载
    [[SDWebImageManager sharedManager] cancelAll];
    // 删除缓存
    [[SDWebImageManager sharedManager].imageCache clearMemory];
    
}

// 即将失去焦点的时候调用
- (void)applicationWillResignActive:(UIApplication *)application {
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"silence.mp3" withExtension:nil];
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    [player prepareToPlay];
    player.numberOfLoops = -1;
    
    [player play];
    
    _player = player;
    
}

// 程序进入后台的时候调用
- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    // 开启一个后台任务，时间不确定，优先级比较低。
    UIBackgroundTaskIdentifier ID = [application beginBackgroundTaskWithExpirationHandler:^{
        
        //当后台任务结束的时候调用
        [application endBackgroundTask:ID];
        
    }];
    
    // 如何提高后台任务的优先级，欺骗苹果，我们是后台播放程序。
    
    // 但是苹果会检测APP当时有没有播放音乐
    
    // 微博：在程序即将失去焦点的时候播放音乐，0db，3KB的音乐，静音的音乐。
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.zcdll.DllWeibo" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"DllWeibo" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"DllWeibo.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
