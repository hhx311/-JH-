//
//  JHStatusPhotosView.h
//  新浪微博(JH)
//
//  Created by JasonHuang on 15/9/26.
//  Copyright © 2015年 MyIOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JHStatusPhotoView;

@interface JHStatusPhotosView : UIView

/** 存储微博配图地址 */
@property (nonatomic, strong) NSArray *photos;

/** 通过配图张数计算photosView的size */
+ (CGSize)sizeWithCount:(int)count;
@end
