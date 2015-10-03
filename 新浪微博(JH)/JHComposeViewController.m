//
//  JHComposeViewController.m
//  新浪微博(JH)
//
//  Created by JasonHuang on 15/9/12.
//  Copyright (c) 2015年 MyIOS. All rights reserved.
//

#import "JHComposeViewController.h"
#import "JHTextView.h"
#import "JHAccountTool.h"
#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"
#import "JHComposeToolBar.h"
#import "JHComposePhotosView.h"

@interface JHComposeViewController () <UITextViewDelegate,JHComposeToolBarDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
/** 发微博工具条 */
@property (nonatomic, weak) JHComposeToolBar *toolBar;

/** 发微博的配图(全部) */
@property (nonatomic, weak) JHComposePhotosView *photosView;
@end

@implementation JHComposeViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏
    [self setupNav];
    
    // 设置textView
    [self setupTextView];
    
    // 设置toolBar
    [self setToolBar];
    
    // 设置相册
    [self setupPhotosView];
}

- (void)setupPhotosView
{
    JHComposePhotosView *photosView = [[JHComposePhotosView alloc] init];
    photosView.y = 100;
    photosView.width = self.view.width;
    photosView.height = self.view.height;
    [self.textView addSubview:photosView];
    self.photosView = photosView;
}

- (void)setToolBar
{
    JHComposeToolBar *toolBar = [[JHComposeToolBar alloc] init];
    toolBar.width = self.view.width;
    toolBar.height = 44;
    toolBar.y = self.view.height - toolBar.height;
    toolBar.delegate = self;
    [self.view addSubview:toolBar];
    self.toolBar = toolBar;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
    // 键盘的frame
    CGRect keyboardF = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 动画时间
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        if (keyboardF.origin.y >= self.view.height) { // 键盘隐藏状态
            self.toolBar.y = self.view.height - self.toolBar.height;
        } else { // 键盘弹出状态
            self.toolBar.y = keyboardF.origin.y - self.toolBar.height;
        }
    }];
}

- (void)setupNav
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    
    NSString *name = [JHAccountTool account].name;
    NSString *prefix = @"发微博";
    if (name) {
        UILabel *titleView = [[UILabel alloc] init];
        titleView.width = 200;
        titleView.height = 100;
        titleView.textAlignment = NSTextAlignmentCenter;
        // 自动换行
        titleView.numberOfLines = 0;
        titleView.y = 50;
        
        NSString *str = [NSString stringWithFormat:@"%@\n%@", prefix, name];
        
        // 创建一个带有属性的字符串（比如颜色属性、字体属性等文字属性）
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
        // 添加属性
        [attrStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:[str rangeOfString:prefix]];
        [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:[str rangeOfString:name]];
        [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:[str rangeOfString:name]];
        titleView.attributedText = attrStr;
        self.navigationItem.titleView = titleView;
    } else {
        self.title = prefix;
    }
}

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)send
{
    if (self.photosView.photos.count) {
        [self sendWithImage];
    } else {
        [self sendWithoutImage];
    }
    // dismiss
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)sendWithImage
{
    // URL: https://upload.api.weibo.com/2/statuses/upload.json
    // 参数:
    /**	status true string 要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。*/
    /**	access_token true string*/
    /**	pic true binary 微博的配图。*/
    
    // 请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [JHAccountTool account].access_token;
    params[@"status"] = self.textView.text;
    
    // 发送请求
    [mgr POST:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        //FIXME: 不能发送多张图
        // 拼接所有图片
        NSMutableData *datas = [NSMutableData data];
        for (UIImage *image in self.photosView.photos) {
            NSData *data = UIImageJPEGRepresentation(image, 1.0);
            [datas appendData:data];
        }
//        JHLog(@"%@ %@",datas,self.photosView.photos);

        [formData appendPartWithFileData:datas name:@"pic" fileName:@"test.jpg" mimeType:@"image/jpeg"];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"请求失败"];
    }];
}

- (void)sendWithoutImage
{
    // URL: https://api.weibo.com/2/statuses/update.json
    // 参数:
    /**	status true string 要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。*/
    /**	pic false binary 微博的配图。*/
    /**	access_token true string*/
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [JHAccountTool account].access_token;
    params[@"status"] = self.textView.text;
    
    // 3.发送请求
    [mgr POST:@"https://api.weibo.com/2/statuses/update.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
    }];
}

- (void)setupTextView
{
    JHTextView *textView = [[JHTextView alloc] init];
    
    textView.frame = self.view.bounds;
    
    textView.font = [UIFont systemFontOfSize:15];
    
    textView.placeholder = @"分享新鲜事...";
    
    textView.delegate =self;
    
    // 设置垂直弹簧效果
    textView.alwaysBounceVertical = YES;
    
    [self.view addSubview:textView];
    
    self.textView = textView;
        
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:textView];
}

- (void)textDidChange
{
    self.navigationItem.rightBarButtonItem.enabled = self.textView.hasText;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.textView becomeFirstResponder];
}

- (void)viewDidLayoutSubviews
{
    // 初始进入发微博界面时"发送"按钮不可用
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

#pragma mark - JHComposeToolBarDelegate
- (void)toolBar:(JHComposeToolBar *)toolBar didClickButton:(JHComposeToolBarButtonType)buttonType
{
    switch (buttonType) {
        case JHComposeToolBarButtonTypeCamera:
            [self openCamera];
            break;
            
        case JHComposeToolBarButtonTypePicture:
            [self openAlbum];
            break;
            
        case JHComposeToolBarButtonTypeMention:
            JHLog(@"@");
            break;
            
        case JHComposeToolBarButtonTypeTrend:
            JHLog(@"#");
            break;
            
        case JHComposeToolBarButtonTypeEmotion:
            JHLog(@"表情");
            break;
    }
}

#pragma mark - 其他方法
- (void)openCamera
{
    [self openUIImagePickerControllerWithSourceType:UIImagePickerControllerSourceTypeCamera];
}

- (void)openAlbum
{
    [self openUIImagePickerControllerWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

/**
 *  根据UIImagePickerControllerSourceType打开UIImagePickerController
 */
- (void)openUIImagePickerControllerWithSourceType:(UIImagePickerControllerSourceType)sourceType
{
    if (![UIImagePickerController isSourceTypeAvailable:sourceType]) return;
    
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    
    ipc.sourceType = sourceType;
    
    ipc.delegate = self;
    
    [self presentViewController:ipc animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    [self.photosView addPhoto:image];
}

@end
