//
//  JHUser.h
//  新浪微博(JH)
//
//  Created by JasonHuang on 15/9/18.
//  Copyright © 2015年 MyIOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JHUser : NSObject
/**
 *  string  字符串型的用户uid
 */
@property (nonatomic, copy) NSString *idstr;

/**
 *  string	友好显示名称
 */
@property (nonatomic, copy) NSString *name;

/**
 *  string	用户头像地址，50×50像素
 */
@property (nonatomic, copy) NSString *profile_image_url;
@end
