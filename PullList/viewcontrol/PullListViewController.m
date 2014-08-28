//
//  PullListViewController.m
//  PullList
//
//  Created by user on 14-8-28.
//  Copyright (c) 2014年 user. All rights reserved.
//

#import "PullListViewController.h"
#import "ListCell.h"
#import "LKDBHelper.h"
#import "News.h"
#import "myNetPost.h"
@interface PullListViewController ()

@end

@implementation PullListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _tableview.dataSource=self;
    _tableview.delegate=self;
    _tableview.tableFooterView=_footview;
    _lb_loading.hidden=YES;
    _activityIndicator.hidden=YES;
    dbhelper =[LKDBHelper getUsingLKDBHelper];
    dataArr =[[NSMutableArray alloc] init];
    [dbhelper createTableWithModelClass:[News class]];
  
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier=@"CellIdentifier";
    [_tableview registerNib:[UINib nibWithNibName:@"ListCell" bundle:nil] forCellReuseIdentifier:CellIdentifier];
    ListCell *cell = [_tableview dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[ListCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] ;
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
 
    News *new=(News *)[dataArr objectAtIndex:indexPath.row];
    [cell.lv_time setText:new.time];
    [cell.lb_title setText:new.title];
    return cell;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
      return 30;
}
- (IBAction)loadmore:(id)sender {
    _lb_loading.hidden=NO;
   
    self.bt_load.hidden=YES;
    [self.activityIndicator startAnimating];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *surlcomment =[NSString stringWithFormat:@"http://friso.kaytune.com:801/api.aspx?page=%d",page];
        NSData *s2= [myNetPost getCHS:surlcomment token:@""];
        NSDictionary *dicComment = [NSJSONSerialization JSONObjectWithData:s2 options:NSJSONReadingMutableLeaves error:nil];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSMutableArray *arr  =[dicComment objectForKey:@"data"];
            NSMutableArray *newsearchRecordArray = [NSMutableArray arrayWithArray:dataArr];
            for (int i=0; i<arr.count;i++) {
               
                News *new=[[News alloc] init];
                new.title =[[arr objectAtIndex:i] objectForKey:@"title"];
                new.time =[[arr objectAtIndex:i] objectForKey:@"time"];
                [dbhelper insertToDB:new];
                [newsearchRecordArray addObject:new];
            }
            dataArr =newsearchRecordArray;
                
            
            [_tableview reloadData];
            [self.activityIndicator stopAnimating];
            _lb_loading.hidden=YES;
            page++;
            self.bt_load.hidden=NO;
            
        });
    });
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
 
        return _headview;
        
    
}

- (IBAction)do_serch:(id)sender {
    _bt_load.hidden=YES;
    [_tb_serch resignFirstResponder];
    dataArr=[dbhelper search:[News class] where: [NSString stringWithFormat:@"title like '%%%@%%' ",_tb_serch.text] orderBy:nil offset:0 count:100];
    [_tableview reloadData];
}

- (IBAction)do_clear:(id)sender {
    _bt_load.hidden=NO;
    [_tb_serch resignFirstResponder];
    _tb_serch.text=@"";
    dataArr=[dbhelper search:[News class] where:@"" orderBy:nil offset:0 count:100];
    [_tableview reloadData];
}
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [_tb_serch resignFirstResponder];
}
 @end
