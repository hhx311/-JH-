//
//  JHPhoto.m
//  新浪微博(JH)
//
//  Created by JasonHuang on 15/9/22.
//  Copyright © 2015年 MyIOS. All rights reserved.
//

#import "JHPhoto.h"

@implementation JHPhoto
- (NSString *)bmiddle_pic
{
    // 把小图URL地址改成中等图URL地址
    return [self.thumbnail_pic stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
}

- (NSString *)original_pic
{
    // 把小图URL地址改成原始图URL地址
    return [self.thumbnail_pic stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"large"];
}
@end
