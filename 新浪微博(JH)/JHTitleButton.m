//
//  JHTitleButton.m
//  新浪微博(JH)
//
//  Created by JasonHuang on 15/9/18.
//  Copyright © 2015年 MyIOS. All rights reserved.
//

#define JHMargin 5

#import "JHTitleButton.h"
#import "JHAccountTool.h"

@implementation JHTitleButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 设置图片
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
        // 设置文字字体和颜色
        self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
//        self.backgroundColor = [UIColor redColor];
    }
    return self;
}


- (void)setFrame:(CGRect)frame
{
    frame.size.width += JHMargin;
    
    [super setFrame:frame];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置文字的位置
    self.titleLabel.x = self.imageView.x;
    
    // 设置图标的位置
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + JHMargin;
}

/**
 *  重写按钮的setTitle方法
 */
- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];

    // 只要修改了文字,按钮就进行自适配尺寸
    [self sizeToFit];
}

/**
 *  重写按钮的setImage方法
 */
- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    
    // 只要修改了图片,按钮就进行自适配尺寸
    [self sizeToFit];
}

@end
