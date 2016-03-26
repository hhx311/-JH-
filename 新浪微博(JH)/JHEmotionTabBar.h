//
//  JHEmotionTabBar.h
//  新浪微博(JH)
//
//  Created by JasonHuang on 15/10/4.
//  Copyright © 2015年 MyIOS. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    /** 最近 */
    JHEmotionTabBarButtonTypeRecent,
    /** 默认 */
    JHEmotionTabBarButtonTypeDefault,
    /** Emoji */
    JHEmotionTabBarButtonTypeEmoji,
    /** 浪小花 */
    JHEmotionTabBarButtonTypeLxh
} JHEmotionTabBarButtonType;

@class JHEmotionTabBar;

@protocol JHEmotionTabBarDelegate <NSObject>

@optional
- (void)emotionTabBar:(JHEmotionTabBar *)tabBar didSelectButton:(JHEmotionTabBarButtonType)buttonType;

@end

@interface JHEmotionTabBar : UIView
@property (nonatomic, weak) id<JHEmotionTabBarDelegate> delegate;

@end
