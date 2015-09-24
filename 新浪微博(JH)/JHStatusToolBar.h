//
//  JHStatusToolBar.h
//  新浪微博(JH)
//
//  Created by JasonHuang on 15/9/24.
//  Copyright © 2015年 MyIOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JHStatus;

@interface JHStatusToolBar : UIView
/** 转发按钮 */
@property (nonatomic, weak) UIButton *repostBtn;
/** 评论按钮 */
@property (nonatomic, weak) UIButton *commentBtn;
/** 点赞按钮 */
@property (nonatomic, weak) UIButton *attitudeBtn;

+ (instancetype)toolBar;
@property (nonatomic, strong) JHStatus *status;

@end
