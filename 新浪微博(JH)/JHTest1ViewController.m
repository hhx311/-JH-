//
//  JHTest1ViewController.m
//  新浪微博(JH)
//
//  Created by JasonHuang on 15/9/10.
//  Copyright (c) 2015年 MyIOS. All rights reserved.
//

#import "JHTest1ViewController.h"

@interface JHTest1ViewController ()

@end

@implementation JHTest1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"测试控制器1";
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UIViewController *view2 = [[UIViewController alloc] init];
    view2.view.backgroundColor = JHRandomColor;
    view2.title = @"测试控制器2";
    [self.navigationController pushViewController:view2 animated:YES];
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
