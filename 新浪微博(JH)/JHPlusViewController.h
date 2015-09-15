//
//  JHPlusViewController.h
//  新浪微博(JH)
//
//  Created by JasonHuang on 15/9/12.
//  Copyright (c) 2015年 MyIOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JHPlusViewController;

@protocol JHPlusViewControllerDelegate <NSObject>

@optional
- (void)plusViewControllerDidPop:(JHPlusViewController *)plus;

@end

@interface JHPlusViewController : UIViewController

@property (nonatomic, strong) id<JHPlusViewControllerDelegate> delegate;

@end
