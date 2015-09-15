//
//  JHPlusViewController.m
//  新浪微博(JH)
//
//  Created by JasonHuang on 15/9/12.
//  Copyright (c) 2015年 MyIOS. All rights reserved.
//

#import "JHPlusViewController.h"

@interface JHPlusViewController ()

@end

@implementation JHPlusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    self.title = @"plus";
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(30, 30, 100, 100);
    imageView.backgroundColor = [UIColor redColor];
    [self.view addSubview:imageView];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    btn.x = 100;
    btn.y =100;
    [self.view addSubview:btn];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([self.delegate respondsToSelector:@selector(plusViewControllerDidPop:)]) {
        [self.delegate plusViewControllerDidPop:self];
    }
    JHLog(@"touchesBegan");
    
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
