//
//  JHDropdownMenu.h
//  新浪微博(JH)
//
//  Created by JasonHuang on 15/9/12.
//  Copyright (c) 2015年 MyIOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JHDropdownMenu;

@protocol JHDropdownMenuDelegate <NSObject>

@optional
/**
 *  消失时调用代理监听
 */
- (void)dropdownMenuDidDismiss:(JHDropdownMenu *)menu;

/**
 *  显示时调用代理监听
 */
- (void)dropdownMenuDidShow:(JHDropdownMenu *)menu;

@end

@interface JHDropdownMenu : UIView

@property (nonatomic, strong) id<JHDropdownMenuDelegate> delegate;

+ (instancetype)menu;

/**
 *  显示
 */
- (void)showFrom:(UIView *)from;

/**
 *  销毁
 */
- (void)dismiss;

/**
 *  下拉菜单内容
 */
@property (nonatomic, strong) UIView *content;

/**
 *  下拉菜单内容控制器
 */
@property (nonatomic, strong) UIViewController *contentController;

@end
