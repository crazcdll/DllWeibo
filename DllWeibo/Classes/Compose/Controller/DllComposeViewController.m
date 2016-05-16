//
//  DllComposeViewController.m
//  DllWeibo
//
//  Created by zcdll on 16/5/15.
//  Copyright © 2016年 ZC. All rights reserved.
//

#import "DllComposeViewController.h"
#import "DllTextView.h"
#import "DllComposeToolBar.h"
#import "UIView+Frame.h"
#import "DllComposePhotosView.h"
#import "DllComposeTool.h"
#import "MBProgressHUD+MJ.h"


@interface DllComposeViewController ()<UITextViewDelegate,DllComposeToolBarDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic, weak) DllTextView *textView;
@property (nonatomic, weak) DllComposeToolBar *toolBar;
@property (nonatomic, weak) DllComposePhotosView *photoView;
@property (nonatomic, strong) UIBarButtonItem *rightItem;
@property (nonatomic, strong) NSMutableArray *images;
@end

@implementation DllComposeViewController

- (NSMutableArray *)images{
    
    if (_images == nil) {
        
        _images = [NSMutableArray array];
        
    }
    return _images;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 设置导航条
    [self setUpNavigationBar];
    
    // 添加textView
    [self setUpTextView];
    
    // 添加工具条
    [self setUpToolBar];
    
    // 监听键盘的弹出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    // 添加相册视图
    [self setUpPhotosView];
    
}

// 添加相册视图
- (void)setUpPhotosView{
    
    DllComposePhotosView *photoView = [[DllComposePhotosView alloc] initWithFrame:CGRectMake(0, 70, self.view.width, self.view.height - 70)];
    
    _photoView = photoView;
    
    [_textView addSubview:photoView];
    
}

#pragma mark - 键盘的Frame改变的时候调用
- (void)keyboardFrameChange:(NSNotification *)note{
    
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    // 获取键盘的frame
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    if (frame.origin.y == self.view.height) { // 没有弹出键盘
        
        [UIView animateWithDuration:duration animations:^{
            
            _toolBar.transform = CGAffineTransformIdentity;
            
        }];
        
    }else{ // 弹出键盘
        
        // 工具条往上移动键盘的高度
        
        [UIView animateWithDuration:duration animations:^{
            
            _toolBar.transform = CGAffineTransformMakeTranslation(0, -frame.size.height);
            
        }];
    }
    
}

#pragma mark - 设置工具条
-(void)setUpToolBar{
    
    CGFloat h = 35;
    CGFloat y = self.view.height - h;
    
    DllComposeToolBar *toolBar = [[DllComposeToolBar alloc] initWithFrame:CGRectMake(0, y, self.view.width, h)];
    
    toolBar.backgroundColor = [UIColor whiteColor];
    
    _toolBar = toolBar;
    toolBar.delegate = self;
    
    [self.view addSubview:toolBar];
    
}

#pragma mark - 点击工具条按钮的时候调用
- (void)composeToolBar:(DllComposeToolBar *)toolBar didClickBtn:(NSInteger)index{
    
    if (index == 0) { // 点击相册
        
        // 弹出系统的相册
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        
        // 设置相册类型，相册集
        //imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        
        imagePicker.delegate = self;
        
        [self presentViewController:imagePicker animated:YES completion:nil];
        
    }
    
}

#pragma mark - 选择图片完成的时候调用
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    // 获取选中的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    [self.images addObject:image];
    _photoView.image = image;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    _rightItem.enabled = YES;
    
}


- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    //设置自动弹出键盘
    [_textView becomeFirstResponder];
    
}

#pragma mark - 添加textView
- (void)setUpTextView{
    
    DllTextView *textView = [[DllTextView alloc] initWithFrame:self.view.bounds];
    
    _textView = textView;
    
    // 设置占位符
    textView.placeHolder = @"分享新鲜事...";
    textView.font = [UIFont systemFontOfSize:15];
    
    [self.view addSubview:textView];
    
    // 设置textView默认允许垂直方向拖拽
    textView.alwaysBounceVertical = YES;
    
    // 监听文本框的输入
    /**
     *  Observer：谁需要监听通知
     *  name：监听通知的名称
     *  object：监听谁发送的通知，nil：表示谁发送我都监听
     */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:nil];
    
    // 监听拖拽
    _textView.delegate = self;
    
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [self.view endEditing:YES];
    
}

#pragma mark - 文字改变的时候调用
- (void)textChange{
    
    // 判断下textfield有没有内容
    if (_textView.text.length) { // 有内容
        
        _textView.hidePlaceHolder = YES;
        _rightItem.enabled = YES;
        
    }else{
        
        _textView.hidePlaceHolder = NO;
        _rightItem.enabled = NO;
    }
    
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (void)setUpNavigationBar{
    
    self.title = @"发微博";
    
    // 左边 取消
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:0 target:self action:@selector(dismiss)];
    
    // 右边 发送

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"发送" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [btn sizeToFit];
    
    // 监听按钮的点击
    [btn addTarget:self action:@selector(compose) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    rightItem.enabled = NO;
    
    self.navigationItem.rightBarButtonItem = rightItem;
    _rightItem = rightItem;
    
    
}

// 取消按钮
- (void)dismiss{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - 发送微博
- (void)compose{
    
    //判断下有没有图片
    if (self.images.count) {
        
        // 发送图片
        [self sendPics];
        
        
    }else{
        
        // 发送文字
        [self sendText];
        
    }
}

#pragma mark - 发送文字
- (void)sendText{
    
    [DllComposeTool composeWithStatus:_textView.text success:^{
        
        NSLog(@"发送成功");
        // 提示用户发送成功
        [MBProgressHUD showSuccess:@"发送成功"];
        
        // 回到首页
        [self dismissViewControllerAnimated:YES completion:nil];
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
    
}

#pragma mark - 发送图片
- (void)sendPics{
    
    UIImage *image = self.images[0];
    NSString *status = _textView.text.length?_textView.text:@"分享图片";
    
    _rightItem.enabled = NO;
    // 小心循环引用，我引用你，你引用我
    [DllComposeTool composeWithPics:status image:image success:^{
        
        // 提示用户发送成功
        [MBProgressHUD showSuccess:@"发送图片微博成功"];
        
        //回到首页
        [self dismissViewControllerAnimated:YES completion:nil];
        _rightItem.enabled = YES;
        
    } failure:^(NSError *error) {
        
        _rightItem.enabled = YES;
        [MBProgressHUD showError:@"发送失败"];
        NSLog(@"%@",error);
        
    }];
    
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
