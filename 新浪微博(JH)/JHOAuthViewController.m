//
//  JHOAuthViewController.m
//  新浪微博(JH)
//
//  Created by JasonHuang on 15/9/13.
//  Copyright (c) 2015年 MyIOS. All rights reserved.
//

#import "JHOAuthViewController.h"
#import "AFNetworking.h"
#import "JHAccountTool.h"
#import "MBProgressHUD+MJ.h"

@interface JHOAuthViewController ()<UIWebViewDelegate>

@end

@implementation JHOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView *weibo = [[UIWebView alloc] init];
    weibo.frame = self.view.bounds;
    weibo.delegate = self;
    [self.view addSubview:weibo];
    
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=2089346202&redirect_uri=http://www.sina.com"];

    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [weibo loadRequest:request];
}

#pragma mark - UIWebViewDelegate代理方法
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showMessage:@"正在加载..."];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    // 1.获得url
    NSString *url = request.URL.absoluteString;
    
    // 2.判断是否为回调地址
    NSRange range = [url rangeOfString:@"code="];
    if (range.length != 0) { // 是回调地址
        // 截取code=后面的参数值
        int fromIndex = (int)(range.location + range.length);
        NSString *code = [url substringFromIndex:fromIndex];
        
        // 利用code换取一个accessToken
        [self accessTokenWithCode:code];
        
        // 禁止加载回调地址
        return NO;
    }

    return YES;
}

/**
 *  利用code（授权成功后的request token）换取一个accessToken
 *
 *  @param code 授权成功后的request token
 */
- (void)accessTokenWithCode:(NSString *)code
{
    /*
     URL：https://api.weibo.com/oauth2/access_token
     
     请求参数：
     client_id：申请应用时分配的AppKey
     client_secret：申请应用时分配的AppSecret
     grant_type：使用authorization_code
     redirect_uri：授权成功后的回调地址
     code：授权成功后返回的code
     */
    
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    //    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    // AFN的AFJSONResponseSerializer默认不接受text/plain这种类型
    
    // 2.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = @"2089346202";
    params[@"client_secret"] = @"c7c50836b52e113bd26812f2e439b283";
    params[@"grant_type"] = @"authorization_code";
    params[@"redirect_uri"] = @"http://www.sina.com";
    params[@"code"] = code;
    
    // 3.发送请求
    [mgr POST:@"https://api.weibo.com/oauth2/access_token" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        [MBProgressHUD hideHUD];
        
        // 将返回的账号字典数据 --> 模型，存进沙盒
        JHAccount *account = [JHAccount accountWithDict:responseObject];
        // 存储账号信息
        [JHAccountTool saveAccount:account];
        
        // 切换窗口的根控制器
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window switchRootViewController];
        
        // UIWindow的分类、HWWindowTool
        // UIViewController的分类、HWControllerTool
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUD];
        JHLog(@"请求失败-%@", error);
    }];
}


@end
