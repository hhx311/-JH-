//
//  JHNewFeatureViewController.m
//  新浪微博(JH)
//
//  Created by JasonHuang on 15/9/14.
//  Copyright (c) 2015年 MyIOS. All rights reserved.
//

#define JHNewFeatureImageCount 4

#import "JHNewFeatureViewController.h"
#import "JHTabBarViewController.h"

@interface JHNewFeatureViewController ()<UIScrollViewDelegate>
/**
 *  图片滚动视图
 */
@property (nonatomic, weak) UIScrollView *scrollView;

/**
 *  pageControl
 */
@property (nonatomic, weak) UIPageControl *pageControl;


@end

@implementation JHNewFeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
//    scrollView.backgroundColor = JHRandomColor;
    
    // 加载图片至scrollView上
    for (int i = 0; i<JHNewFeatureImageCount; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        // 设置imageView的尺寸和位置
        imageView.width = scrollView.width;
        imageView.height = scrollView.height;
        imageView.x = i * scrollView.width;
        imageView.y = 0;
        NSString *imageName = [NSString stringWithFormat:@"new_feature_%d",i+1];
        imageView.image = [UIImage imageNamed:imageName];
        [scrollView addSubview:imageView];
        if (i == JHNewFeatureImageCount - 1) { // 新特性最后一页需设置一些功能,此处判断进行跳转设置
            [self setLastNewFeaturePage:imageView];
        }
    }
    
    // 设置scrollView滚动范围
    scrollView.contentSize = CGSizeMake(scrollView.width * JHNewFeatureImageCount, 0);
    // 设置按页滚动
    scrollView.pagingEnabled = YES;
    // 隐藏滚动指示栏
    scrollView.showsHorizontalScrollIndicator = NO;
    // 禁止弹簧效果
    scrollView.bounces = NO;
    // 设置控制器为scrollView的代理
    scrollView.delegate = self;
    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    // 显示页数
    pageControl.numberOfPages = JHNewFeatureImageCount;
    // 备选页指示器颜色
    pageControl.pageIndicatorTintColor = JHColor(189, 78, 33);
    // 当前页指示器颜色
    pageControl.currentPageIndicatorTintColor = JHColor(189, 189, 189);
    // 设置pageControl的位置
    pageControl.centerX = scrollView.width * 0.5;
    pageControl.centerY = scrollView.height - 60;
    
    self.pageControl = pageControl;
    [self.view addSubview:pageControl];
    
}

/**
 *  设置最后一页
 */
- (void)setLastNewFeaturePage:(UIImageView *)imageView
{
    // 开启imageView的交互功能
    imageView.userInteractionEnabled = YES;
    
    // 设置分享
    UIButton *share = [[UIButton alloc] init];
    // 设置frame
    share.width = 200;
    share.height = 30;
    share.centerX = imageView.width * 0.5;
    share.centerY = imageView.height * 0.7;
    
    // 设置文字
    [share setTitle:@"分享给大家" forState:UIControlStateNormal];
    [share setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    share.titleLabel.font = [UIFont systemFontOfSize:15];
    
    // 设置图片
    [share setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [share setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    
    // 增加图片和文字之间的间隙
    share.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    share.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    
    // 监听share按钮的点击
    [share addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 加载share按钮
    [imageView addSubview:share];
    
    // 设置开始微博
    UIButton *start = [[UIButton alloc] init];
    
    // 设置文字
    [start setTitle:@"开始微博" forState:UIControlStateNormal];
    
    // 设置图片
    [start setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [start setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    
    // 设置frame
    start.size = start.currentBackgroundImage.size;
    start.centerX = share.centerX;
    start.centerY = imageView.height * 0.8;
    
    // 监听start按钮点击
    [start addTarget:self action:@selector(startClick) forControlEvents:UIControlEventTouchUpInside];
    
    // 添加start按钮
    [imageView addSubview:start];
}

/**
 *  监听share按钮点击
 */
- (void)shareClick:(UIButton *)share
{
    // share按钮选中状态取反
    share.selected = !share.selected;
}

/**
 *  监听start按钮点击
 */
- (void)startClick
{
    // 切换根控制器
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = [[JHTabBarViewController alloc] init];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 设置pageControl当前显示的是第几页
    self.pageControl.currentPage = (int)(scrollView.contentOffset.x / scrollView.width + 0.5);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
