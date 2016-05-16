//
//  DllNavigationController.m
//  DllWeibo
//
//  Created by zcdll on 16/5/8.
//  Copyright © 2016年 ZC. All rights reserved.
//

#import "DllNavigationController.h"
#import "DllTwoViewController.h"
#import "UIBarButtonItem+Item.h"

@interface DllNavigationController ()<UINavigationControllerDelegate>

@property (nonatomic, strong) id popDelegate;

@end

@implementation DllNavigationController

+ (void)initialize
{
    //获取当前类下面的UIBarButtonItem
    UIBarButtonItem *item = [UIBarButtonItem appearanceWhenContainedIn:self, nil];
    
    //设置导航条按钮的文字颜色
    NSMutableDictionary *titleAttr = [NSMutableDictionary dictionary];
    titleAttr[NSForegroundColorAttributeName] = [UIColor orangeColor];
    titleAttr[NSFontAttributeName] = [UIFont boldSystemFontOfSize:15];
    [item setTitleTextAttributes:titleAttr forState:UIControlStateNormal];

    // 注意导航条上按钮不可用，用文字属性设置不好使
//    // 设置不可用状态下按钮的颜色
//    titleAttr = [NSMutableDictionary dictionary];
//    titleAttr[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
//    titleAttr[NSFontAttributeName] = [UIFont boldSystemFontOfSize:15];
//    [item setTitleTextAttributes:titleAttr forState:UIControlStateDisabled];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _popDelegate = self.interactivePopGestureRecognizer.delegate;
    
    self.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

//导航控制器即将显示新的控制器的时候调用
-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    // 获取主窗口
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    // 获取tabBarVc rootViewController
    UITabBarController *tabBarVc = (UITabBarController *)keyWindow.rootViewController;
    
    // 移除系统的tabBarButton
    for (UIView *tabBarButton in tabBarVc.tabBar.subviews) {
        
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            
            [tabBarButton removeFromSuperview];
            
        }
    }
}

// 导航控制器跳转完成时调用
-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
//    NSLog(@"%@", self.viewControllers[0]);
    
    if (viewController == self.viewControllers[0]) { // 显示跟控制器
        
        // 还原滑动返回手势的代理
        self.interactivePopGestureRecognizer.delegate = _popDelegate;
        
    }else{
        
        // 实现滑动返回功能
        // 清空滑动返回手势的代理，就能实现滑动功能
        self.interactivePopGestureRecognizer.delegate = nil;
        
    }
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    // 设置非跟控制器导航条的内容
    if (self.viewControllers != 0) { //非跟控制器
        
        // 设置导航条的内容
        // 设置导航条左边和右边
        // 如果把导航条上的返回按钮覆盖，返回功能就没有了
        // 左边
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_back"] highImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] target:self action:@selector(backToPre) forControlEvents:UIControlEventTouchUpInside];
        
        // 右边
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_more"] highImage:[UIImage imageNamed:@"navigationbar_more_highlighted"] target:self action:@selector(backToRoot) forControlEvents:UIControlEventTouchUpInside];

    }
    
    [super pushViewController:viewController animated:animated];
}

-(void)backToPre{
    
    [self popViewControllerAnimated:YES];
    
}

-(void)backToRoot{
    
    [self popToRootViewControllerAnimated:YES];
    
}

@end
