
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

@interface JHHomeViewController ()<JHDropdownMenuDelegate>

@end

@implementation JHHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 设置首页的左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(friendsearch:) image:@"navigationbar_friendsearch" highlightedImage:@"navigationbar_friendsearch_highlighted"];
    // 设置首页的右边按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(pop) image:@"navigationbar_pop" highlightedImage:@"navigationbar_pop_highlighted"];
    
    // 设置首页中间标题
    UIButton *titleButton = [[UIButton alloc] init];
    // 设置尺寸
    titleButton.width = 160;
    titleButton.height = 30;
    // 设置图片
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
    // 设置文字
    [titleButton setTitle:@"首页" forState:UIControlStateNormal];
    titleButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    // 设置文字和图标的位置
    titleButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 50);
    titleButton.imageEdgeInsets = UIEdgeInsetsMake(0, 50, 0, 0);
    
    self.navigationItem.titleView = titleButton;
    
    // 添加按钮点击监听
    [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)titleButtonClick:(UIButton *)titleButton
{
    JHDropdownMenu *menu = [JHDropdownMenu menu];
    JHTitleMenuViewController *vc = [[JHTitleMenuViewController alloc] init];
    vc.view.width = 150;
    vc.view.height = 44 * 3;
    menu.contentController = vc;
    
    /* 测试用
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    UIButton *btn = [[UIButton alloc] init];
    btn.width = 130;
    btn.height = 130;
    btn.backgroundColor = [UIColor redColor];
    [btn setBackgroundImage:[UIImage imageNamed:@"album"] forState:UIControlStateNormal];
    menu.content = btn;
     */
    
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
