//
//  JHStatusCell.m
//  新浪微博(JH)
//
//  Created by JasonHuang on 15/9/21.
//  Copyright © 2015年 MyIOS. All rights reserved.
//

#import "JHStatusCell.h"
#import "JHStatusFrame.h"
#import "JHUser.h"
#import "JHStatus.h"
#import "UIImageView+WebCache.h"

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
        
        /** 原创微博的整体 */
        UIView *originalView = [[UIView alloc] init];
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
        nameLabel.font = [UIFont systemFontOfSize:15];
        [originalView addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        /** 时间 */
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.font = [UIFont systemFontOfSize:12];
        [originalView addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        /** 来源 */
        UILabel *sourceLabel = [[UILabel alloc] init];
        sourceLabel.font = [UIFont systemFontOfSize:12];
        [originalView addSubview:sourceLabel];
        self.sourceLabel = sourceLabel;
        
        /** 原创微博文本 */
        UILabel *contentLabel = [[UILabel alloc] init];
        contentLabel.font = [UIFont systemFontOfSize:15];
        contentLabel.numberOfLines = 0;
        [originalView addSubview:contentLabel];
        self.contentLabel = contentLabel;
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
        self.nameLabel.textColor = [UIColor orangeColor];
    } else {
        self.vipView.hidden = YES;
        self.nameLabel.textColor = [UIColor blackColor];
    }
    
    /** 原创微博配图 */
//    self.photoView.frame = statusFrame.photoViewF;
//    self.photoView.backgroundColor = JHRandomColor;
    
    /** 昵称 */
    self.nameLabel.text = user.name;
    self.nameLabel.frame = statusFrame.nameLabelF;
    
    /** 时间 */
    self.timeLabel.text = status.created_at;
    self.timeLabel.textColor = JHColor(230, 180, 35);
    self.timeLabel.frame = statusFrame.timeLabelF;
    
    /** 来源 */
    self.sourceLabel.text = status.source;
    self.sourceLabel.frame = statusFrame.sourceLabelF;
    
    /** 原创微博文本 */
    self.contentLabel.text = status.text;
    self.contentLabel.frame = statusFrame.contentLabelF;
}

@end
