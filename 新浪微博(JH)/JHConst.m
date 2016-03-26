//
//  JHConst.m
//  新浪微博(JH)
//
//  Created by JasonHuang on 15/10/3.
//  Copyright © 2015年 MyIOS. All rights reserved.
//

#import "JHConst.h"

/** 申请应用时分配的AppKey */
NSString * const JHApp_client_id = @"2089346202";

/** 申请应用时分配的AppSecret */
NSString *const JHApp_client_secret = @"c7c50836b52e113bd26812f2e439b283";

/** 授权成功后的回调地址 */
NSString * const JHApp_cedirect_uri = @"http://www.sina.com";

// 通知
// 表情选中的通知
NSString * const JHEmotionDidSelectNotification = @"JHEmotionDidSelectNotification";
NSString * const JHSelectEmotionKey = @"JHSelectEmotionKey";

// 删除文字的通知
NSString * const JHEmotionDidDeleteNotification = @"JHEmotionDidDeleteNotification";