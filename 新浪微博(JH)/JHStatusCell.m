//
//  JHStatusCell.m
//  新浪微博(JH)
//
//  Created by JasonHuang on 15/9/21.
//  Copyright © 2015年 MyIOS. All rights reserved.
//

// 时间的字体颜色
#define JHStatusCellTimeLabelColor JHColor(150, 150, 150)
// 来源的字体颜色
#define JHStatusCellSourceLabelColor JHStatusCellTimeLabelColor

#import "JHStatusCell.h"
#import "JHStatusFrame.h"
#import "JHUser.h"
#import "JHStatus.h"
#import "UIImageView+WebCache.h"
#import "JHPhoto.h"

@interface JHStatusCell()

/** 原创微博的整体 */
@property (nonatomic, weak) UIView *originalView;
/** 头像 */
@property (nonatomic, weak) UIImageView *iconView;
/** VIP图标 */
@property (nonatomic, weak) UIImageView *vipView;
/** 原创微博配图 */
@property (nonatomic, weak) UIImageView *photoView;
/** 昵称 */
@property (nonatomic, weak) UILabel *nameLabel;
/** 时间 */
@property (nonatomic, weak) UILabel *timeLabel;
/** 来源 */
@property (nonatomic, weak) UILabel *sourceLabel;
/** 原创微博文本 */
@property (nonatomic, weak) UILabel *contentLabel;

/** 转发微博的整体 */
@property (nonatomic, weak) UIView *retweetedView;
/** 转发微博的文本 */
@property (nonatomic, weak) UILabel *retweetedContentLabel;
/** 转发微博的配图 */
@property (nonatomic, weak) UIImageView *retweetedPhotoView;

@end

@implementation JHStatusCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    // 重用标识id
    NSString *ID = @"status";
    
    JHStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

/**
 *  初始化子控件,一个cell只调用一次
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor grayColor];
        
        // 设置cell被点击时不变色
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        /** 原创微博的整体 */
        UIView *originalView = [[UIView alloc] init];
        originalView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:originalView];
        self.originalView = originalView;
        
        /** 头像 */
        UIImageView *iconView = [[UIImageView alloc] init];
        [originalView addSubview:iconView];
        self.iconView = iconView;
        
        /** VIP图标 */
        UIImageView *vipView= [[UIImageView alloc] init];
        [originalView addSubview:vipView];
        self.vipView = vipView;
        
        /** 原创微博配图 */
        UIImageView *photoView= [[UIImageView alloc] init];
        [originalView addSubview:photoView];
        self.photoView = photoView;
        
        /** 昵称 */
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = JHStatusCellNameFont;
        [originalView addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        /** 时间 */
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.font = JHStatusCellTimeFont;
        timeLabel.textColor = JHStatusCellTimeLabelColor;
        [originalView addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        /** 来源 */
        UILabel *sourceLabel = [[UILabel alloc] init];
        sourceLabel.font = JHStatusCellSourceFont;
        sourceLabel.textColor = JHStatusCellSourceLabelColor;
        [originalView addSubview:sourceLabel];
        self.sourceLabel = sourceLabel;
        
        /** 原创微博文本 */
        UILabel *contentLabel = [[UILabel alloc] init];
        contentLabel.font = JHStatusCellContentFont;
        contentLabel.numberOfLines = 0;
        [originalView addSubview:contentLabel];
        self.contentLabel = contentLabel;
        
        /** 转发微博的整体 */
        UIView *retweetedView = [[UIView alloc] init];
        retweetedView.backgroundColor = JHColor(247, 247, 247);
//        retweetedView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_retweet_background"]];
        [self.contentView addSubview:retweetedView];
        self.retweetedView = retweetedView;
        
        /** 转发微博的文本 */
        UILabel *retweetedContentLabel = [[UILabel alloc] init];
        retweetedContentLabel.textColor = JHColor(100, 100, 100);
        retweetedContentLabel.font = JHStatusCellRetweetedContentFont;
        retweetedContentLabel.numberOfLines = 0;
        [retweetedView addSubview:retweetedContentLabel];
        self.retweetedContentLabel = retweetedContentLabel;
        
        /** 转发微博的配图 */
        UIImageView *retweetedPhotoView = [[UIImageView alloc] init];
        [retweetedView addSubview:retweetedPhotoView];
        self.retweetedPhotoView = retweetedPhotoView;
    }
    return self;
}

