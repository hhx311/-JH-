
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
 *  微博数组(存储微博字典,每个字典对应一条微博)
 */
@property (nonatomic, strong) NSMutableArray *statuses;
@end

@implementation JHHomeViewController

/**
 *  微博数组(存储微博字典,每个字典对应一条微博)
 */
- (NSMutableArray *)statuses
{
    if (_statuses == nil) {
        NSMutableArray *statuses = [NSMutableArray array];
        self.statuses = statuses;
    }
    return _statuses;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏
    [self setNav];
    
    // 设置用户信息(昵称)
    [self setUserInfo];
    
    // 加载最新的微博数据
    [self loadNewStatus];

    // 设置cell高度
    self.tableView.rowHeight = 150;
}

/**
 *  加载最新Weibo数据
 */
- (void)loadNewStatus
{
    // 请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 拼接请求参数
    JHAccount *account = [JHAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    
    // 发送请求
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 取出微博字典转成模型存储到statuses数组中
        for (NSDictionary *dict in responseObject[@"statuses"]) {
            JHStatus *status = [JHStatus statusWithDict:dict];
            [self.statuses addObject:status];
        }
        
        // 刷新表格
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        JHLog(@"请求失败---%@",error);
    }];
}

/**
 *  设置用户信息(昵称)
 */
- (void)setUserInfo
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
        
        JHUser *user = [JHUser userWithDict:responseObject];
//        NSString *name = responseObject[@"name"];
        
        // 设置titleButton的标题(用户名)
        [titleButton setTitle:user.name forState:UIControlStateNormal];
        
        // 存储昵称到沙盒
        account.name = user.name;
        [JHAccountTool saveAccount:account];
        
//        JHLog(@"%@",responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        JHLog(@"请求失败---%@",error);
    }];
}

/**
 *  设置导航栏
 */
- (void)setNav
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
    JHTitleMenuViewController *vc = [[JHTitleMenuViewController alloc] init];
    vc.view.width = 150;
    vc.view.height = 44 * 3;
    menu.contentController = vc;
    
    menu.delegate = self;
    
    [menu showFrom:titleButton];
    
}


- (void)friendsearch:(UIBarButtonItem *)item
{
    JHLog(@"friendsearch");
}

- (void)pop
{
    JHLog(@"pop");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
