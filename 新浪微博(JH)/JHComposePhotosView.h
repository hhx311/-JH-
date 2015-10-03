//
//  JHComposePhotosView.h
//  新浪微博(JH)
//
//  Created by JasonHuang on 15/9/30.
//  Copyright © 2015年 MyIOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHComposePhotosView : UIView
/** 添加图片 */
- (void)addPhoto:(UIImage *)photo;

/** 存储所有添加的图片 */
@property (nonatomic, strong, readonly) NSMutableArray *photos;
@end
