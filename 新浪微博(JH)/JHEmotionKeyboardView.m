//
//  JHEmotionKeyboardView.m
//  新浪微博(JH)
//
//  Created by JasonHuang on 15/10/4.
//  Copyright © 2015年 MyIOS. All rights reserved.
//

#import "JHEmotionKeyboardView.h"
#import "JHEmotionTabBar.h"
#import "JHEmotionListView.h"
#import "JHEmotionTool.h"
#import "MJExtension.h"
#import "JHEmotion.h"

@interface JHEmotionKeyboardView()<JHEmotionTabBarDelegate>
/** 表情键盘的tabBar */
@property (nonatomic, weak) JHEmotionTabBar *tabBar;
/** 当前展示的listView */
@property (nonatomic, weak) JHEmotionListView *showingListView;
/** 最近表情组 */
@property (nonatomic, strong) JHEmotionListView *recentListView;
/** 默认表情组 */
@property (nonatomic, strong) JHEmotionListView *defaultListView;
/** emoji表情组 */
@property (nonatomic, strong) JHEmotionListView *emojiListView;
/** 浪小花表情组 */
@property (nonatomic, strong) JHEmotionListView *lxhListView;
@end

@implementation JHEmotionKeyboardView
#pragma mark - 懒加载
- (JHEmotionListView *)recentListView
{
    if (!_recentListView) {
        self.recentListView = [[JHEmotionListView alloc] init];
        // 加载沙盒中的数据
        self.recentListView.emotions = [JHEmotionTool recentEmotions];
    }
    return _recentListView;
}

- (JHEmotionListView *)defaultListView
{
    if (!_defaultListView) {
        self.defaultListView = [[JHEmotionListView alloc] init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/default/info.plist" ofType:nil];
        self.defaultListView.emotions = [JHEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    return _defaultListView;
}

- (JHEmotionListView *)emojiListView
{
    if (!_emojiListView) {
        self.emojiListView = [[JHEmotionListView alloc] init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/emoji/info.plist" ofType:nil];
        self.emojiListView.emotions = [JHEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    return _emojiListView;
}

- (JHEmotionListView *)lxhListView
{
    if (!_lxhListView) {
        self.lxhListView = [[JHEmotionListView alloc] init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/lxh/info.plist" ofType:nil];
        self.lxhListView.emotions = [JHEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    return _lxhListView;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // tabbar
        JHEmotionTabBar *tabBar = [[JHEmotionTabBar alloc] init];
        tabBar.delegate = self;
        [self addSubview:tabBar];
        self.tabBar = tabBar;
        
        // 表情选中的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionDidSelect) name:JHEmotionDidSelectNotification object:nil];
    }
    return self;
}

- (void)emotionDidSelect
{
    self.recentListView.emotions = [JHEmotionTool recentEmotions];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 1.tabbar
    self.tabBar.width = self.width;
    self.tabBar.height = 37;
    self.tabBar.x = 0;
    self.tabBar.y = self.height - self.tabBar.height;
    
    // 2.表情内容
    self.showingListView.x = self.showingListView.y = 0;
    self.showingListView.width = self.width;
    self.showingListView.height = self.tabBar.y;
}

#pragma mark - JHEmotionTabBarDelegate
- (void)emotionTabBar:(JHEmotionTabBar *)tabBar didSelectButton:(JHEmotionTabBarButtonType)buttonType
{
    // 移除正在显示的listView控件
    [self.showingListView removeFromSuperview];
    
    // 根据按钮类型，切换键盘上面的listview
    switch (buttonType) {
        case JHEmotionTabBarButtonTypeRecent: { // 最近
            [self addSubview:self.recentListView];
            break;
        }
            
        case JHEmotionTabBarButtonTypeDefault: { // 默认
            [self addSubview:self.defaultListView];
            break;
        }
            
        case JHEmotionTabBarButtonTypeEmoji: { // Emoji
            [self addSubview:self.emojiListView];
            break;
        }
            
        case JHEmotionTabBarButtonTypeLxh: { // Lxh
            [self addSubview:self.lxhListView];
            break;
        }
    }
    
    // 设置正在显示的listView
    self.showingListView = [self.subviews lastObject];
    
    // 设置frame
    [self setNeedsLayout];
}


@end
