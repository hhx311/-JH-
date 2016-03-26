//
//  JHEmotion.m
//  新浪微博(JH)
//
//  Created by JasonHuang on 15/10/4.
//  Copyright © 2015年 MyIOS. All rights reserved.
//

#import "JHEmotion.h"
#import "MJExtension.h"

@implementation JHEmotion

MJCodingImplementation

- (BOOL)isEqual:(JHEmotion *)object
{
    return [self.chs isEqualToString:object.chs] || [self.code isEqualToString:object.code];
}

@end
