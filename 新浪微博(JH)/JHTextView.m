
//
//  JHTextView.m
//  新浪微博(JH)
//
//  Created by JasonHuang on 15/9/29.
//  Copyright © 2015年 MyIOS. All rights reserved.
//

#import "JHTextView.h"

@implementation JHTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

- (void)textDidChange
{
    [self setNeedsDisplay];
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    
    [self setNeedsDisplay];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    
    [self setNeedsDisplay];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    
    [self setNeedsDisplay];
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    [self setNeedsDisplay];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)drawRect:(CGRect)rect
{
    if (self.hasText) return; // 如果有输入文字,直接返回,不画占位符
    
    CGFloat placeholderX = 12;
    CGFloat placeholderY = 7;
    CGFloat placeholderW = rect.size.width - 10;
    CGFloat placeholderH = rect.size.height - 2 * placeholderY;
    CGRect placeholderRect = CGRectMake(placeholderX, placeholderY, placeholderW, placeholderH);
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    attrs[NSFontAttributeName] = self.font;
    
    [self.placeholder drawInRect:placeholderRect withAttributes:attrs];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.textContainerInset = UIEdgeInsetsMake(7, 7, 0, 0);
}
@end
