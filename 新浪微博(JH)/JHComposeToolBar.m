//
//  JHComposeToolBar.m
//  新浪微博(JH)
//
//  Created by JasonHuang on 15/9/30.
//  Copyright © 2015年 MyIOS. All rights reserved.
//

#import "JHComposeToolBar.h"

@implementation JHComposeToolBar
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self= [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        
        [self setupButtonWithNormalImage:[UIImage imageNamed:@"compose_camerabutton_background"] highlightedImage:[UIImage imageNamed:@"compose_camerabutton_background_highlighted"] type:JHComposeToolBarButtonTypeCamera];
        
        [self setupButtonWithNormalImage:[UIImage imageNamed:@"compose_toolbar_picture"] highlightedImage:[UIImage imageNamed:@"compose_toolbar_picture_highlighted"] type:JHComposeToolBarButtonTypePicture];
        
        [self setupButtonWithNormalImage:[UIImage imageNamed:@"compose_mentionbutton_background"] highlightedImage:[UIImage imageNamed:@"compose_mentionbutton_background_highlighted"] type:JHComposeToolBarButtonTypeMention];
        
        [self setupButtonWithNormalImage:[UIImage imageNamed:@"compose_trendbutton_background"] highlightedImage:[UIImage imageNamed:@"compose_trendbutton_background_highlighted"] type:JHComposeToolBarButtonTypeTrend];
        
        [self setupButtonWithNormalImage:[UIImage imageNamed:@"compose_emoticonbutton_background"] highlightedImage:[UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"] type:JHComposeToolBarButtonTypeEmotion];
    }
    return self;
}

 - (void)setupButtonWithNormalImage:(UIImage *)normalImage highlightedImage:(UIImage *)highlightedImage type:(JHComposeToolBarButtonType)type
{
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:normalImage forState:UIControlStateNormal];
    [btn setImage:highlightedImage forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = type;
    [self addSubview:btn];
}

- (void)clickButton:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(toolBar:didClickButton:)]) {
        [self.delegate toolBar:self didClickButton:(int)btn.tag];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat btnW = self.width / self.subviews.count;
    CGFloat btnH = self.height;
    for (int i = 0; i<self.subviews.count; i++) {
        UIButton *btn = self.subviews[i];
        btn.x = i * btnW;
        btn.width = btnW;
        btn.height = btnH;
    }
}

@end
