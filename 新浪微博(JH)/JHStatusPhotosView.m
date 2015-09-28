//
//  JHStatusPhotosView.m
//  新浪微博(JH)
//
//  Created by JasonHuang on 15/9/26.
//  Copyright © 2015年 MyIOS. All rights reserved.
//

// 每张配图之间的间隙
#define JHStatusPhotoMargin 5
// 配图的最大列数
#define JHStatusMaxCols(count) ((count) == 4)? 2:3
// 每张配图的宽高
#define JHStatusPhotoWH ([UIScreen mainScreen].bounds.size.width - 2 * 10 - 2 * JHStatusPhotoMargin) / 3

#import "JHStatusPhotosView.h"
#import "JHStatusPhotoView.h"

@implementation JHStatusPhotosView

- (void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    
    // 创建足够数量的图片控件
    while (self.subviews.count < photos.count) {
        JHStatusPhotoView *photoView = [JHStatusPhotoView photoView];
        [self addSubview:photoView];
    }
    
    // 遍历所有的图片控件，设置图片
    for (int i = 0; i<self.subviews.count; i++) {
        JHStatusPhotoView *photoView = self.subviews[i];
        
        if (i < photos.count) { // 显示
            photoView.photo = photos[i];
            photoView.hidden = NO;
        } else { // 隐藏
            photoView.hidden = YES;
        }
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置每张配图的位置
    int maxCols = JHStatusMaxCols(self.photos.count);
    for (int i = 0; i<self.photos.count; i++) {
        JHStatusPhotoView *photoView = self.subviews[i];
        int col = i % maxCols;
        int row = i / maxCols;
        photoView.x = col * (JHStatusPhotoWH + JHStatusPhotoMargin);
        photoView.y = row * (JHStatusPhotoWH + JHStatusPhotoMargin);
        photoView.width = JHStatusPhotoWH;
        photoView.height = JHStatusPhotoWH;
    }
}

+ (CGSize)sizeWithCount:(int)count
{
    int maxCols = JHStatusMaxCols(count);
    
    // 列数
    int cols = (count >= maxCols)? maxCols:count;
    // 行数
    int rows = (count + maxCols - 1) / maxCols;
    
    CGFloat photosW = JHStatusPhotoWH * cols + (cols - 1) * JHStatusPhotoMargin;
    CGFloat photosH = JHStatusPhotoWH * rows + (rows - 1) * JHStatusPhotoMargin;
    
    return CGSizeMake(photosW, photosH);
}

@end
