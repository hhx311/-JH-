//
//  JHSearchBar.m
//  新浪微博(JH)
//
//  Created by JasonHuang on 15/9/11.
//  Copyright (c) 2015年 MyIOS. All rights reserved.
//

#import "JHSearchBar.h"

@implementation JHSearchBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        // 设置搜索框
        self.background = [UIImage imageNamed:@"searchbar_textfield_background"];
        self.font = [UIFont systemFontOfSize:15];
        self.placeholder = @"请输入要搜索的内容";
        
        // 设置搜索框左边的搜索图标
        UIImageView *seachIcon = [[UIImageView alloc] init];
        
        seachIcon.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        
        // 设置搜索图标的尺寸
        seachIcon.width = 30;
        seachIcon.height = 30;
        
        // 设置搜索图标居中显示
        seachIcon.contentMode = UIViewContentModeCenter;
        self.leftView = seachIcon;
        self.leftViewMode = UITextFieldViewModeAlways;
        
    }
    return self;
}

+ (instancetype)searchBar
{
    return [[self alloc] init];
}

@end
