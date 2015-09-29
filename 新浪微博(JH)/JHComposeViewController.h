//
//  JHComposeViewController.h
//  新浪微博(JH)
//
//  Created by JasonHuang on 15/9/12.
//  Copyright (c) 2015年 MyIOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JHComposeViewController,JHTextView;

@protocol JHComposeViewControllerDelegate <NSObject>

@optional
- (void)composeViewControllerDidPop:(JHComposeViewController *)compose;

@end

@interface JHComposeViewController : UIViewController

@property (nonatomic, strong) id<JHComposeViewControllerDelegate> delegate;

/** 发微博的文本框内容 */
@property (nonatomic, weak) JHTextView *textView;
@end
