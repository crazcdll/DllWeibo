//
//  DllStatusCell.h
//  DllWeibo
//
//  Created by zcdll on 16/5/13.
//  Copyright © 2016年 ZC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DllStatusFrame;
@interface DllStatusCell : UITableViewCell

@property (nonatomic, strong) DllStatusFrame *statusF;

+(instancetype) cellWithTableView:(UITableView *)tableView;

@end
