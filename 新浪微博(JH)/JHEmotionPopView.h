//
//  JHEmotionPopView.h
//  新浪微博(JH)
//
//  Created by JasonHuang on 15/10/4.
//  Copyright © 2015年 MyIOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JHEmotionButton;

@interface JHEmotionPopView : UIView
+ (instancetype)popView;

- (void)showFrom:(JHEmotionButton *)button;

@end
