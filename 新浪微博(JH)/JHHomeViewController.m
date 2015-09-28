
//
//  JHHomeViewController.m
//  新浪微博(JH)
//
//  Created by JasonHuang on 15/9/10.
//  Copyright (c) 2015年 MyIOS. All rights reserved.
//

// 请求 微博未读数
#define JHRequest_remind_unread_count @"https://api.weibo.com/2/remind/unread_count.json"

// 请求 好友微博时间线
#define JHRequest_statuses_friends_timeline @"https://api.weibo.com/2/statuses/friends_timeline.json"

// 请求 用户信息
#define JHRequest_users_show @"https://api.weibo.com/2/users/show.json"

#import "JHHomeViewController.h"
#import "JHDropdownMenu.h"
#import "JHTitleMenuViewController.h"
#import "AFNetworking.h"
#import "JHAccountTool.h"
#import "JHTitleButton.h"
#import "UIImageView+WebCache.h"
#import "JHUser.h"
#import "JHStatus.h"
#import "MJExtension.h"
#import "JHLoadMoreFootView.h"
#import "JHStatusCell.h"
#import "JHStatusFrame.h"

@interface JHHomeViewController ()<JHDropdownMenuDelegate>
/**
 *  微博数组(存储着JHStatusFrame微博模型,每个JHStatusFrame对象对应一条微博)
 */
@property (nonatomic, strong) NSMutableArray *statusFrames;
@end

@implementation JHHomeViewController

/**
 *  微博数组(存储着JHStatusFrame微博模型,每个JHStatusFrame对象对应一条微博)
 */
- (NSMutableArray *)statusFrames
{
    if (_statusFrames == nil) {
        self.statusFrames = [NSMutableArray array];
    }
    return _statusFrames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏
    [self setupNav];
    
    // 设置用户信息(昵称)
    [self setupUserInfo];
        
    // 下拉刷新
    [self setupDownRefresh];
    
    // 上拉刷新
    [self setupUpRefresh];
    
    // 获取未读数
    // 创建timer定时器
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(setupUnreadCount) userInfo:nil repeats:YES];
    // 不管主线程是否正在其他事件,主线程也会抽时间处理一下timer
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];

}

/**
 *  设置微博未读数
 */
- (void)setupUnreadCount
{
    // 请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 拼接请求参数
    JHAccount *account = [JHAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
//    params[@"uid"] = account.uid;
    
    // 发送请求
    [mgr GET:JHRequest_remind_unread_count parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 微博未读数
        NSString *status = [responseObject[@"status"] description];
        
        if ([status isEqualToString:@"0"]) { // 没有未读微博,则清空未读数字
            self.tabBarItem.badgeValue = nil;
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        } else {
            self.tabBarItem.badgeValue = status;
            [UIApplication sharedApplication].applicationIconBadgeNumber = status.intValue;
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        JHLog(@"请求失败,稍后再试---%@",error);
    }];
}

/**
 *  上拉刷新
 */
- (void)setupUpRefresh
{
    JHLoadMoreFootView *footView = [JHLoadMoreFootView footView];
    
    footView.hidden = YES;
    
    self.tableView.tableFooterView = footView;
}

/**
 *  下拉刷新
 */
- (void)setupDownRefresh
{
    // 创建UIRefreshControl
    UIRefreshControl *control = [[UIRefreshControl alloc] init];
    
   // 添加监听UIRefreshControl刷新控件, 用户有下拉拖拽时才会触发
    [control addTarget:self action:@selector(refreshNewStatus:) forControlEvents:UIControlEventValueChanged];
    
    // 添加刷新控件到tableView上
    [self.tableView addSubview:control];
    
    // 手动触发刷新事件, 只会显示刷新图标,但不执行下拉拖拽
    [control beginRefreshing];
    
    // 立马加载刷新的数据,实现首次加载时初始化
    [self refreshNewStatus:control];
}

/**
 *  JHStatus模型数组转成JHStatusFrame模型数组
 *
 *  @param statuses 装着JHStatus模型的数组
 */
- (NSMutableArray *)statusFramesWithStatuses:(NSArray *)statuses
{
    NSMutableArray *statusFrames = [NSMutableArray array];
    
    for (JHStatus *status in statuses) {
        JHStatusFrame *statusFrame = [[JHStatusFrame alloc] init];
        statusFrame.status = status;
        [statusFrames addObject:statusFrame];
    }
    
    return statusFrames;
}

/**
 *  监听UIRefreshControl刷新控件的pull(拉拽)事件,加载最新微博
 *
 *  @param control 刷新控件(UIRefreshControl)
 */
- (void)refreshNewStatus:(UIRefreshControl *)control
{
   
    
    // 请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 拼接请求参数
    JHAccount *account = [JHAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
//    params[@"count"] = @50;

    // 取出最前面的微博（最新的微博，ID最大的微博）
    JHStatusFrame *firstStatusF = [self.statusFrames firstObject];
    if (firstStatusF) { // 已加载过微博数据
        // since_id:若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0
        params[@"since_id"] = firstStatusF.status.idstr;
    }
    
    [mgr GET:JHRequest_statuses_friends_timeline parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 将加载的字典数组转换成模型数组,用数组存储最新微博模型
        NSArray *newStatusFrames = [self statusFramesWithStatuses:[JHStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]]];
        
        // 将最新的微博数据，添加到总数组的最前面
        NSRange range = NSMakeRange(0, newStatusFrames.count);
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.statusFrames insertObjects:newStatusFrames atIndexes:indexSet];
        
        //!!!: 打印微博内容
//        JHLog(@"%@",responseObject);

        // 刷新表格
        [self.tableView reloadData];
        
        // 结束刷新
        [control endRefreshing];
        
        // 显示最新微博数
        [self showNewStatusesCount:(int)newStatusFrames.count];
   
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        JHLog(@"请求失败,稍后再试---%@",error);
        
        // 结束刷新
        [control endRefreshing];
    }];
}

