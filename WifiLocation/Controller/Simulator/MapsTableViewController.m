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

#import <MBProgressHUD.h>

@interface MapsTableViewController ()

@end

@implementation MapsTableViewController
@synthesize listData;
@synthesize searchListData;
@synthesize selectIndexPath;

- (void)viewDidLoad {
   [super viewDidLoad];
   [self setupRefresh];
    // iOS11导航栏样式
    if (@available(iOS 11.0, *)) {
        self.navigationController.navigationBar.prefersLargeTitles = TRUE;
    } else {
        // Fallback on earlier versions
    }
   
   self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
   self.searchController.searchResultsUpdater = self;
   self.searchController.dimsBackgroundDuringPresentation = NO;
   self.searchController.obscuresBackgroundDuringPresentation = NO;
   self.navigationItem.hidesSearchBarWhenScrolling = true;
   self.navigationItem.searchController = self.searchController;

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


}

-(void)viewWillAppear:(BOOL)animated {
   [self loadData];
   [self.tableView reloadData];
   
//   MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//   hud.labelText = @"正在加载地图...";
//   dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
//      // Do something...
//      
//      
//      
//      dispatch_async(dispatch_get_main_queue(), ^{
//         [MBProgressHUD hideHUDForView:self.view animated:YES];
//      });
//   });
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
  
   // 当搜索框被激活时阻止刷新
   if (!self.searchController.active) {
      listData = array;
   }
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   if (self.searchController.active) {
       return [searchListData count];
   }
   else{
       return [listData count];
   }
//    return listData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   MapTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MapCell"];
   
   if (self.searchController.active) {
      self.map = [searchListData objectAtIndex:[indexPath row]];
   }
   else{
      self.map = [listData objectAtIndex:[indexPath row]];
   }
//   self.map = [listData objectAtIndex:[indexPath row]];
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

       self.map = [listData objectAtIndex:[indexPath row]];
       selectIndexPath = indexPath;
       
       
       
       // 弹出是否要删除地图的ActionSheet
       NSString *str =[[NSString alloc] initWithFormat:@"确定要删除地图%@及其所有数据?", self.map.map_name];
       UIActionSheet * sheet = [[UIActionSheet alloc] initWithTitle:str delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"删除" otherButtonTitles:nil];
       [sheet showInView:self.view];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

// 实现<UIActionSheetDelegate>的actionSHeet协议
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
   if (buttonIndex == 0) {
      // 移除TableView中的显示
      [listData removeObjectAtIndex:[selectIndexPath row]];
      [self.tableView deleteRowsAtIndexPaths:@[selectIndexPath] withRowAnimation:UITableViewRowAnimationFade];
      
      // 打开数据库连接
      sqliteHelper = [[SQLiteHelper alloc] init];
      [sqliteHelper openSqliteWithFileName:@"wifilocation.sqlite"];
      
      // 删除数据
      [sqliteHelper deleteWithString:[NSString stringWithFormat:@"delete from map_info where map_id = '%d'", self.map.map_id]];
      
      // 刷新地图
      MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
      NSString *str =[[NSString alloc] initWithFormat:@"地图%@所有数据已删除", self.map.map_name];
      hud.labelText = str;
      hud.mode = MBProgressHUDModeText;
      
      dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
         // Do something...
         
         [self loadData];
         [self.tableView reloadData];
         
         dispatch_async(dispatch_get_main_queue(), ^{
            [hud hide:YES afterDelay:0.6];
         });
      });
   }
   else if (buttonIndex == 1) {
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
      ConfigTableViewController *receive = segue.destinationViewController;
      NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
      self.map = [listData objectAtIndex:[indexPath row]];
      receive.map = self.map;

      // 这里不需要指定跳转了，因为在按扭的事件里已经有跳转的代码
      // [self.navigationController pushViewController:receive animated:YES];
   }
   else if ([segue.identifier isEqualToString:@"EditMap"]) {
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
   MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
   hud.labelText = @"正在加载地图...";
   dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
      // Do something...
      
      [self loadData];
      
      [refreshControl endRefreshing];
      [self.tableView reloadData];
      
      dispatch_async(dispatch_get_main_queue(), ^{
         [hud hide:YES afterDelay:0.0];
//         [MBProgressHUD hideHUDForView:self.view.window animated:YES];
      });
   });
   
}


#pragma mark - 搜索委托实现
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    //获取搜索框中用户输入的字符串
    NSString *searchString = [self.searchController.searchBar text];
    //指定过滤条件，SELF表示要查询集合中对象，contain[c]表示包含字符串，%@是字符串内容
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF.map_name CONTAINS[c] %@", searchString];
    //如果搜索数组中存在对象，即上次搜索的结果，则清除这些对象
    if (self.searchListData!= nil) {
        [self.searchListData removeAllObjects];
    }
    //通过过滤条件过滤数据
    self.searchListData= [NSMutableArray arrayWithArray:[self.listData filteredArrayUsingPredicate:preicate]];
    //刷新表格
    [self.tableView reloadData];
}


#pragma mark - 键盘快捷键实现
- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (NSArray<UIKeyCommand *>*)keyCommands {
    return @[
        [UIKeyCommand keyCommandWithInput:@"n"
                            modifierFlags:UIKeyModifierCommand
                                   action:@selector(addCommand:)
                     discoverabilityTitle:@"添加地图"],
        [UIKeyCommand keyCommandWithInput:@"f"
                            modifierFlags:UIKeyModifierCommand | UIKeyModifierAlternate
                                   action:@selector(searchCommand:)
                     discoverabilityTitle:@"查找…"]
    ];
}

- (void)addCommand:(UIKeyCommand *)sender {
   // 手动触发segue跳转
   [self performSegueWithIdentifier:@"addMap" sender:self];
}

- (void)searchCommand:(UIKeyCommand *)sender {
   // 激活搜索栏
   [self.searchController.searchBar becomeFirstResponder];
   [self.searchController setActive:TRUE];
}

@end
