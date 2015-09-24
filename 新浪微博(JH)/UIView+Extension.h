//
//  UIView+Extension.h
//  新浪微博(JH)
//
//  Created by JasonHuang on 15/9/11.
//  Copyright (c) 2015年 MyIOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)
/**
 *  View的x值
 */
@property (nonatomic, assign) CGFloat x;
/**
 *  View的y值
 */
@property (nonatomic, assign) CGFloat y;
/**
 *  View的中点x值
 */
@property (nonatomic, assign) CGFloat centerX;
/**
 *  View的中点x值
 */
@property (nonatomic, assign) CGFloat centerY;
/**
 *  View的宽
 */
@property (nonatomic, assign) CGFloat width;
/**
 *  View的高
 */
@property (nonatomic, assign) CGFloat height;
/**
 *  View的位置
 */
@property (nonatomic, assign) CGPoint origin;
/**
 *  View的尺寸
 */
@property (nonatomic, assign) CGSize size;
@end