/**
 *  显示最新微博数
 *
 *  @param count 最新的微博数
 */
- (void)showNewStatusesCount:(int)count
{
    if (!count) return; // 没有新微博,则直接返回
    
    // 创建显示最新微博数的lable
    UILabel *label = [[UILabel alloc] init];
    label.alpha = 0.8;
    
    // 设置lable背景色
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    
    // 设置lable的文本内容
    label.text = [NSString stringWithFormat:@"%d 条新微博",count];
    
    // 设置lable文本显示居中
    label.textAlignment = NSTextAlignmentCenter;
    
    // 设置lable文本字体大小和颜色
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor whiteColor];
    
    // 设置lable初始frame
    label.x = 0;
    label.width = [UIScreen mainScreen].bounds.size.width;
    label.height = 25;
    label.y = CGRectGetMaxY(self.navigationController.navigationBar.frame) - label.height;
    
    // 添加lable至navagationBar
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    // 动画显示/隐藏 lable文本框
    [UIView animateWithDuration:1.0 animations:^{
        // 更改transform
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
    } completion:^(BOOL finished) {
        // 设置动画隐藏lable, 并移除
        [UIView animateWithDuration:1.0 delay:2.0 options:UIViewAnimationOptionCurveLinear animations:^{
            // 恢复transform
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            // 移除lable文本框
            [label removeFromSuperview];
        }];
    }];
    
    //???: 是否会影响性能?
    // 更新刷新后的未读微博数(每次默认刷新最多20条)
    self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",[self.tabBarItem.badgeValue intValue] - count];
    [UIApplication sharedApplication].applicationIconBadgeNumber -= count;
    // 判断是否要清零
    if ([UIApplication sharedApplication].applicationIconBadgeNumber < 1) {
        self.tabBarItem.badgeValue = nil;
        [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    }
}

/**
 *  上拉加载更多历史微博
 */
- (void)loadMoreStatuses
{
    // 请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 拼接请求参数
    JHAccount *account = [JHAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    
    // 取出微博数组中最后一条微博
    JHStatusFrame *lastStatusF = [self.statusFrames lastObject];
    
    if (lastStatusF) {
        long long max_id = lastStatusF.status.idstr.longLongValue - 1;
        
        // max_id:若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
        params[@"max_id"] = @(max_id);
    }
    
    // 发送请求数据
    [mgr GET:JHRequest_statuses_friends_timeline parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 加载的历史微博数据
        NSArray *newStatusesFrames = [self statusFramesWithStatuses:[JHStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]]];
        
        // 将加载的数据存储到statuses数组中
        [self.statusFrames addObjectsFromArray:newStatusesFrames];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 隐藏footView
        self.tableView.tableFooterView.hidden = YES;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        JHLog(@"请求失败,稍后再试---%@",error);
        
        // 隐藏footView
        self.tableView.tableFooterView.hidden = YES;
    }];
}

