//
//  JHEmotionTool.h
//  新浪微博(JH)
//
//  Created by JasonHuang on 15/10/4.
//  Copyright © 2015年 MyIOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JHEmotion;

@interface JHEmotionTool : NSObject
+ (void)addRecentEmotion:(JHEmotion *)emotion;
+ (NSArray *)recentEmotions;
@end
