//
//  DllHomeViewController.m
//  DllWeibo
//
//  Created by zcdll on 16/5/8.
//  Copyright © 2016年 ZC. All rights reserved.
//

#import "DllHomeViewController.h"
#import "UIBarButtonItem+Item.h"
#import "DllTitleButton.h"

#import "DllPopMenu.h"
#import "DllCover.h"
#import "DllOneViewController.h"

#import "UIImage+Image.h"
#import "UIView+Frame.h"

#import "Dll.pch"
#import "AFNetworking.h"
#import "DllAccount.h"
#import "DllAccountTool.h"
#import "DllStatus.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "DllHttpTool.h"
#import "DllStatusTool.h"
#import "DllUserTool.h"
#import "DllStatusCell.h"
#import "DllStatusFrame.h"

@interface DllHomeViewController ()<DllCoverDelegate>

@property (nonatomic, weak) DllTitleButton *titleButton;

@property (nonatomic, strong) DllOneViewController *one;
/**
 *  ViewModel:DllStatusFrame
 */
@property (nonatomic, strong) NSMutableArray *statusFrames;

@end

@implementation DllHomeViewController

- (NSMutableArray *) statusFrames {
    
    if (_statusFrames == nil) {
        
        _statusFrames = [NSMutableArray array];
        
    }
    return _statusFrames;
    
}

-(DllOneViewController *)one{
    
    if (_one == nil) {
        
        _one = [[DllOneViewController alloc] init];
        
    }
    
    return _one;
}

// UIBarButtonItem:决定导航条上按钮的内容
// UINavigationItem:决定导航条上内容
// UITabBarItem:决定tabBar上按钮的内容
// iOS7之后，会把tabBar上和导航条上的按钮渲染成蓝色
// 导航条上自定义按钮的位置是由系统决定，尺寸才需要自己设置

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**
     *  这里的 tableView 包含三类 cell ，原创，转发，工具条。
     */
    
    // 设置整个 tableView 的背景色为灰色
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    
    // 取消分割线，原创微博和转发微博中间的分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //设置导航条内容
    [self setUpNavigationBar];
    
    // 请求最新微博数据
//    [self loadNewStatus];
    
    // 添加下拉刷新控件
    [self.tableView addHeaderWithTarget:self action:@selector(loadNewStatus)];
    
    // 自动下拉刷新
    [self.tableView headerBeginRefreshing];
    
    // 添加上拉刷新控件
    [self.tableView addFooterWithTarget:self action:@selector(loadMoreStatus)];
    
    // 请求当前用户的昵称
    [DllUserTool userInfoWithSuccess:^(DllUser *user) {
        // 请求当前账号的用户信息
        // 设置导航条的标题
        [self.titleButton setTitle:user.name forState:UIControlStateNormal];
        
    } failure:^(NSError *error) {
        
        
        
    }];
}

#pragma mark - 刷新最新的微博
-(void)refresh{
    
    // 自动下拉刷新
    [self.tableView headerBeginRefreshing];
    
}

#pragma mark - 请求更多旧的微博数据
-(void)loadMoreStatus{
    
    NSString *maxIdStr = nil;
    if (self.statusFrames.count) {  // 加载更多旧的数据
        
        DllStatus *s = [[self.statusFrames lastObject] status];
        
        long long maxId = [s.idstr longLongValue] - 1 ;
        
        maxIdStr = [NSString stringWithFormat:@"%lld", maxId];
        
    }
    
    [DllStatusTool moreStatusWithMaxID:maxIdStr success:^(NSArray *statuses) {
        
        // 结束上拉刷新
        [self.tableView footerEndRefreshing];
        
        // 模型转换视图模型 DllStatus -> DllStatusFrame
        NSMutableArray *statusFrames = [NSMutableArray array];
        for (DllStatus *status in statuses) {
            
            DllStatusFrame *statusF = [[DllStatusFrame alloc] init];
            statusF.status = status;
//            NSLog(@"旧旧旧===%@", status.idstr);
            [statusFrames addObject:statusF];
            
        }

        
        // 把旧的微博数据插入到最后面
        // 把数组中的元素添加进去
        [self.statusFrames addObjectsFromArray:statusFrames];
        
        // 刷新表格
        [self.tableView reloadData];
        
    } failure:^(NSArray *error) {
        
        
        
    }];
}

