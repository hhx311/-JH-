//
//  JHComposeToolBar.h
//  新浪微博(JH)
//
//  Created by JasonHuang on 15/9/30.
//  Copyright © 2015年 MyIOS. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    /** 相机 */
    JHComposeToolBarButtonTypeCamera,
    /** 相册 */
    JHComposeToolBarButtonTypePicture,
    /** @ */
    JHComposeToolBarButtonTypeMention,
    /** # */
    JHComposeToolBarButtonTypeTrend,
    /** 表情 */
    JHComposeToolBarButtonTypeEmotion
} JHComposeToolBarButtonType;

@class JHComposeToolBar;

@protocol JHComposeToolBarDelegate <NSObject>

@optional

- (void)toolBar:(JHComposeToolBar *)toolBar didClickButton:(JHComposeToolBarButtonType)buttonType;

@end

@interface JHComposeToolBar : UIView
@property (nonatomic, weak) id<JHComposeToolBarDelegate> delegate;
/** 是否要显示键盘按钮  */
@property (nonatomic, assign) BOOL showKeyboardButton;
@end
