//
//  JHStatusPhotoView.h
//  新浪微博(JH)
//
//  Created by JasonHuang on 15/9/26.
//  Copyright © 2015年 MyIOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JHPhoto;

@interface JHStatusPhotoView : UIImageView
/** 配图模型(一个JHPhoto模型代表一张图) */
@property (nonatomic, strong) JHPhoto *photo;

+ (instancetype)photoView;
@end
