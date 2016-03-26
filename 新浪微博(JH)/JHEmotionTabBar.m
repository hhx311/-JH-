//
//  JHEmotionTabBar.m
//  新浪微博(JH)
//
//  Created by JasonHuang on 15/10/4.
//  Copyright © 2015年 MyIOS. All rights reserved.
//

#import "JHEmotionTabBar.h"
#import "JHEmotionTabBarButton.h"

@interface JHEmotionTabBar()
/** 表情键盘的表情组中被选中的按钮 */
@property (nonatomic, weak) JHEmotionTabBarButton *selectedTabBarButton;

@end

@implementation JHEmotionTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupButtonWithTitle:@"最近" type:JHEmotionTabBarButtonTypeRecent];
        [self setupButtonWithTitle:@"默认" type:JHEmotionTabBarButtonTypeDefault];
        [self setupButtonWithTitle:@"Emoji" type:JHEmotionTabBarButtonTypeEmoji];
        [self setupButtonWithTitle:@"浪小花" type:JHEmotionTabBarButtonTypeLxh];
    }
    return self;
}

- (JHEmotionTabBarButton *)setupButtonWithTitle:(NSString *)title type:(JHEmotionTabBarButtonType)buttonType
{
    JHEmotionTabBarButton *button = [[JHEmotionTabBarButton alloc] init];
    
    [button setTitle:title forState:UIControlStateNormal];
    button.tag = buttonType;
    
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:button];
    
    // 设置背景图片
    NSString *image = @"compose_emotion_table_mid_normal";
    NSString *selectImage = @"compose_emotion_table_mid_selected";
    if (self.subviews.count == 1) {
        image = @"compose_emotion_table_left_normal";
        selectImage = @"compose_emotion_table_left_selected";
    } else if (self.subviews.count == 4) {
        image = @"compose_emotion_table_right_normal";
        selectImage = @"compose_emotion_table_right_selected";
    }
    
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:selectImage] forState:UIControlStateDisabled];
    
    return button;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置按钮的frame
    NSUInteger btnCount = self.subviews.count;
    CGFloat btnW = self.width / btnCount;
    CGFloat btnH = self.height;
    for (int i = 0; i<btnCount; i++) {
        JHEmotionTabBarButton *btn = self.subviews[i];
        btn.y = 0;
        btn.width = btnW;
        btn.x = i * btnW;
        btn.height = btnH;
    }
}


- (void)setDelegate:(id<JHEmotionTabBarDelegate>)delegate
{
    _delegate = delegate;
    
    // 选中“默认”按钮
    [self buttonClick:(JHEmotionTabBarButton *)[self viewWithTag:JHEmotionTabBarButtonTypeDefault]];
}

/**
 *  按钮点击
 */

- (void)buttonClick:(JHEmotionTabBarButton *)button
{
    self.selectedTabBarButton.enabled = YES;
    button.enabled = NO;
    self.selectedTabBarButton = button;
    
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(emotionTabBar:didSelectButton:)]) {
        [self.delegate emotionTabBar:self didSelectButton:(int)button.tag];
    }
}

@end
