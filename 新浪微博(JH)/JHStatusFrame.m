//
//  JHStatusFrame.m
//  新浪微博(JH)
//
//  Created by JasonHuang on 15/9/21.
//  Copyright © 2015年 MyIOS. All rights reserved.
//

// cell边框宽度
#define JHStatusCellBorder 10

#import "JHStatusFrame.h"
#import "JHUser.h"
#import "JHStatus.h"

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
    CGFloat nameY = JHStatusCellBorder;
    CGSize nameSize = [user.name sizeWithFont:JHStatusCellNameFont maxW:MAXFLOAT];
    self.nameLabelF = (CGRect){{nameX,nameY},nameSize};
    
    /** VIP图标 */
    if (user.isVip) {
        CGFloat vipX = CGRectGetMaxX(self.nameLabelF) + JHStatusCellBorder;
        CGFloat vipY = JHStatusCellBorder;
        CGFloat vipWH = nameSize.height;
        self.vipViewF = CGRectMake(vipX, vipY, vipWH, vipWH);
    }
    
    /** 时间 */
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(self.nameLabelF) + JHStatusCellBorder;
    CGSize timeSize = [status.created_at sizeWithFont:JHStatusCellTimeFont maxW:MAXFLOAT];
    self.timeLabelF = (CGRect){{timeX, timeY},timeSize};
    
    /** 来源 */
    CGFloat sourceX = CGRectGetMaxY(self.timeLabelF) + JHStatusCellBorder;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithFont:JHStatusCellSourceFont maxW:MAXFLOAT];
    self.sourceLabelF = (CGRect){{sourceX, sourceY},sourceSize};
    
    /** 原创微博文本 */
    CGFloat contentX = JHStatusCellBorder;
    CGFloat contentY = MAX(CGRectGetMaxY(self.iconViewF), CGRectGetMaxY(self.timeLabelF)) + JHStatusCellBorder;
    
    CGFloat contentW = cellW - 2 * JHStatusCellBorder;
    CGSize contentSize = [status.text sizeWithFont:JHStatusCellContentFont maxW:contentW];
    self.contentLabelF = (CGRect){{contentX, contentY},contentSize};
    
    
    /** 原创微博配图 */
//    self.photoViewF = CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>);
    
    /** 原创微博的整体 */
    CGFloat originalX = 0;
    CGFloat originalY = 0;
    CGFloat originalW = cellW;
    CGFloat originalH = CGRectGetMaxY(self.contentLabelF) + JHStatusCellBorder;
    self.originalViewF = CGRectMake(originalX, originalY, originalW, originalH);
    
    /** cell的高度 */
    self.cellHeight = CGRectGetMaxY(self.originalViewF);
}
@end
