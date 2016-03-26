//
//  JHHttpTool.m
//  新浪微博(JH)
//
//  Created by JasonHuang on 15/10/3.
//  Copyright © 2015年 MyIOS. All rights reserved.
//

#import "JHHttpTool.h"
#import "AFNetworking.h"

@implementation JHHttpTool
+ (void)post:(NSString *)url parameters:(NSDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *))failure
{
    // 1.创建请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.发送请求
    [mgr POST:url parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}

+ (void)get:(NSString *)url parameters:(NSDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *))failure
{
    // 1.创建请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.发送请求
    [mgr GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}
@end
