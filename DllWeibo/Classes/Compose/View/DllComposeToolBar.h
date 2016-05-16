//
//  DllComposeToolBar.h
//  DllWeibo
//
//  Created by zcdll on 16/5/15.
//  Copyright © 2016年 ZC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DllComposeToolBar;
@protocol DllComposeToolBarDelegate <NSObject>

@optional
- (void)composeToolBar:(DllComposeToolBar *)toolBar didClickBtn:(NSInteger)index;

@end


@interface DllComposeToolBar : UIView

@property (nonatomic, weak) id<DllComposeToolBarDelegate> delegate;

@end
