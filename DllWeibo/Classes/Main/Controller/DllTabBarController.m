//
//  DllTabBarController.m
//  DllWeibo
//
//  Created by zcdll on 16/5/6.
//  Copyright © 2016年 ZC. All rights reserved.
//

#import "DllTabBarController.h"
#import "UIImage+Image.h"
#import "DllTabBar.h"

#import "DllProfileViewController.h"
#import "DllHomeViewController.h"
#import "DllMessageViewController.h"
#import "DllDiscoverViewController.h"

#import "DllNavigationController.h"
#import "DllUserTool.h"
#import "DllUserResult.h"
#import "DllComposeViewController.h"

@interface DllTabBarController ()<DllTabBarDelegate>

@property (nonatomic, strong) NSMutableArray *items;

@property (nonatomic, weak) DllHomeViewController *home;

@property (nonatomic, weak) DllMessageViewController *message;

@property (nonatomic, weak) DllProfileViewController *profile;

@end

//Item:就是苹果的模型命名规范
//tabBarItem:决定着tabBars上按钮的内容

//iOS7之后，默认会把UITabBar上面的按钮图片渲染成蓝色

@implementation DllTabBarController

//when:程序一启动的时候就会把所有的类加载进内存
//作用:加载类的时候调用
//+(void)load{
//    
//    
//    
//}

//什么时候调用：当第一次使用这个类或者子类的时候调用
//作用：初始化类
//+ (void)initialize{
//    
//    //获取当前这个类下面所有的tabBarItem外观标识
//    //self -> DllTabBarController
//    UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];
//    
//    NSMutableDictionary *att = [NSMutableDictionary dictionary];
//    
//    att[NSForegroundColorAttributeName] = [UIColor orangeColor];
//    //[att setObject:[UIColor orangeColor] forKey:NSForegroundColorAttributeName];
//    
//    [item setTitleTextAttributes:att forState:UIControlStateSelected];
//
//    
//    
//}

-(NSMutableArray *)items{
    
    if (_items == nil) {
        
        _items = [NSMutableArray array];
        
    }
    return _items;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //创建所有子控制器
    [self setUpAllChildViewController];
    
    // 自定义tabBar
    [self setUpTabBar];
    
    // 每隔一段时间请求未读数
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(requestUnread) userInfo:nil repeats:YES];
    
    

}
/**
 * 请求微博的未读数
 */
-(void)requestUnread{
    
    
    [DllUserTool unreadWithSuccess:^(DllUserResult *result) {
        
        // 设置首页的未读数
        _home.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",result.status];
        
        // 设置消息的未读数
        _message.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",result.messageCount];
        
        // 设置我的未读数
        _profile.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",result.follower];
        
        // 设置应用程序所有的未读数
        [UIApplication sharedApplication].applicationIconBadgeNumber = result.totalCount;
        
    } failure:^(NSError *error) {
        
        
        
    }];
    
}

#pragma mark - 设置tabBar
-(void)setUpTabBar{
    
    //自定义TabBar
    DllTabBar *tabBar = [[DllTabBar alloc] initWithFrame:self.tabBar.bounds];
    tabBar.backgroundColor = [UIColor whiteColor];
    
    //设置代理
    tabBar.delegate = self;
    
    //给tabBar传递tabBarItem模型
    tabBar.items = self.items;
    
    //添加自定义tabBar
    [self.tabBar addSubview:tabBar];
    
    
    
    
    
    //移除系统的tabBar
    //[self.tabBar removeFromSuperview];
    
    //利用KVC把readonly的属性修改
    //[self setValue:tabBar forKey:@"tabBar"];
    //objc_msgSend(self, @selector(setTabBar:),tabBar);
    
}

#pragma mark - 当点击tabBar上的按钮调用
-(void)tabBar:(DllTabBar *)tabBar didClickButton:(NSInteger)index{
    
    if (index == 0 && self.selectedIndex == index) {
        //NSLog(@"1111%s",__func__);
        [_home refresh];
        //NSLog(@"2222%s",__func__);
    }
    
    self.selectedIndex = index;
    
}

// 点击加号按钮的时候调用
- (void)tabBarDidPlusButton:(DllTabBar *)tabBar{
    
    // 创建发送微博控制器
    DllComposeViewController *composeVc = [[DllComposeViewController alloc] init];
    
    DllNavigationController *nav = [[DllNavigationController alloc] initWithRootViewController:composeVc];
    
    [self presentViewController:nav animated:YES completion:nil];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    // 移除系统的tabBarButton
    for (UIView *tabBarButton in self.tabBar.subviews) {
        
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            
            [tabBarButton removeFromSuperview];
            
        }
        
    }
    
}

#pragma mark - 添加所有的子控制器
-(void)setUpAllChildViewController{
    
    //首页
    DllHomeViewController *home = [[DllHomeViewController alloc] init];
    
    [self setUpOneChildViewController:home image:[UIImage imageNamed:@"tabbar_home"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_home_selected"] title:@"首页"];
    
    //home.tabBarItem.badgeValue = @"10";
    
    _home = home;
    
    
    
    
    //消息
    DllMessageViewController *message = [[DllMessageViewController alloc] init];
    
    [self setUpOneChildViewController:message image:[UIImage imageNamed:@"tabbar_message_center"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_message_center_selected"] title:@"消息"];
    _message = message;
    
    
    //发现
    DllDiscoverViewController *discover = [[DllDiscoverViewController alloc] init];
    
    [self setUpOneChildViewController:discover image:[UIImage imageNamed:@"tabbar_discover"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_discover_selected"] title:@"发现"];
    
    
    
    //我
    DllProfileViewController *profile = [[DllProfileViewController alloc] init];
    
    [self setUpOneChildViewController:profile image:[UIImage imageNamed:@"tabbar_profile"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_profile_selected"] title:@"我"];
    _profile = profile;
    
    
    
}

#pragma mark - 添加一个子控制器
-(void)setUpOneChildViewController:(UIViewController *)vc image:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSString *)title{
    
    //vc.tabBarItem.title = title;
    vc.title = title;
    
    vc.tabBarItem.image = image;
    
    //vc.tabBarItem.badgeValue = @"10";
    
    vc.tabBarItem.selectedImage = selectedImage;
    
    //保存tabBarItem模型到数组
    [self.items addObject:vc.tabBarItem];
    
    //[self addChildViewController:vc];
    
    DllNavigationController *nav = [[DllNavigationController alloc] initWithRootViewController:vc];
    
    [self addChildViewController:nav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
