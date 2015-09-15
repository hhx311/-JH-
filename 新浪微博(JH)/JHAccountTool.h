//
//  JHAccountTool.h
//  新浪微博(JH)
//
//  Created by JasonHuang on 15/9/14.
//  Copyright (c) 2015年 MyIOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JHAccount.h"

@interface JHAccountTool : NSObject
/**
 *  存储账号信息
 *
 *  @param account 账号模型
 */
+ (void)saveAccount:(JHAccount *)account;

/**
 *  返回账号信息
 *
 *  @return 账号模型（如果账号过期，返回nil）
 */
+ (JHAccount *)account;

@end
