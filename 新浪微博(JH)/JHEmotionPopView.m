

//
//  JHEmotionPopView.m
//  新浪微博(JH)
//
//  Created by JasonHuang on 15/10/4.
//  Copyright © 2015年 MyIOS. All rights reserved.
//

#import "JHEmotionPopView.h"
#import "JHEmotionButton.h"

@interface JHEmotionPopView()
@property (weak, nonatomic) IBOutlet JHEmotionButton *emotionButton;
@end

@implementation JHEmotionPopView

+ (instancetype)popView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"JHEmotionPopView" owner:nil options:nil] lastObject];
}

- (void)showFrom:(JHEmotionButton *)button
{
    if (button == nil) return;

    // 给popView传递数据
    self.emotionButton.emotion = button.emotion;
    
    // 取得最上面的window
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];
    
    // 计算出被点击的按钮在window中的frame
    CGRect btnFrame = [button convertRect:button.bounds toView:nil];
    self.y = CGRectGetMidY(btnFrame) - self.height; // 100
    self.centerX = CGRectGetMidX(btnFrame);
}

@end
