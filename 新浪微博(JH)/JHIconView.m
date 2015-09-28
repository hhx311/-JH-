//
//  JHIconView.m
//  新浪微博(JH)
//
//  Created by JasonHuang on 15/9/28.
//  Copyright © 2015年 MyIOS. All rights reserved.
//

#import "JHIconView.h"
#import "JHUser.h"
#import "UIImageView+WebCache.h"

@interface JHIconView()
/** 认证图标 */
@property (nonatomic, weak) UIImageView *verifiedView;

@end

@implementation JHIconView

- (UIImageView *)verifiedView
{
    if (!_verifiedView) {
        UIImageView *verifiedView = [[UIImageView alloc] init];
        [self addSubview:verifiedView];
        self.verifiedView = verifiedView;
    }
    return _verifiedView;
}

- (void)setUser:(JHUser *)user
{
    _user = user;
    
    [self sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    
    switch (user.verified_type) {
        case JHUserVerifiedPersonal: // 个人认证
            self.verifiedView.image = [UIImage imageNamed:@"avatar_vip"];
            self.verifiedView.hidden = NO;
            break;
            
        case JHUserVerifiedOrgMedia:
        case JHUserVerifiedOrgWebsite:
        case JHUserVerifiedOrgEnterprice: // 官方认证
            self.verifiedView.image = [UIImage imageNamed:@"avatar_enterprise_vip"];
            self.verifiedView.hidden = NO;
            break;
            
        case JHUserVerifiedDaren: // 微博达人
            self.verifiedView.image = [UIImage imageNamed:@"avatar_grassroot"];
            self.verifiedView.hidden = NO;
            break;
            
        default: //未认证
            self.verifiedView.hidden = YES;
            break;
    }
}

- (void)layoutSubviews
{
    self.verifiedView.size = self.verifiedView.image.size;
    CGFloat scale = 0.6;
    self.verifiedView.x = self.width - self.verifiedView.width * scale;
    self.verifiedView.y = self.height - self.verifiedView.height * scale;
}
@end
