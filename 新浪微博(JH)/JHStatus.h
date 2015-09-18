//
//  JHStatus.h
//  新浪微博(JH)
//
//  Created by JasonHuang on 15/9/18.
//  Copyright © 2015年 MyIOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JHUser;

@interface JHStatus : NSObject
/**
 *  string	字符串型的微博ID
 */
@property (nonatomic, copy) NSString *idstr;

/**
 *  string	微博信息内容
 */
@property (nonatomic, copy) NSString *text;

/**
 *  object	微博作者的用户信息字段 详细
 */
@property (nonatomic, strong) JHUser *user;

+ (instancetype)statusWithDict:(NSDictionary *)dict;
@end
