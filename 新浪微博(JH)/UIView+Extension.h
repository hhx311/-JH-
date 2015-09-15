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
 *  设置View的x值
 */
@property (nonatomic, assign) CGFloat x;
/**
 *  设置View的y值
 */
@property (nonatomic, assign) CGFloat y;
/**
 *  设置View的中点x值
 */
@property (nonatomic, assign) CGFloat centerX;
/**
 *  设置View的中点x值
 */
@property (nonatomic, assign) CGFloat centerY;
/**
 *  设置View的宽
 */
@property (nonatomic, assign) CGFloat width;
/**
 *  设置View的高
 */
@property (nonatomic, assign) CGFloat height;
/**
 *  设置View的位置
 */
@property (nonatomic, assign) CGPoint origin;
/**
 *  设置View的尺寸
 */
@property (nonatomic, assign) CGSize size;
@end