/**
 *  设置用户信息(昵称)
 */
- (void)setupUserInfo
{
    // https://api.weibo.com/2/users/show.json
    // access_token	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
    // uid	false	int64	需要查询的用户ID。
    
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.拼接请求参数
    JHAccount *account = [JHAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    
    // 3.发送请求
    [mgr GET:JHRequest_users_show parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 标题按钮/用户名
        UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
        
        // 设置名字
        JHUser *user = [JHUser objectWithKeyValues:responseObject];
        
        // 设置titleButton的标题(用户名)
        [titleButton setTitle:user.name forState:UIControlStateNormal];
        
        // 存储昵称到沙盒
        account.name = user.name;
        [JHAccountTool saveAccount:account];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        JHLog(@"请求失败---%@",error);
    }];
}

/**
 *  设置导航栏
 */
- (void)setupNav
{
    // 设置首页的左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(friendsearch:) image:@"navigationbar_friendsearch" highlightedImage:@"navigationbar_friendsearch_highlighted"];
    // 设置首页的右边按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(pop) image:@"navigationbar_pop" highlightedImage:@"navigationbar_pop_highlighted"];
    
    // 设置首页中间标题
    JHTitleButton *titleButton = [[JHTitleButton alloc] init];
    // 设置文字
    NSString *name = [JHAccountTool account].name;

    [titleButton setTitle:name?name:@"首页" forState:UIControlStateNormal];

    // 添加按钮点击监听
    [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];

    // 添加titleButton到导航栏titleView
    self.navigationItem.titleView = titleButton;
}

/**
 *  监听标题按钮点击
 *
 *  @param titleButton 标题按钮
 */
- (void)titleButtonClick:(UIButton *)titleButton
{
    JHDropdownMenu *menu = [JHDropdownMenu menu];
    
    menu.delegate = self;
    
    JHTitleMenuViewController *vc = [[JHTitleMenuViewController alloc] init];
    vc.view.width = 150;
    vc.view.height = 44 * 3;
    
    menu.contentController = vc;
    
    [menu showFrom:titleButton];
}

/**
 *  监听左边按钮点击
 */
- (void)friendsearch:(UIBarButtonItem *)item
{
    JHLog(@"friendsearch");
}

/**
 *  监听右边按钮点击
 */
- (void)pop
{
    JHLog(@"pop");
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.statusFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JHStatusCell *cell = [JHStatusCell cellWithTableView:tableView];
    
    cell.statusFrame = self.statusFrames[indexPath.row];
    
//    NSValue *value = [NSValue valueWithCGRect:cell.statusFrame.timeLabelF];
//    JHLog(@"%@", value);
    
    return cell;
}

/**
 *  拖拽tableview时调用此方法
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 如果tableview没有数据,则直接返回
    if (!self.statusFrames.count || !self.tableView.tableFooterView.isHidden) return;
    
    // tableview拖拽的y值
    CGFloat offSetY = scrollView.contentOffset.y;
    
    // 拖拽到footView刚好出现的临界offSet的y值
    CGFloat judgeOffSetY = scrollView.contentSize.height + scrollView.contentInset.bottom - scrollView.height;
    
    // 如果拖拽到footView刚好出现在视野,设置footView的hidden为NO
    if (offSetY >= judgeOffSetY) {
        self.tableView.tableFooterView.hidden = NO;
        
        // 加载更多历史微博
        [self loadMoreStatuses];
    }
}

/**
 *  设置每个cell的height
 */
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JHStatusFrame *statusFrame = self.statusFrames[indexPath.row];
    
    return statusFrame.cellHeight;
}

#pragma mark - JHDropdownMenuDelegate代理方法
/**
 *  下拉菜单被销毁
 */
- (void)dropdownMenuDidDismiss:(JHDropdownMenu *)menu
{
    UIButton *btn = (UIButton *)self.navigationItem.titleView;
    btn.selected = NO;
}

/**
 *  下拉菜单被显示
 */
- (void)dropdownMenuDidShow:(JHDropdownMenu *)menu
{
    UIButton *btn = (UIButton *)self.navigationItem.titleView;
    btn.selected = YES;
}
@end
