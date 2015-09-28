//
//  JHStatusFrame.m
//  新浪微博(JH)
//
//  Created by JasonHuang on 15/9/21.
//  Copyright © 2015年 MyIOS. All rights reserved.
//

#import "JHStatusFrame.h"
#import "JHUser.h"
#import "JHStatus.h"
#import "JHStatusPhotosView.h"

@implementation JHStatusFrame

- (void)setStatus:(JHStatus *)status
{
    _status = status;
    
    JHUser *user = status.user;
    
    // cell的宽度
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    
    /** 头像 */
    CGFloat iconWH = 35;
    CGFloat iconX = JHStatusCellBorder;
    CGFloat iconY = JHStatusCellBorder;
    self.iconViewF = CGRectMake(iconX, iconY, iconWH, iconWH);
    
    /** 昵称 */
    CGFloat nameX = CGRectGetMaxX(self.iconViewF) + JHStatusCellBorder;
    CGFloat nameY = iconY;
    CGSize nameSize = [user.name sizeWithFont:JHStatusCellNameFont maxW:MAXFLOAT];
    self.nameLabelF = (CGRect){{nameX,nameY},nameSize};
    
    /** VIP图标 */
    if (user.isVip) {
        CGFloat vipX = CGRectGetMaxX(self.nameLabelF) + 0.7 * JHStatusCellBorder;
        CGFloat vipWH = 0.7 * nameSize.height;
        self.vipViewF = CGRectMake(vipX, 0, vipWH, vipWH);
        CGFloat vipCenterY = (self.nameLabelF.origin.y + CGRectGetMaxY(self.nameLabelF)) / 2;
        self.vipViewCenterY = vipCenterY;
    }
    
    /** 时间 */
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(self.nameLabelF) + 0.5 * JHStatusCellBorder;
    CGSize timeSize = [status.created_at sizeWithFont:JHStatusCellTimeFont maxW:MAXFLOAT];
    self.timeLabelF = (CGRect){{timeX, timeY},timeSize};
    
    /** 来源 */
    CGFloat sourceX = CGRectGetMaxX(self.timeLabelF) + JHStatusCellBorder;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithFont:JHStatusCellSourceFont maxW:MAXFLOAT];
    self.sourceLabelF = (CGRect){{sourceX, sourceY},sourceSize};
    
    /** 原创微博文本 */
    CGFloat contentX = iconX;
    CGFloat contentY = MAX(CGRectGetMaxY(self.iconViewF), CGRectGetMaxY(self.timeLabelF)) + JHStatusCellBorder;
    // 文本的最大宽度
    CGFloat maxW = cellW - 2 * JHStatusCellBorder;
    CGSize contentSize = [status.text sizeWithFont:JHStatusCellContentFont maxW:maxW];
    self.contentLabelF = (CGRect){{contentX, contentY},contentSize};
    
    /** 原创微博配图 */
    CGFloat originalH;
    if (status.pic_urls.count) {  // 有图
        CGFloat photosX = contentX;
        CGFloat photosY = CGRectGetMaxY(self.contentLabelF) + JHStatusCellBorder;
        CGSize photosSize = [JHStatusPhotosView sizeWithCount:(int)status.pic_urls.count];
        self.photosViewF = (CGRect){{photosX, photosY}, photosSize};
        originalH = CGRectGetMaxY(self.photosViewF) + JHStatusCellBorder;
    } else { //没图
        originalH = CGRectGetMaxY(self.contentLabelF) + JHStatusCellBorder;
    }
    
    /** 原创微博的整体 */
    CGFloat originalX = 0;
    CGFloat originalY = JHStatusCellBorder;
    CGFloat originalW = cellW;
    self.originalViewF = CGRectMake(originalX, originalY, originalW, originalH);
    
    CGFloat statusToolBarY;
    if (status.retweeted_status) { // 有转发微博
        /** 转发微博的文本 */
        CGFloat retweetedContentX = JHStatusCellBorder;
        CGFloat retweetedContentY = JHStatusCellBorder;
        CGSize retweetedContentSize = [status.retweeted_status.text sizeWithFont:JHStatusCellRetweetedContentFont maxW:maxW];
        self.retweetedContentLabelF = (CGRect){{retweetedContentX,retweetedContentY},retweetedContentSize};
        
        /** 转发微博的配图 */
        CGFloat retweetedH;
        if (status.retweeted_status.pic_urls.count) {  // 有图
            CGFloat retweetedPhotosX = retweetedContentX;
            CGFloat retweetedPhotosY = CGRectGetMaxY(self.retweetedContentLabelF) + JHStatusCellBorder;
            CGSize retweetedPhotosSize = [JHStatusPhotosView sizeWithCount:(int)status.retweeted_status.pic_urls.count];
            self.retweetedPhotosViewF = (CGRect){{retweetedPhotosX, retweetedPhotosY}, retweetedPhotosSize};
            retweetedH = CGRectGetMaxY(self.retweetedPhotosViewF) + JHStatusCellBorder;
        } else { //没图
            retweetedH = CGRectGetMaxY(self.retweetedContentLabelF) + JHStatusCellBorder;
        }

        /** 转发微博的整体 */
        CGFloat retweetedX = 0;
        CGFloat retweetedY = CGRectGetMaxY(self.originalViewF);
        CGFloat retweetedW = cellW;
        self.retweetedViewF = CGRectMake(retweetedX, retweetedY, retweetedW, retweetedH);
        
        statusToolBarY = CGRectGetMaxY(self.retweetedViewF);
    } else { // 没转发微博
        statusToolBarY = CGRectGetMaxY(self.originalViewF);
    }
    
    /** 工具条 */
    CGFloat statusToolBarX = 0;
    CGFloat statusToolBarW = cellW;
    CGFloat statusToolBarH = 35;
    self.statusToolBarF = CGRectMake(statusToolBarX, statusToolBarY, statusToolBarW, statusToolBarH);
    
    /** cell的高度 */
    self.cellHeight = CGRectGetMaxY(self.statusToolBarF);
}
@end
