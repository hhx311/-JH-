//
//  JHPhoto.h
//  新浪微博(JH)
//
//  Created by JasonHuang on 15/9/22.
//  Copyright © 2015年 MyIOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JHPhoto : NSObject
/** 缩略图地址 */
@property (nonatomic, copy) NSString *thumbnail_pic;
/** 中等图地址 */
@property (nonatomic, copy) NSString *bmiddle_pic;
/** 原始图地址 */
@property (nonatomic, copy) NSString *original_pic;
@end
