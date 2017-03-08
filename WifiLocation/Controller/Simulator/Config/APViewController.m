//
//  APTableViewController.m
//  WifiLocation
//
//  Created by LEY's MacBook on 17/03/01.
//  Copyright © 2017年 LEY's MacBook. All rights reserved.
//

#import "APViewController.h"
#import "APTableViewCell.h"
#import "EditAPTableViewController.h"

@interface APViewController ()

@end

@implementation APViewController
@synthesize imageView;
@synthesize listData;
@synthesize tableview;

- (void)viewDidLoad {
   [super viewDidLoad];
   [self setupRefresh];
   
   [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - 加载数据
-(void)loadData{
   // 打开数据库连接
   sqliteHelper = [[SQLiteHelper alloc] init];
   [sqliteHelper openSqliteWithFileName:@"wifilocation.sqlite"];
   
   // 读取ap_info信息
   NSMutableArray *array = [[NSMutableArray alloc] init];
   array =  [sqliteHelper selectFromAPInfo:self.map_id];
   
   listData = array;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return listData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   APTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"APCell"];
   
   self.ap = [listData objectAtIndex:[indexPath row]];
   cell.ap_id.text = [NSString stringWithFormat:@"%d",self.ap.ap_id];
   cell.ap_x.text = [NSString stringWithFormat:@"%d",self.ap.ap_x];
   cell.ap_y.text = [NSString stringWithFormat:@"%d",self.ap.ap_y];
   cell.ap_sendpower.text = [NSString stringWithFormat:@"%d",self.ap.ap_sendpower];
   cell.ap_sendgain.text = [NSString stringWithFormat:@"%d",self.ap.ap_sendgain];
   cell.ap_receiverefer.text = [NSString stringWithFormat:@"%d",self.ap.ap_receiverefer];
   
   
   if([@"是" isEqual: self.ap.ap_isrefer]) {
      cell.ap_isrefer.text = @"⭐️";
      cell.ap_receiverefer.text = @"";
   }
   else {
      cell.ap_isrefer.text = @"";
   }

   return cell;
}

// 设置组title
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
   switch (section) {
      case 0:
         return @"AP节点数据";
         break;
      default:
         break;
   }
   return self.title;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
   if ([segue.identifier isEqualToString:@"EditAP"]) {
      EditAPTableViewController *receive = segue.destinationViewController;
      NSIndexPath *indexPath = [self.tableview indexPathForSelectedRow];
      self.ap = [listData objectAtIndex:[indexPath row]];

      receive.ap = self.ap;
   }
}

#pragma mark - 下拉刷新实现
// 下拉刷新
- (void)setupRefresh {
   UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
   [refreshControl addTarget:self action:@selector(refreshClick:) forControlEvents:UIControlEventValueChanged];
   [self.tableview addSubview:refreshControl];
   //   [refreshControl beginRefreshing];
   //   [self refreshClick:refreshControl];
}
// 下拉刷新触发，在此获取数据
- (void)refreshClick:(UIRefreshControl *)refreshControl {
   // 此处添加刷新tableView数据的代码
   [self loadData];
   
   [refreshControl endRefreshing];
   [self.tableview reloadData];
}

@end
