//
//  MapsTableViewController.m
//  WifiLocation
//
//  Created by LEY's MacBook on 17/03/01.
//  Copyright © 2017年 LEY's MacBook. All rights reserved.
//

#import "MapsTableViewController.h"
#import "MapTableViewCell.h"
#import "ConfigTableViewController.h"
#import "EditMapTableViewController.h"

@interface MapsTableViewController ()

@end

@implementation MapsTableViewController
@synthesize listData;
@synthesize selectIndexPath;

- (void)viewDidLoad {
   [super viewDidLoad];
   [self setupRefresh];
   
#pragma mark FMDB方法
//   //1.获得数据库文件的路径
//   NSString *doc =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)  lastObject];
//   NSString *fileName = [doc stringByAppendingPathComponent:@"wifilocation.sqlite"];
//   //2.获得数据库
//   FMDatabase *db = [FMDatabase databaseWithPath:fileName];
//   [db open];
//   
//   FMResultSet *resultSet = [db executeQuery:@"select * from map_info"];
   
#pragma mark SQLiteHelper方法
   [self loadData];

   
   // 测试一下更新数据库
//   NSString *updateDemoStr = [NSString stringWithFormat:@"update map_info set map_info = 'Perfect!!' where map_id = 12"];
//   [sql updataWithString:updateDemoStr];

}

-(void)viewWillAppear:(BOOL)animated {
//   [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 加载数据
-(void)loadData{
   // 打开数据库连接
   sqliteHelper = [[SQLiteHelper alloc] init];
   [sqliteHelper openSqliteWithFileName:@"wifilocation.sqlite"];
   
   // 读取map_info信息
   NSMutableArray *array = [[NSMutableArray alloc] init];
   array =  [sqliteHelper selectFromMapInfo];
  
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
   MapTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MapCell"];
   
   self.map = [listData objectAtIndex:[indexPath row]];
   cell.map_name.text = self.map.map_name;
   cell.map_info.text = self.map.map_info;
   NSString *map_width = [NSString stringWithFormat:@"%d",self.map.map_width];
   NSString *map_height = [NSString stringWithFormat:@"%d",self.map.map_height];
   cell.map_width.text = map_width;
   cell.map_height.text = map_height;

   return cell;
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

/*
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}
 */



// 手动添加的协议，点击i详细信息按钮，通过segue跳转至编辑地图页
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
   // 临时存储变量
   selectIndexPath = indexPath;

   [self performSegueWithIdentifier:@"EditMap" sender:self];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
   // segue.identifier：获取连线的ID
   // segue.destinationViewController：获取连线时所指的界面（VC）
   UIViewController *receive = segue.destinationViewController;
   // 隐藏TabBar
   receive.hidesBottomBarWhenPushed = YES;
   
   // segue.identifier：获取连线的ID
   if ([segue.identifier isEqualToString:@"MapDetail"]) {
      // segue.destinationViewController：获取连线时所指的界面（VC）
      ConfigTableViewController *receive = segue.destinationViewController;
      
      NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
      
      self.map = [listData objectAtIndex:[indexPath row]];
      receive.map = self.map;

      // 这里不需要指定跳转了，因为在按扭的事件里已经有跳转的代码
      // [self.navigationController pushViewController:receive animated:YES];
   }
   else if ([segue.identifier isEqualToString:@"EditMap"]) {
      // segue.destinationViewController：获取连线时所指的界面（VC）
      EditMapTableViewController *receive = segue.destinationViewController;
      
      NSIndexPath *indexPath = selectIndexPath;
      self.map = [listData objectAtIndex:[indexPath row]];
      receive.map = self.map;
   }
}

#pragma mark - 下拉刷新实现
// 下拉刷新
- (void)setupRefresh {
   UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
   [refreshControl addTarget:self action:@selector(refreshClick:) forControlEvents:UIControlEventValueChanged];
   [self.tableView addSubview:refreshControl];
//   [refreshControl beginRefreshing];
//   [self refreshClick:refreshControl];
}
// 下拉刷新触发，在此获取数据
- (void)refreshClick:(UIRefreshControl *)refreshControl {
   // 此处添加刷新tableView数据的代码
   [self loadData];
   
   [refreshControl endRefreshing];
   [self.tableView reloadData];
}

@end
