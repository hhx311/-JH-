//
//  JHEmotionPageView.h
//  新浪微博(JH)
//
//  Created by JasonHuang on 15/10/4.
//  Copyright © 2015年 MyIOS. All rights reserved.

//  存储每一页的表情(1~20个)

#import <UIKit/UIKit.h>

// 一页中最多3行
#define JHEmotionMaxRows 3
// 一行中最多7列
#define JHEmotionMaxCols 7
// 每一页的表情个数
#define JHEmotionPageSize ((JHEmotionMaxRows * JHEmotionMaxCols) - 1)

@interface JHEmotionPageView : UIView
/** 这一页显示的表情（里面都是HWEmotion模型） */
@property (nonatomic, strong) NSArray *emotions;

@end
