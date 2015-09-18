
//
//  JHHomeViewController.m
//  新浪微博(JH)
//
//  Created by JasonHuang on 15/9/10.
//  Copyright (c) 2015年 MyIOS. All rights reserved.
//

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


@interface JHHomeViewController ()<JHDropdownMenuDelegate>
/**
 *  微博数组(存储着JHStatus微博模型,每个JHStatus对象对应一条微博)
 */
@property (nonatomic, strong) NSMutableArray *statuses;
@end

@implementation JHHomeViewController

/**
 *  微博数组(存储着JHStatus微博模型,每个JHStatus对象对应一条微博)
 */
- (NSMutableArray *)statuses
{
    if (_statuses == nil) {
        self.statuses = [NSMutableArray array];
    }
    return _statuses;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏
    [self setupNav];
    
    // 设置用户信息(昵称)
    [self setupUserInfo];
        
    // 加载数据及下拉刷新
    [self setupRefresh];

    // 设置cell高度
    self.tableView.rowHeight = 150;
}

/**
 *  加载数据及下拉刷新
 */
- (void)setupRefresh
{
    // 创建UIRefreshControl
    UIRefreshControl *control = [[UIRefreshControl alloc] init];
    
   // 添加监听UIRefreshControl刷新控件, 用户有下拉拖拽时才会触发
    [control addTarget:self action:@selector(refreshStatus:) forControlEvents:UIControlEventValueChanged];
    
    // 添加刷新控件到tableView上
    [self.tableView addSubview:control];
    
    // 手动触发刷新事件, 只会显示刷新图标,但不执行下拉拖拽
    [control beginRefreshing];
    
    // 立马加载刷新的数据,实现首次加载时初始化
    [self refreshStatus:control];
}

/**
 *  监听UIRefreshControl刷新控件的pull(拉拽)事件
 *
 *  @param control 刷新控件(UIRefreshControl)
 */
- (void)refreshStatus:(UIRefreshControl *)control
{
    // 请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 拼接请求参数
    JHAccount *account = [JHAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;

    // 取出最前面的微博（最新的微博，ID最大的微博）
    JHStatus *firstStatus = [self.statuses firstObject];
    if (firstStatus) { // 已加载过微博数据
        // since_id:若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0
        params[@"since_id"] = firstStatus.idstr;
    }
    
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 将加载的字典数组转换成模型数组,用数组存储最新微博模型
        NSArray *newStatuses = [JHStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
        // 将最新的微博数据，添加到总数组的最前面
        NSRange range = NSMakeRange(0, newStatuses.count);
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.statuses insertObjects:newStatuses atIndexes:indexSet];
        
        // 易错写法
//        [self.statuses insertObject:<#(nonnull id)#> atIndex:<#(NSUInteger)#>];

        // 刷新表格
        [self.tableView reloadData];
        
        // 结束刷新
        [control endRefreshing];
        
        // 显示最新微博数
        [self showNewStatusesCount:(int)newStatuses.count];
   
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        JHLog(@"加载失败---%@",error);
        
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
    // 创建显示最新微博数的lable
    UILabel *lable = [[UILabel alloc] init];
    
    // 设置lable背景色
    lable.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    
    // 设置lable的文本内容
    if (count) { // 有最新的微博
        lable.text = [NSString stringWithFormat:@"总共%d条最新微博",count];
    } else { // 没有最新微博
        lable.text = [NSString stringWithFormat:@"没有最新的微博,请稍后再试"];
    }
    
    // 设置lable文本显示居中
    lable.textAlignment = NSTextAlignmentCenter;
    
    // 设置lable文本字体大小和颜色
    lable.font = [UIFont systemFontOfSize:17];
    lable.textColor = [UIColor whiteColor];
    
    // 设置lable初始frame
    lable.x = 0;
    lable.width = [UIScreen mainScreen].bounds.size.width;
    lable.height = 30;
    lable.y = CGRectGetMaxY(self.navigationController.navigationBar.frame) - lable.height;
    
    // 添加lable至navagationBar
    [self.navigationController.view insertSubview:lable belowSubview:self.navigationController.navigationBar];
    
    // 动画显示/隐藏 lable文本框
    [UIView animateWithDuration:1.0 animations:^{
        
        // 更改transform
        lable.transform = CGAffineTransformMakeTranslation(0, lable.height);
        
    } completion:^(BOOL finished) {
        
        // 设置动画隐藏lable, 并移除
        [UIView animateWithDuration:1.0 delay:1.5 options:UIViewAnimationOptionCurveLinear animations:^{
          
            // 恢复transform
            lable.transform = CGAffineTransformIdentity;
            
        } completion:^(BOOL finished) {
            
            // 移除lable文本框
            [lable removeFromSuperview];
        }];
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
    [mgr GET:@"https://api.weibo.com/2/users/show.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
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
    return self.statuses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *ID = [NSString stringWithFormat:@"status"];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    // 取出这行对应的微博字典
    JHStatus *status = self.statuses[indexPath.row];
    
    // 设置这条微博的用户昵称
    JHUser *user = status.user;
    cell.textLabel.text = user.name;
    
    // 设置微博正文内容
    cell.detailTextLabel.text = status.text;
    // 设置换行
    cell.detailTextLabel.numberOfLines = 0;
    
    // 设置这条微博的用户头像
    // 图片url地址
    NSURL *url = [NSURL URLWithString:user.profile_image_url];
    // 占位图
    UIImage *placeholderImage = [UIImage imageNamed:@"avatar_default"];
    [cell.imageView sd_setImageWithURL:url placeholderImage:placeholderImage];
    
    return cell;
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
