
//
//  JHTabBar.m
//  新浪微博(JH)
//
//  Created by JasonHuang on 15/9/11.
//  Copyright (c) 2015年 MyIOS. All rights reserved.
//

#import "JHTabBar.h"

@interface JHTabBar ()

/**
 *  tabBar栏中间的发微博按钮
 */
@property (nonatomic, weak) UIButton *composeButton;

@end

@implementation JHTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 添加一个compose按钮
        UIButton *composeButton = [[UIButton alloc] init];
        
        // 设置按钮图片
        [composeButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [composeButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [composeButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [composeButton setImage:[UIImage imageNamed:@"compose_guide_icon_close_default"] forState:UIControlStateSelected];
        
        // 设置按钮尺寸
        composeButton.size = composeButton.currentBackgroundImage.size;
        
        // 监听composeButton
        [composeButton addTarget:self action:@selector(composeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:composeButton];
        
        // 引用composeButton(weak),防止被销毁
        self.composeButton = composeButton;
    }
    return self;
}

- (void)composeButtonClick:(UIButton *)composeButton
{
        if ([self.delegate respondsToSelector:@selector(tabBarDidClickComposeButton:)]) {
            [self.delegate tabBarDidClickComposeButton:self];
        }
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    // 设置compose按钮位置
    self.composeButton.centerX = self.width * 0.5;
    self.composeButton.centerY = self.height * 0.5;
    
    // 设置tabBar中其他item的位置
    CGFloat tabBarButtonW = self.width / 5;
    CGFloat tabBarButtonIndex = 0;
    for (UIView *child in self.subviews) {
        if ([child isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            // 设置宽度
            child.width = tabBarButtonW;
            // 设置x值
            child.x = tabBarButtonW * tabBarButtonIndex;
            // 索引增加
            tabBarButtonIndex ++;
            // compose按钮非UITabBarButton类型,直接跳过此循环设置,索引直接+1
            if (tabBarButtonIndex == 2) {
                tabBarButtonIndex ++;
            }
        }
    }
}

@end
