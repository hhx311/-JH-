//
//  JHStatusPhotoView.m
//  新浪微博(JH)
//
//  Created by JasonHuang on 15/9/26.
//  Copyright © 2015年 MyIOS. All rights reserved.
//

#import "JHStatusPhotoView.h"
#import "UIImageView+WebCache.h"
#import "JHPhoto.h"

@interface JHStatusPhotoView()
/** gif标识 */
@property (nonatomic, weak) UIImageView *gifView;
@end

@implementation JHStatusPhotoView

- (UIImageView *)gifView
{
    if (!_gifView) {
        UIImageView *gifView = [[UIImageView alloc] init];
        gifView.image = [UIImage imageNamed:@"timeline_image_gif"];
        [self addSubview:gifView];
        self.gifView = gifView;
    }
    return _gifView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)setPhoto:(JHPhoto *)photo
{
    _photo = photo;
    
    BOOL isGif = [photo.bmiddle_pic.lowercaseString hasSuffix:@"gif"];
    if (isGif) { // 是gif图,下载缩略图
        [self sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
        self.gifView.hidden = NO;
    } else { // 不是gif图,下载中等图
        [self sd_setImageWithURL:[NSURL URLWithString:photo.bmiddle_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
        self.gifView.hidden = YES;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.gifView.size = self.gifView.image.size;
    self.gifView.x = self.width - self.gifView.width;
    self.gifView.y = self.height - self.gifView.height;
}

+ (instancetype)photoView
{
    return [[self alloc] init];
}

@end
