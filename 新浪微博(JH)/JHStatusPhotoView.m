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

@implementation JHStatusPhotoView

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
    
    [self sd_setImageWithURL:[NSURL URLWithString:photo.bmiddle_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
}

+ (instancetype)photoView
{
    return [[self alloc] init];
}

@end
