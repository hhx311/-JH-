
//
//  JHComposePhotosView.m
//  新浪微博(JH)
//
//  Created by JasonHuang on 15/9/30.
//  Copyright © 2015年 MyIOS. All rights reserved.
//

#import "JHComposePhotosView.h"

@implementation JHComposePhotosView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _photos = [NSMutableArray array];
    }
    return self;
}

/**
 *  添加图片
 *
 *  @param photo 被添加的图片
 */
- (void)addPhoto:(UIImage *)photo
{
    UIImageView *photoView = [[UIImageView alloc] init];
    photoView.image = photo;
    [self addSubview:photoView];
    [self.photos addObject:photo];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    int maxCols = 3;
    CGFloat margin = 10;
    CGFloat photoViewWH = (self.width - (maxCols + 1) *margin) / maxCols;
    for (int i = 0; i<self.subviews.count; i++) {
        UIImageView *photoView = self.subviews[i];
        int col = i % maxCols;
        int row = i / maxCols;
        photoView.x = margin + col * (photoViewWH + margin);
        photoView.y = row * (photoViewWH + margin);
        photoView.width = photoViewWH;
        photoView.height = photoViewWH;
    }
}

@end
