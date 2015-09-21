//
//  JHStatusCell.h
//  新浪微博(JH)
//
//  Created by JasonHuang on 15/9/21.
//  Copyright © 2015年 MyIOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JHStatusFrame;

@interface JHStatusCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;

/** 微博的frame模型 */
@property (nonatomic, strong) JHStatusFrame *statusFrame;
@end
