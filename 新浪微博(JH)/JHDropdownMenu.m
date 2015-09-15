//
//  JHDropdownMenu.m
//  新浪微博(JH)
//
//  Created by JasonHuang on 15/9/12.
//  Copyright (c) 2015年 MyIOS. All rights reserved.
//

#import "JHDropdownMenu.h"

@interface JHDropdownMenu ()

/**
 *  装载下拉菜单内容的容器
 */
@property (nonatomic, weak) UIImageView *containerView;

@end

@implementation JHDropdownMenu

// init时会调用这个方法
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

+ (instancetype)menu
{
    return [[self alloc] init];
}

- (UIImageView *)containerView
{
    if (!_containerView) {
        UIImageView *containerView = [[UIImageView alloc] init];
        containerView.image = [UIImage imageNamed:@"popover_background"];
        containerView.userInteractionEnabled = YES;
        [self addSubview:containerView];
        self.containerView = containerView;
    }
    return _containerView;
}

- (void)setContent:(UIView *)content
{
    _content = content;
    content.x = 9;
    content.y = 15;
    self.containerView.width = CGRectGetMaxX(content.frame) + content.x;
    self.containerView.height = CGRectGetMaxY(content.frame) + 11;
    
    [self.containerView addSubview:content];
}

- (void)setContentController:(UIViewController *)contentController
{
    _contentController = contentController;
    self.content = contentController.view;
}

/**
 *  显示
 */
- (void)showFrom:(UIView *)from
{
    // 1.获得最上面的窗口
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    
    // 2.添加自己到窗口上
    [window addSubview:self];
    
    // 3.设置尺寸
    self.frame = window.bounds;
    
    // 4.调整下拉菜单的容器的位置
    // 转换坐标系
    CGRect newFrame = [from convertRect:from.bounds toView:window];
//    CGRect newFrame = [from.superview convertRect:from.frame toView:window]; // 效果同上
    self.containerView.centerX = CGRectGetMidX(newFrame);
    self.containerView.y = CGRectGetMaxY(newFrame);
    
    // 通知代理进行监听
    if ([self.delegate respondsToSelector:@selector(dropdownMenuDidShow:)]) {
        [self.delegate dropdownMenuDidShow:self];
    }
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self dismiss];
}

- (void)dismiss
{
    [self removeFromSuperview];
    
    if ([self.delegate respondsToSelector:@selector(dropdownMenuDidDismiss:)]) {
        [self.delegate dropdownMenuDidDismiss:self];
    }
}
@end