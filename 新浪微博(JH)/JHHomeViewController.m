
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


@interface JHHomeViewController ()<JHDropdownMenuDelegate>

@end

@implementation JHHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏
    [self setNav];
    
    // 设置用户信息(昵称)
    [self setUserInfo];
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
        NSString *name = responseObject[@"name"];
//        NSString *name = @"的啥";

        
        // 设置titleButton的标题(用户名)
        [titleButton setTitle:name forState:UIControlStateNormal];
        
        // 存储昵称到沙盒
        account.name = name;
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
    // Return the number of rows in the section.
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *ID = [NSString stringWithFormat:@""];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
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
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
