//
//  JHStatusFrame.h
//  新浪微博(JH)
//
//  Created by JasonHuang on 15/9/21.
//  Copyright © 2015年 MyIOS. All rights reserved.
//

// 昵称字体
#define JHStatusCellNameFont [UIFont systemFontOfSize:15]
// 时间字体
#define JHStatusCellTimeFont [UIFont systemFontOfSize:12]
// 来源字体
#define JHStatusCellSourceFont JHStatusCellTimeFont
// 微博正文字体
#define JHStatusCellContentFont [UIFont systemFontOfSize:16]

// 转发微博字体
#define JHStatusCellRetweetedContentFont [UIFont systemFontOfSize:15]

// cell边框宽度
#define JHStatusCellBorder 10

#import <Foundation/Foundation.h>

@class JHStatus;

@interface JHStatusFrame : NSObject

/** 微博模型 */
@property (nonatomic, strong) JHStatus *status;

// 原创微博
/** 原创微博的整体 */
@property (nonatomic, assign) CGRect originalViewF;
/** 头像 */
@property (nonatomic, assign) CGRect iconViewF;
/** VIP图标 */
@property (nonatomic, assign) CGRect vipViewF;
/** 原创微博配图 */
@property (nonatomic, assign) CGRect photoViewF;
/** 昵称 */
@property (nonatomic, assign) CGRect nameLabelF;
/** 时间 */
@property (nonatomic, assign) CGRect timeLabelF;
/** 来源 */
@property (nonatomic, assign) CGRect sourceLabelF;
/** 原创微博文本 */
@property (nonatomic, assign) CGRect contentLabelF;
/** VIP图标的centerY */
@property (nonatomic, assign) CGFloat vipViewCenterY;

// 转发微博
/** 转发微博的整体 */
@property (nonatomic, assign) CGRect retweetedViewF;
/** 转发微博的文本 */
@property (nonatomic, assign) CGRect retweetedContentLabelF;
/** 转发微博的配图 */
@property (nonatomic, assign) CGRect retweetedPhotoViewF;

/** 工具条 */
@property (nonatomic, assign) CGRect statusToolBarF;

/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;
@end