/**
 *  设置cell的子控件frame
 */
- (void)setStatusFrame:(JHStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    JHStatus *status = statusFrame.status;
   
    JHUser *user = status.user;
    
    /** 原创微博的整体 */
    self.originalView.frame = statusFrame.originalViewF;
    
    /** 头像 */
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    self.iconView.frame = statusFrame.iconViewF;
    
    /** VIP图标 */
    if (user.isVip) {
        self.vipView.hidden = NO;
        
        // 不同等级不同图标
        NSString *imageName = [NSString stringWithFormat:@"common_icon_membership_level%d",user.mbrank];
        self.vipView.image = [UIImage imageNamed:imageName];
        
        self.vipView.frame = statusFrame.vipViewF;
        self.vipView.centerY = statusFrame.vipViewCenterY;
        
        self.nameLabel.textColor = [UIColor orangeColor];
    } else {
        self.vipView.hidden = YES;
        self.nameLabel.textColor = [UIColor blackColor];
    }
    
    /** 原创微博配图 */
    if (status.pic_urls.count) { // 有图
        JHPhoto *photo = [status.pic_urls firstObject];
        [self.photoView sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
        self.photoView.frame = statusFrame.photoViewF;
        self.photoView.hidden = NO;
    } else { // 没图
        self.photoView.hidden = YES;
    }
    
    /** 昵称 */
    self.nameLabel.text = user.name;
    self.nameLabel.frame = statusFrame.nameLabelF;
    
    /** 时间 */
    CGFloat timeX = statusFrame.nameLabelF.origin.x;
    CGFloat timeY = CGRectGetMaxY(statusFrame.nameLabelF) + 0.5 * JHStatusCellBorder;
    CGSize timeSize = [status.created_at sizeWithFont:JHStatusCellTimeFont maxW:MAXFLOAT];
    self.timeLabel.text = status.created_at;
    
    statusFrame.timeLabelF = (CGRect){{timeX, timeY},timeSize};
    self.timeLabel.frame = statusFrame.timeLabelF;
    // 意义不一样,statusesFrame模型中timeLabelF并未更改,再次调用时仍为最初的statusesFrame.timeLabelF
//    self.timeLabel.frame = (CGRect){{timeX, timeY},timeSize};
 
    /** 来源 */
    CGFloat sourceX = CGRectGetMaxX(statusFrame.timeLabelF) + JHStatusCellBorder;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithFont:JHStatusCellSourceFont maxW:MAXFLOAT];
    self.sourceLabel.text = status.source;
    statusFrame.sourceLabelF = (CGRect){{sourceX, sourceY},sourceSize};
    self.sourceLabel.frame = statusFrame.sourceLabelF;
    
    /** 原创微博文本 */
    self.contentLabel.text = status.text;
    self.contentLabel.frame = statusFrame.contentLabelF;
    
    // 转发微博
    if (status.retweeted_status) {
        JHStatus *retweeted_status = status.retweeted_status;
        JHUser *retweeted_user = retweeted_status.user;
        
        self.retweetedView.hidden = NO;
        
        /** 转发微博的整体 */
        self.retweetedView.frame = statusFrame.retweetedViewF;
        
        /** 转发微博的文本 */
        self.retweetedContentLabel.text = [NSString stringWithFormat:@"@%@: %@", retweeted_user.name, retweeted_status.text];
        self.retweetedContentLabel.frame = statusFrame.retweetedContentLabelF;
        
        /** 转发微博的配图 */
        if (status.retweeted_status.pic_urls.count) {
            JHPhoto *retweetedPhoto = [retweeted_status.pic_urls firstObject];
            [self.retweetedPhotoView sd_setImageWithURL:[NSURL URLWithString:retweetedPhoto.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
            self.retweetedPhotoView.frame = statusFrame.retweetedPhotoViewF;
            
            self.retweetedPhotoView.hidden = NO;
        } else {
            self.retweetedPhotoView.hidden = YES;
        }
    } else {
        self.retweetedView.hidden = YES;
    }
}

@end
