//
//  JHUser.h
//  新浪微博(JH)
//
//  Created by JasonHuang on 15/9/18.
//  Copyright © 2015年 MyIOS. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    /** 没有任何认证 */
    JHUserVerifiedTypeNone = -1,
    /** 个人认证 */
    JHUserVerifiedPersonal = 0,
    /** 企业官方：CSDN、EOE、搜狐新闻客户端 */
    JHUserVerifiedOrgEnterprice = 2,
    /** 媒体官方：程序员杂志、苹果汇 */
    JHUserVerifiedOrgMedia = 3,
    /** 网站官方：猫扑 */
    JHUserVerifiedOrgWebsite = 5,
    /** 微博达人 */
    JHUserVerifiedDaren = 220
} JHUserVerifiedType;

@interface JHUser : NSObject
/** string  字符串型的用户uid */
@property (nonatomic, copy) NSString *idstr;

/** string	友好显示名称 */
@property (nonatomic, copy) NSString *name;

/** string	用户头像地址，50×50像素 */
@property (nonatomic, copy) NSString *profile_image_url;

/** 会员类型, >2为会员 */
@property (nonatomic, assign) int mbtype;

/** 会员等级 */
@property (nonatomic, assign) int mbrank;

/** vip */
@property (nonatomic, assign, getter=isVip) BOOL vip;

/** 认证类型 */
@property (nonatomic, assign) JHUserVerifiedType verified_type;

@end
