//
//  ListCell.h
//  PullList
//
//  Created by user on 14-8-28.
//  Copyright (c) 2014年 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lb_title;
@property (weak, nonatomic) IBOutlet UILabel *lv_time;
-(void)setTitle:(NSString *)_title;
-(void)setTime:(NSString *)_time;
@end
