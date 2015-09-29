//
//  JHTabBarViewController.m
//  新浪微博(JH)
//
//  Created by JasonHuang on 15/9/10.
//  Copyright (c) 2015年 MyIOS. All rights reserved.
//

#import "JHTabBarViewController.h"
#import "JHNavigationController.h"
#import "JHHomeViewController.h"
#import "JHMessageCenterViewController.h"
#import "JHComposeViewController.h"
#import "JHDiscoverViewController.h"
#import "JHProfileViewController.h"
#import "JHTabBar.h"

@interface JHTabBarViewController ()<JHTabBarDelegate,JHComposeViewControllerDelegate>
/** compose(发微博)控制器 */
@property (nonatomic, strong) JHComposeViewController *compose;
@end

@implementation JHTabBarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置子控制器
    // 设置home(主页)
    JHHomeViewController *home = [[JHHomeViewController alloc] init];
    [self setTabBarChildVc:home title:@"首页" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    
    // 设置messageCenter(消息)
    JHMessageCenterViewController *messageCenter = [[JHMessageCenterViewController alloc] init];
    [self setTabBarChildVc:messageCenter title:@"消息" image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];
    
    // 设置discover(发现)
    JHDiscoverViewController *discover = [[JHDiscoverViewController alloc] init];
    [self setTabBarChildVc:discover title:@"发现" image:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];
    
    // 设置profile(我)
    JHProfileViewController *profile = [[JHProfileViewController alloc] init];
    [self setTabBarChildVc:profile title:@"我" image:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];
    
    // 移除系统自带的tabBar
    JHTabBar *tabBar = [[JHTabBar alloc] init];
    [self setValue:tabBar forKeyPath:@"tabBar"]; // 这行代码过后,tabBar的代理已经设置为JHTabBarViewController(即self)

}

/**
 *  设置子控制器
 *
 *  @param childVc       子控制器名称
 *  @param title         标题
 *  @param image         图片
 *  @param selectedImage 选中时图片
 */
- (void)setTabBarChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置子控制器的文字和图片
    childVc.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 设置子控制器的文字样式
    childVc.tabBarItem.title = title;
    NSMutableDictionary *titleTextAttrs = [NSMutableDictionary dictionary];
    titleTextAttrs[NSForegroundColorAttributeName] = JHColor(123, 123, 123);
    [childVc.tabBarItem setTitleTextAttributes:titleTextAttrs forState:UIControlStateNormal];
    NSMutableDictionary *titleTextSelectedAttrs = [NSMutableDictionary dictionary];
    titleTextSelectedAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [childVc.tabBarItem setTitleTextAttributes:titleTextSelectedAttrs forState:UIControlStateSelected];
    
    JHNavigationController *nav = [[JHNavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
}

#pragma mark - 实现JHTabBarDelegate代理方法
/**
 *  展开添加栏
 */
- (void)tabBarDidClickComposeButtonUnselected:(JHTabBar *)tabBar
{
    JHComposeViewController *compose = [[JHComposeViewController alloc] init];
    JHNavigationController *nav = [[JHNavigationController alloc] initWithRootViewController:compose];
//    compose.delegate = self;
    [self presentViewController:nav animated:YES completion:nil];
//    self.compose = compose;
//    compose.view.width = self.view.width;
//    compose.view.height = self.view.height - self.tabBar.height;
//    [self.view addSubview:compose.view];
}
/**
 *  收回添加栏
 */
- (void)tabBarDidClickComposeButtonSelected:(JHTabBar *)tabBar
{
    [self.compose dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 实现JHComposeViewControllerDelegate代理方法
- (void)composeViewControllerDidPop:(JHComposeViewController *)plus
{
    JHLog(@"plusViewControllerDidPop");
}

@end
