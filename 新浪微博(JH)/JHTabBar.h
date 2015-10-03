//
//  JHTabBar.h
//  新浪微博(JH)
//
//  Created by JasonHuang on 15/9/11.
//  Copyright (c) 2015年 MyIOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JHTabBar;

@protocol JHTabBarDelegate <UITabBarDelegate>

@optional
- (void)tabBarDidClickComposeButton:(JHTabBar *)tabBar;

@end

@interface JHTabBar : UITabBar
@property (nonatomic, weak) id<JHTabBarDelegate> delegate;
@end
