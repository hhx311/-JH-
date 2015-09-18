//
//  JHStatus.m
//  新浪微博(JH)
//
//  Created by JasonHuang on 15/9/18.
//  Copyright © 2015年 MyIOS. All rights reserved.
//

#import "JHStatus.h"
#import "JHUser.h"

@implementation JHStatus

+ (instancetype)statusWithDict:(NSDictionary *)dict
{
    JHStatus *status = [[self alloc] init];
    status.idstr = dict[@"idstr"];
    status.text = dict[@"text"];
    status.user = [JHUser userWithDict:dict[@"user"]];
    
    return status;
}

@end
