//
//  JHConst.h
//  新浪微博(JH)
//
//  Created by JasonHuang on 15/10/3.
//  Copyright © 2015年 MyIOS. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 申请应用时分配的AppKey */
extern NSString * const JHApp_client_id;

/** 申请应用时分配的AppSecret */
extern NSString *const JHApp_client_secret;

/** 授权成功后的回调地址 */
extern NSString * const JHApp_cedirect_uri;

// 通知
// 表情选中的通知
extern NSString * const JHEmotionDidSelectNotification;
extern NSString * const JHSelectEmotionKey;

// 删除文字的通知
extern NSString * const JHEmotionDidDeleteNotification;