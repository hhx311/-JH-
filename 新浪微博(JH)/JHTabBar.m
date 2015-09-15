
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
 *  tabBar栏中间的添加
 */
@property (nonatomic, weak) UIButton *plusButton;

@end

@implementation JHTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 添加一个plus按钮
        UIButton *plusButton = [[UIButton alloc] init];
        
        // 设置按钮图片
        [plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [plusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateSelected];
        
        // 设置按钮尺寸
        plusButton.size = plusButton.currentBackgroundImage.size;
        
        // 监听plusButton
        [plusButton addTarget:self action:@selector(plusButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:plusButton];
        
        // 引用plusButton(weak),防止被销毁
        self.plusButton = plusButton;
    }
    return self;
}

- (void)plusButtonClick:(UIButton *)plusButton
{
    plusButton.selected = !plusButton.isSelected;
    if (plusButton.selected) {
        if ([self.delegate respondsToSelector:@selector(tabBarDidClickPlusButtonUnselected:)]) {
            [self.delegate tabBarDidClickPlusButtonUnselected:self];
        }
    } else {
        if ([self.delegate respondsToSelector:@selector(tabBarDidClickPlusButtonSelected:)]) {
            [self.delegate tabBarDidClickPlusButtonSelected:self];
    }
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置plus按钮位置
    self.plusButton.centerX = self.width * 0.5;
    self.plusButton.centerY = self.height * 0.5;
    
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
            // plus按钮非UITabBarButton类型,直接跳过此循环设置,索引直接+1
            if (tabBarButtonIndex == 2) {
                tabBarButtonIndex ++;
            }
        }
    }
}

@end
