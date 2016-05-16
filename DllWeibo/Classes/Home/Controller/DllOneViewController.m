//
//  DllOneViewController.m
//  DllWeibo
//
//  Created by zcdll on 16/5/8.
//  Copyright © 2016年 ZC. All rights reserved.
//

#import "DllOneViewController.h"
#import "UIBarButtonItem+Item.h"
#import "DllTwoViewController.h"


@interface DllOneViewController ()

@end

@implementation DllOneViewController

// init 底层会调用initWithNibName
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
//    NSLog(@"%s", __func__);
    
    return [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
}
- (IBAction)jump2Two:(id)sender {
    
    DllTwoViewController *two = [[DllTwoViewController alloc] init];
    
    [self.navigationController pushViewController:two animated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//
//    return 0;
//}

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//
//    return 3;
//}
//
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    static NSString *ID = @"cell";
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    
//    if (cell == nil) {
//        
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
//        
//        cell.backgroundColor = [UIColor clearColor];
//        
//    }
//    
//    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
//    
//    return cell;
//}


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
