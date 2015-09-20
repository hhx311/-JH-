//
//  JHLoadMoreFootView.m
//  新浪微博(JH)
//
//  Created by JasonHuang on 15/9/19.
//  Copyright © 2015年 MyIOS. All rights reserved.
//

#import "JHLoadMoreFootView.h"

@implementation JHLoadMoreFootView

+ (instancetype)footView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"JHLoadMoreFootView" owner:nil options:nil] lastObject];
}

@end