#pragma mark - 请求最新微博数据
-(void)loadNewStatus{

    NSString *sinceId = nil;
    if (self.statusFrames.count) {  // 有微博数据，才需要下拉刷新
        
        DllStatus *s = [self.statusFrames[0] status];
        sinceId = s.idstr;
        
    }
    [DllStatusTool newStatusWithSinceID:sinceId success:^(NSArray *statuses) {  // 请求成功的block
        
        // 结束下拉刷新
        [self.tableView headerEndRefreshing];
        
        // 模型转换视图模型 DllStatus -> DllStatusFrame
        NSMutableArray *statusFrames = [NSMutableArray array];
        for (DllStatus *status in statuses) {
            
            DllStatusFrame *statusF = [[DllStatusFrame alloc] init];
            statusF.status = status;
            [statusFrames addObject:statusF];
            
        }
        
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, statuses.count)];
        
        // 重复点按的时候不加载重复数据。
        DllStatus *newS = [[statusFrames lastObject] status];
        DllStatus *oldS =[[DllStatus alloc] init];
        
        if (self.statusFrames.count) {  // 有微博数据，才需要下拉刷新
            
            oldS = [self.statusFrames[0] status];
            
        }
        
        if (newS.idstr) {
            
            long long int newID = [newS.idstr longLongValue];
            long long int oldID = [oldS.idstr longLongValue];
            
            if (newID > oldID) {
                
                // 展示最新的微博数
                [self showNewStatusCount:(int)statuses.count];
                
                // 把最新的微博数据插入到最前面
                [self.statusFrames insertObjects:statusFrames atIndexes:indexSet];

            }else{
                
                NSLog(@"没有新数据");
                
            }
        }
        
        // 刷新表格
        [self.tableView reloadData];
        
    } failure:^(NSArray *error) {
        
        
        
    }];
}

#pragma mark - 展示最新的微博数
-(void)showNewStatusCount:(int)count{
    
    if (count == 0) return;
    
    // 展示最新的微博数
    CGFloat h = 35;
    CGFloat w = self.view.width;
    CGFloat x = 0;
    CGFloat y = CGRectGetMaxY(self.navigationController.navigationBar.frame) - h;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.textColor = [UIColor whiteColor];
    label.text = [NSString stringWithFormat:@"%d 条新微博", count];
    label.textAlignment = NSTextAlignmentCenter;
    
    // 插入到导航控制器下面的导航条下面
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    // 动画往下面平移
    [UIView animateWithDuration:0.25 animations:^{
        
        label.transform = CGAffineTransformMakeTranslation(0, h);
        
    } completion:^(BOOL finished) {
        
        // 平移返回
        [UIView animateWithDuration:0.25 delay:2 options:UIViewAnimationOptionCurveLinear animations:^{
            
            label.transform = CGAffineTransformIdentity;
            
        } completion:^(BOOL finished) {
            
            [label removeFromSuperview];
            
        }];
        
    }];
    
    
}

#pragma mark - 设置导航条
-(void)setUpNavigationBar{
    
    //左边
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_friendsearch"] highImage:[UIImage imageNamed:@"navigationbar_friendsearch_highlighted"] target:self action:@selector(friendSearch) forControlEvents:UIControlEventTouchUpInside];
    
    //右边
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_pop"] highImage:[UIImage imageNamed:@"navigationbar_pop_highlighted"] target:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    
    // titleView
    DllTitleButton *titleButton = [DllTitleButton buttonWithType:UIButtonTypeCustom];
    _titleButton = titleButton;
    
    [titleButton setTitle:@"首页" forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateSelected];
    //titleButton.frame = CGRectMake(100, 5, 80, 25);
    
    // 高亮的时候不需要调整图片
    titleButton.adjustsImageWhenHighlighted = NO;
    
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = titleButton;
    
}

// 以后只要显示在最前面的按钮，一般都加在主窗口
// 点击显示标题
-(void)titleClick:(UIButton *)button{
    
    button.selected = !button.selected;
    
    //弹出蒙版
    DllCover *cover = [DllCover show];
    cover.delegate = self;
    
    //弹出pop菜单
    CGFloat popW = 200;
    CGFloat popX = (self.view.width - 200) * 0.5;
    CGFloat popH = popW;
    CGFloat popY = 55;
    DllPopMenu *menu = [DllPopMenu showInRect:CGRectMake(popX, popY, popW, popH)];
    menu.contentView = self.one.view;
}

// 点击蒙版的时候调用
-(void)coverDidClickCover:(DllCover *)cover{
    
    //隐藏pop菜单
    [DllPopMenu hide];
    
    _titleButton.selected = NO;
    
}

-(void)friendSearch{
    
    //NSLog(@"%s",__func__);
//    DllLog(@"%s", __func__);
    
}

-(void)pop{
    
    // 创建one控制器
    // 1.首页去寻找有没有DllOneView.xib
    // 2.DllOneViewController.xib
    // 3.默认创建几乎透明的xib
    
    //DllOneViewController *one = [[DllOneViewController alloc] init];
    
    // 当push的时候就会隐藏底部条
    // 前提条件只会隐藏系统自带的tabBar
    //one.hidesBottomBarWhenPushed = YES;
    
    // 跳转到另外一个控制器
    //[self.navigationController pushViewController:one animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.statusFrames.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 创建cell
    DllStatusCell *cell = [DllStatusCell cellWithTableView:tableView];
    
    // 获取status数据
    DllStatusFrame *statusf = self.statusFrames[indexPath.row];
    
    // 用户昵称
//    cell.textLabel.text = status.user.name;
//    [cell.imageView sd_setImageWithURL:status.user.profile_image_url placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
//    cell.detailTextLabel.text = status.text;
    
    // 给cell传递模型
    cell.statusF = statusf;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // 获取status数据
    DllStatusFrame *statusf = self.statusFrames[indexPath.row];
    
    
    return statusf.cellHeight;
    
}

@end
