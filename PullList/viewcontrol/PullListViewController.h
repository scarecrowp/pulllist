//
//  PullListViewController.h
//  PullList
//
//  Created by user on 14-8-28.
//  Copyright (c) 2014年 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LKDBHelper.h"
@interface PullListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *dataArr;
    LKDBHelper *dbhelper;
    int page;
}
@property (strong, nonatomic) IBOutlet UIView *footview;
@property (weak, nonatomic) IBOutlet UITextField *tb_serch;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UILabel *lb_loading;
@property (weak, nonatomic) IBOutlet UIButton *bt_load;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) IBOutlet UIView *headview;
- (IBAction)do_serch:(id)sender;
- (IBAction)do_clear:(id)sender;
- (IBAction)loadmore:(id)sender;

@end
