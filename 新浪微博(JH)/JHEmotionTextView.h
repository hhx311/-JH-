//
//  JHEmotionTextView.h
//  新浪微博(JH)
//
//  Created by JasonHuang on 15/10/4.
//  Copyright © 2015年 MyIOS. All rights reserved.
//

#import "JHTextView.h"
@class JHEmotion;
@interface JHEmotionTextView : JHTextView
- (void)insertEmotion:(JHEmotion *)emotion;

- (NSString *)fullText;
@end
