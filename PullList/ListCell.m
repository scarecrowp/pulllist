//
//  ListCell.m
//  PullList
//
//  Created by user on 14-8-28.
//  Copyright (c) 2014年 user. All rights reserved.
//

#import "ListCell.h"

@implementation ListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setTitle:(NSString *)_title
{
    _lb_title.text=_title;

}
-(void)setTime:(NSString *)_time
{
    _lv_time.text=_time;
    
}
@end
