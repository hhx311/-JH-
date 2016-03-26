//
//  JHEmotionAttachment.m
//  新浪微博(JH)
//
//  Created by JasonHuang on 15/10/4.
//  Copyright © 2015年 MyIOS. All rights reserved.
//

#import "JHEmotionAttachment.h"
#import "JHEmotion.h"

@implementation JHEmotionAttachment
- (void)setEmotion:(JHEmotion *)emotion
{
    _emotion = emotion;
    
    self.image = [UIImage imageNamed:emotion.png];
}
@end
