//
//  FPTableViewController.m
//  WifiLocation
//
//  Created by LEY's MacBook on 17/03/01.
//  Copyright © 2017年 LEY's MacBook. All rights reserved.
//

#import "FPViewController.h"
#import "FPTableViewCell.h"

@interface FPViewController ()

@end

@implementation FPViewController
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
   
   // 读取fp_info信息
   NSMutableArray *array = [[NSMutableArray alloc] init];
   array =  [sqliteHelper selectFromFPInfo:self.map_id];
   
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
    FPTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FPCell"];
   
   self.fp = [listData objectAtIndex:[indexPath row]];
   cell.fp_id.text = [NSString stringWithFormat:@"%d",self.fp.fp_id];
   cell.fp_x.text = [NSString stringWithFormat:@"%d",self.fp.fp_x];
   cell.fp_y.text = [NSString stringWithFormat:@"%d",self.fp.fp_y];
   cell.fp_receivegain.text = [NSString stringWithFormat:@"%d",self.fp.fp_receivegain];
    
    return cell;
}

// 设置组title
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
   switch (section) {
      case 0:
         return @"指纹节点数据";
         break;
      default:
         break;
   }
   return self.title;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


#pragma mark - Button
- (IBAction)Generate:(id)sender {
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
