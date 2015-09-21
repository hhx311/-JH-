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
#define JHStatusCellContentFont [UIFont systemFontOfSize:15]

#import <Foundation/Foundation.h>

@class JHStatus;

@interface JHStatusFrame : NSObject

/** 微博模型 */
@property (nonatomic, strong) JHStatus *status;

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

/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;

@end
