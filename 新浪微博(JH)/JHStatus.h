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
/** string	字符串型的微博ID */
@property (nonatomic, copy) NSString *idstr;

/** string	微博信息内容 */
@property (nonatomic, copy) NSString *text;

/** 微博创建时间 */
@property (nonatomic, copy) NSString *created_at;

/** 微博来源 */
@property (nonatomic, copy) NSString *source;

/** 微博配图地址,多图时返回多图链接,无配图返回“[]” */
@property (nonatomic, strong) NSArray *pic_urls;

/** object	微博作者的用户信息字段 详细 */
@property (nonatomic, strong) JHUser *user;

/** 转发微博 */
@property (nonatomic, strong) JHStatus *retweeted_status;

@end
