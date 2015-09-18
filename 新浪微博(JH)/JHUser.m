
//
//  JHUser.m
//  新浪微博(JH)
//
//  Created by JasonHuang on 15/9/18.
//  Copyright © 2015年 MyIOS. All rights reserved.
//

#import "JHUser.h"

@implementation JHUser

+ (instancetype)userWithDict:(NSDictionary *)dict
{
    JHUser *user = [[self alloc] init];
    
    user.idstr = dict[@"idstr"];
    user.name = dict[@"name"];
    user.profile_image_url = dict[@"profile_image_url"];
    
    return user;
}

@end
