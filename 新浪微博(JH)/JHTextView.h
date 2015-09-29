//
//  JHTextView.h
//  新浪微博(JH)
//
//  Created by JasonHuang on 15/9/29.
//  Copyright © 2015年 MyIOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHTextView : UITextView
/** 文字占位符 */
@property (nonatomic, copy) NSString *placeholder;
/** 文字占位符颜色 */
@property (nonatomic, strong) UIColor *placeholderColor;
@end
