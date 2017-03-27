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
#import "AddAPTableViewController.h"

@implementation APViewController
@synthesize imageView;
@synthesize listData;
@synthesize tableview;
@synthesize drawView;

- (void)viewDidLoad {
   [super viewDidLoad];
   [self setupRefresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
   [self loadData];
   [self.tableview reloadData];
}

// 点击View空白区域收起键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
   [self.view endEditing:YES];
}

#pragma mark - 加载数据
-(void)loadData{
   // 打开数据库连接
   sqliteHelper = [[SQLiteHelper alloc] init];
   [sqliteHelper openSqliteWithFileName:@"wifilocation.sqlite"];
   
   // 读取ap_info信息
   NSMutableArray *array = [[NSMutableArray alloc] init];
   array =  [sqliteHelper selectFromAPInfo:self.map.map_id];
   
   listData = array;
   
   // 传参并调用drawRect()
   drawView.map = self.map;
   
   // 在新的RunLoop里进行刷新图像 http://m.blog.csdn.net/article/details?id=50899435
   dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
      //更新变量
      dispatch_async(dispatch_get_main_queue(), ^{
         //更新动画
         [self.drawView setNeedsDisplay];
      });
   });
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
       self.ap = [listData objectAtIndex:[indexPath row]];
       [listData removeObjectAtIndex:[indexPath row]];
       [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
       
       // 打开数据库连接
       sqliteHelper = [[SQLiteHelper alloc] init];
       [sqliteHelper openSqliteWithFileName:@"wifilocation.sqlite"];
       
       // 删除数据
       [sqliteHelper deleteWithString:[NSString stringWithFormat:@"delete from ap_info where ap_id = '%d'", self.ap.ap_id]];
       
       // 刷新AP列表
       MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
       hud.labelText = @"载入中...";
       dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
          // Do something...
          
          [self loadData];
          [self.tableview reloadData];

          
          dispatch_async(dispatch_get_main_queue(), ^{
             [hud hide:YES afterDelay:0.0];
          });
       });
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
   else if ([segue.identifier isEqualToString:@"AddAP"]) {
      AddAPTableViewController *receive = segue.destinationViewController;

      receive.map = self.map;
   }
}


#pragma mark - 屏幕旋转触发刷新
// 手动添加的，带有动画的屏幕旋转发生时的动作
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
   [self loadData];
}

#pragma mark - 下拉刷新实现
// 下拉刷新
- (void)setupRefresh {
   UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
   [refreshControl addTarget:self action:@selector(refreshClick:) forControlEvents:UIControlEventValueChanged];
   [self.tableview addSubview:refreshControl];
}
// 下拉刷新触发，在此获取数据
- (void)refreshClick:(UIRefreshControl *)refreshControl {
   // 此处添加刷新tableView数据的代码
   MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
   hud.labelText = @"正在加载AP节点...";
   dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
      // Do something...
      
      [self loadData];
      
      [refreshControl endRefreshing];
      [self.tableview reloadData];
      
      dispatch_async(dispatch_get_main_queue(), ^{
         [hud hide:YES afterDelay:0.0];
         //         [MBProgressHUD hideHUDForView:self.view.window animated:YES];
      });
   });
}

@end
