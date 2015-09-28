//
//  JHIconView.h
//  新浪微博(JH)
//
//  Created by JasonHuang on 15/9/28.
//  Copyright © 2015年 MyIOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JHUser;

@interface JHIconView : UIImageView
/** icon(头像)归属的用户 */
@property (nonatomic, strong) JHUser *user;
@end
