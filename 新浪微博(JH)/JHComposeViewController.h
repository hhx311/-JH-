//
//  JHComposeViewController.h
//  新浪微博(JH)
//
//  Created by JasonHuang on 15/9/12.
//  Copyright (c) 2015年 MyIOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JHTextView;

@interface JHComposeViewController : UIViewController
/** 发微博的文本框内容 */
@property (nonatomic, weak) JHTextView *textView;
@end
