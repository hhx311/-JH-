//
//  JHEmotionListView.h
//  新浪微博(JH)
//
//  Created by JasonHuang on 15/10/4.
//  Copyright © 2015年 MyIOS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JHEmotionPageView;

@interface JHEmotionListView : UIView
/** 表情(里面存放的JHEmotion模型) */
@property (nonatomic, strong) NSArray *emotions;
@end
