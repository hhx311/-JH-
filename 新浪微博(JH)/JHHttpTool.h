//
//  JHHttpTool.h
//  新浪微博(JH)
//
//  Created by JasonHuang on 15/10/3.
//  Copyright © 2015年 MyIOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JHHttpTool : NSObject
/**
*  发送post HTTP请求
*
*  @param url               请求的URL地址(NSString *)
*  @param params            请求参数
*  @param success           请求成功后执行的操作(block代码段 void (^))
*  @param responseObject    返回的字典数据
*  @param failure           请求失败后执行的操作(block代码段 void (^))
*  @param error             返回的错误原因
*/
+ (void)post:(NSString *)url parameters:(NSDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/**
 *  发送post HTTP请求
 *
 *  @param url              请求的URL地址(NSString *)
 *  @param params           请求参数
 *  @param success          请求成功后执行的操作(block代码段 void (^))
 *  @param responseObject   返回的字典数据
 *  @param failure          请求失败后执行的操作(block代码段 void (^))
 *  @param error            返回的错误原因
 */
+ (void)get:(NSString *)url parameters:(NSDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
@end
