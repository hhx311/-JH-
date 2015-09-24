//
//  JHStatusToolBar.m
//  新浪微博(JH)
//
//  Created by JasonHuang on 15/9/24.
//  Copyright © 2015年 MyIOS. All rights reserved.
//

#import "JHStatusToolBar.h"
#import "JHStatus.h"

@interface JHStatusToolBar()


/** 存放工具条中的所有按钮 */
@property (nonatomic, strong) NSMutableArray *btns;

/** 存放工具条中所有分隔线 */
@property (nonatomic, strong) NSMutableArray *dividers;

@end

@implementation JHStatusToolBar

- (NSMutableArray *)btns
{
    if (!_btns) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}

- (NSMutableArray *)dividers
{
    if (!_dividers) {
        _dividers = [NSMutableArray array];
    }
    return _dividers;
}

+ (instancetype)toolBar
{
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 设置工具条背景色
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_card_bottom_background"]];
        
        self.repostBtn = [self setupButtonWithTitle:@"转发" image:@"timeline_icon_retweet"];
        self.commentBtn = [self setupButtonWithTitle:@"评论" image:@"timeline_icon_comment"];
        self.attitudeBtn = [self setupButtonWithTitle:@"赞" image:@"timeline_icon_unlike"];
        
        [self setupDivider];
        [self setupDivider];
    }
    return self;
}

/**
 *  设置分隔线
 */
- (UIImageView *)setupDivider
{
    UIImageView *divider = [[UIImageView alloc] init];
    
    divider.image = [UIImage imageNamed:@"timeline_card_bottom_line"];
    
    [self addSubview:divider];
    
    [self.dividers addObject:divider];
    
    return divider;
}

/**
 *  初始化一个按钮
 *
 *  @param title 按钮标题
 *  @param icon  按钮图标
 */
- (UIButton *)setupButtonWithTitle:(NSString *)title image:(NSString *)icon
{
    UIButton *btn = [[UIButton alloc] init];
    
    // 设置按钮标题
    [btn setTitle:title forState:UIControlStateNormal];
    // 设置字体
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    // 设置文字颜色
    [btn setTitleColor:JHColor(150, 150, 150) forState:UIControlStateNormal];
    // 设置按钮图标
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    // 设置按钮点击状态下背景
    [btn setBackgroundImage:[UIImage imageNamed:@"timeline_card_bottom_line_highlighted"] forState:UIControlStateHighlighted];
    // 设置图标和文字的间距
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
    
    // 添加按钮到工具条
    [self addSubview:btn];
    
    // 存储按钮到btns数组中
    [self.btns addObject:btn];
    
    return btn;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    /** 设置每个按钮的frame */
    // 按钮数
    int btnCount = (int)self.btns.count;
    // 按钮的宽
    CGFloat btnW = self.width / btnCount;
    // 按钮的高
    CGFloat btnH = self.height;
    for (int i = 0; i < btnCount; i++) {
        UIButton *btn = self.btns[i];
        btn.x = i * btnW;
        btn.y = 0;
        btn.width = btnW;
        btn.height = btnH;
    }
    
    /** 设置每条分隔线的frame */
    // 分隔线数
    int dividerCount = (int)self.dividers.count;
    for (int i = 0; i < dividerCount; i++) {
        UIImageView *divider = self.dividers[i];
        divider.x = (i + 1) * btnW;
        divider.y = 0;
        divider.width = 1;
        divider.height = btnH;
    }
}

///**
// *  通过setStatus方法刷新工具条中的计数数据
// *
// *  @param status 微博
// */
//- (void)setStatus:(JHStatus *)status
//{
//    _status = status;
//        
//    [self setupButtonCount:status.reposts_count button:self.repostBtn];
//    
//    [self setupButtonCount:status.comments_count button:self.commentBtn];
//    
//    [self setupButtonCount:status.attitudes_count button:self.attitudeBtn];
//}
//
//- (void)setupButtonCount:(int)count button:(UIButton *)btn
//{
//    if (count) {
//        if (count < 10000) {
//            NSString *str = [NSString stringWithFormat:@"%d", count];
//            [btn setTitle:str forState:UIControlStateNormal];
//        } else {
//            NSString *newCount = [NSString stringWithFormat:@"%.1f万",count / 10000.0];
//            newCount = [newCount stringByReplacingOccurrencesOfString:@".0" withString:@""];
//            [btn setTitle:newCount forState:UIControlStateNormal];
//        }
//    }
//}

//FIXME: count数显示不正确

- (void)setStatus:(JHStatus *)status
{
    _status = status;
    //    status.reposts_count = 580456; // 58.7万
    //    status.comments_count = 100004; // 1万
    //    status.attitudes_count = 604; // 604
    
    // 转发
    [self setupBtnCount:status.reposts_count btn:self.repostBtn title:@"转发"];
    // 评论
    [self setupBtnCount:status.comments_count btn:self.commentBtn title:@"评论"];
    // 赞
    [self setupBtnCount:status.attitudes_count btn:self.attitudeBtn title:@"赞"];
}

- (void)setupBtnCount:(int)count btn:(UIButton *)btn title:(NSString *)title
{
    if (count) { // 数字不为0
        if (count < 10000) { // 不足10000：直接显示数字，比如786、7986
            title = [NSString stringWithFormat:@"%d", count];
        } else { // 达到10000：显示xx.x万，不要有.0的情况
            double wan = count / 10000.0;
            title = [NSString stringWithFormat:@"%.1f万", wan];
            // 将字符串里面的.0去掉
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }
    }
    [btn setTitle:title forState:UIControlStateNormal];
}

@end
