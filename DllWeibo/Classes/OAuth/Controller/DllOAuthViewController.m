//
//  DllOAuthViewController.m
//  DllWeibo
//
//  Created by zcdll on 16/5/10.
//  Copyright © 2016年 ZC. All rights reserved.
//

#import "DllOAuthViewController.h"
#import "MBProgressHUD+MJ.h"
#import "AFNetworking.h"
#import "DllAccount.h"
#import "DllAccountTool.h"
#import "DllRootTool.h"
#import "Dll.pch"




@interface DllOAuthViewController ()<UIWebViewDelegate>

@end

@implementation DllOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 展示登录的网页 -> UIWebView
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    
    [self.view addSubview:webView];
    
    // 加载网页
    
    
    NSString *baseUrl = @"https://api.weibo.com/oauth2/authorize";
    NSString *client_id = @"1446792854";
    NSString *redirect_uri = @"http://www.cnblogs.com/zcdll";
    
    // 拼接URL字符串
    NSString *urlStr = [NSString stringWithFormat:@"%@?client_id=%@&redirect_uri=%@", baseUrl, client_id, redirect_uri];
    
    
    // 创建URL
    NSURL *url = [NSURL URLWithString:urlStr];
    
    // 创建请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 加载请求
    
    [webView loadRequest:request];
    
    // 设置代理
    webView.delegate = self;
    
}

#pragma mark - UIWebView代理
-(void)webViewDidStartLoad:(UIWebView *)webView{
    
    // 提示用户正在加载
    [MBProgressHUD showMessage:@"正在加载..."];
    
}

// webView加载完成时调用
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [MBProgressHUD hideHUD];
    
}

// webView加载失败时调用
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    [MBProgressHUD hideHUD];
    
}

// 拦截webView请求
// 当webView需要加载一个请求的时候，就会调用这个方法，询问下是否请求
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSString *urlStr = request.URL.absoluteString;
    
    // 获取code(RequestToken)
    
    NSRange range = [urlStr rangeOfString:@"code="];
    
    if (range.length) {
        
//        NSLog(@"%@",urlStr);
        NSString *code = [urlStr substringFromIndex:range.location + range.length];
//        NSLog(@"%@", code);
        // 获取accessToken
        [self accessTokenWithCode:code];
        
        // 不会去加载回调界面
        return NO;
    }
    
    return YES;
    
}
/**
 *  client_id	true	string	申请应用时分配的AppKey。
 client_secret	true	string	申请应用时分配的AppSecret。
 grant_type	true	string	请求的类型，填写authorization_code
 
 grant_type为authorization_code时
 必选	类型及范围	说明
 code	true	string	调用authorize获得的code值。
 redirect_uri	true	string	回调地址，需需与注册应用里的回调地址一致。
 *
 *  @return <#return value description#>
 */
#pragma mark - 获取accessToken
-(void)accessTokenWithCode:(NSString *)code{
    
    [DllAccountTool accountWithCode:code success:^{
        
        // 进入主页或者新特性，选择窗口的根控制器
        [DllRootTool chooseRootViewController:DllKeyWindow];
        
    } failure:^(NSError *error) {
        
        
        
    }];
}

@end
