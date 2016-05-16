//
//  DllNewFeatureController.m
//  DllWeibo
//
//  Created by zcdll on 16/5/10.
//  Copyright © 2016年 ZC. All rights reserved.
//

#import "DllNewFeatureController.h"
#import "DllNewFeatureCell.h"
#import "UIView+Frame.h"

@interface DllNewFeatureController ()

@property (nonatomic, weak) UIPageControl *control;

@end

@implementation DllNewFeatureController

//static NSString * const reuseIdentifier = @"Cell";

static NSString *ID = @"cell";

- (instancetype)init
{
    // 流水布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    // 设置cell的尺寸
    layout.itemSize = [UIScreen mainScreen].bounds.size;
    // 清空行距
    layout.minimumLineSpacing = 0;
    // 设置滚动方向
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    return [super initWithCollectionViewLayout:layout];
}

// self.collectionView != self.view
// 注意：self.collectionView 是 self.view 的子控件

// 使用 UICollectionViewController 步骤
// 1.初始化的时候设置布局参数
// 2.collectionView必须要注册
// 3.自定义cell
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.collectionView.backgroundColor = [UIColor greenColor];
    
    // 注册cell，默认会创建这个类型的cell
    [self.collectionView registerClass:[DllNewFeatureCell class] forCellWithReuseIdentifier:ID];
    
    // 分页
    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    // 添加pageControl
    [self setUpPageControl];
}

// 添加pageControl
- (void)setUpPageControl{
    
    // 添加pageControl，只需要设置位置，不需要管理尺寸
    UIPageControl *control = [[UIPageControl alloc] init];
    
    control.numberOfPages = 4;
    control.pageIndicatorTintColor = [UIColor blackColor];
    control.currentPageIndicatorTintColor = [UIColor redColor];
    
    // 设置center
    control.center = CGPointMake(self.view.width * 0.5, self.view.height - 25);
    _control = control;
    [self.view addSubview:control];
    
}

#pragma mark - UIScrolView代理
// 只要一滚动就会调用
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //获取当前的偏移量，计算当前第几页
    int page = scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5;
    
    // 设置页数
    _control.currentPage = page;
    
}

#pragma mark - UICollectionView代理和数据源
// 返回有多少组
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
    
}

// 返回section组有多少个cell
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 4;
    
}

//返回cell长什么样子
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //
    // 1.首先从缓存池里取cell
    // 2.看下当前是否有注册cell，如果注册了cell，就会帮你创建cell
    // 3.没有注册，报错
    DllNewFeatureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    // 给cell传值
    
    // 拼接图片名称
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    NSString *imageName = [NSString stringWithFormat:@"new_feature_%ld", indexPath.row + 1];
    
    if (screenH > 480) {
        
        imageName = [NSString stringWithFormat:@"new_feature_%ld-568h", indexPath.row +1];
        
    }
    
    cell.image = [UIImage imageNamed:imageName];
    
    
    [cell setIndexPath:indexPath count:4];
    
    
    return  cell;
}

@end
