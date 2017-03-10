//
//  RouteTableViewController.m
//  WifiLocation
//
//  Created by LEY's MacBook on 17/03/01.
//  Copyright © 2017年 LEY's MacBook. All rights reserved.
//

#import "RouteViewController.h"
#import "SimuTableViewCell.h"

@interface RouteViewController ()

@end

@implementation RouteViewController
@synthesize drawView;
@synthesize imageView;
@synthesize listData;
@synthesize tableview;
@synthesize lastPointX, lastPointY, PointX, PointY;

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
   
   // 读取simu_info信息
   NSMutableArray *array = [[NSMutableArray alloc] init];
   array =  [sqliteHelper selectFromSimuInfo:self.map.map_id];
   
   listData = array;
   
   // 加载上一顶点数据
   if(listData.count > 0) {
      self.simu = [listData objectAtIndex:listData.count-1];
      lastPointX.text = [NSString stringWithFormat:@"%d",self.simu.real_x];
      lastPointY.text = [NSString stringWithFormat:@"%d",self.simu.real_y];
   }
   else {
      lastPointX.text = @"";
      lastPointY.text = @"";
   }
   
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
   SimuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SimuCell"];
   
   self.simu = [listData objectAtIndex:[indexPath row]];
   cell.simu_id.text = [NSString stringWithFormat:@"%d",self.simu.simu_id];
   cell.real_x.text = [NSString stringWithFormat:@"%d",self.simu.real_x];
   cell.real_y.text = [NSString stringWithFormat:@"%d",self.simu.real_y];

    return cell;
}

// 设置组title
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
   switch (section) {
      case 0:
         return @"仿真路径节点";
         break;
      default:
         break;
   }
   return self.title;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Button

- (IBAction)Clear:(id)sender {
//   NSString *str =[[NSString alloc] initWithFormat:@"确定要清空地图%@的所有数据?", segueMapNname];
   
   UIActionSheet * sheet = [[UIActionSheet alloc] initWithTitle:@"确定要清空仿真路线?"  delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"清空路线" otherButtonTitles:nil];
   [sheet showInView:self.view];
}

// 实现<UIActionSheetDelegate>的actionSHeet协议
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
   if (buttonIndex == 0) {
      // 打开数据库连接
      sqliteHelper = [[SQLiteHelper alloc] init];
      [sqliteHelper openSqliteWithFileName:@"wifilocation.sqlite"];
      
      // 删除数据
      [sqliteHelper deleteWithString:[NSString stringWithFormat:@"delete from simu_info where map_id = '%d'", self.map.map_id]];

      // 刷新路线节点列表
      [self loadData];
      [self.tableview reloadData];
      
      MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
      hud.labelText = @"已清空路线节点";
      hud.mode = MBProgressHUDModeText;
      dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
         // Do something...
         
         dispatch_async(dispatch_get_main_queue(), ^{
            [hud hide:YES afterDelay:0.6];
         });
      });
      
      // 清空控件
      PointX.text = @"";
      PointY.text = @"";

   }
   else if (buttonIndex == 1) {
   }
}

- (IBAction)Add:(id)sender {
   // 收起键盘
   [self.view endEditing:YES];
   
   if ([PointX.text isEqual: @""] || [PointY.text isEqual: @""])
   {
      MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
      hud.labelText = @"请输入完整顶点信息";
      hud.mode = MBProgressHUDModeText;
      dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{ dispatch_async(dispatch_get_main_queue(), ^{ [hud hide:YES afterDelay:0.6]; }); });
   }
   else if ([PointX.text intValue] < 0 || [PointY.text intValue] < 0 || [PointX.text intValue] > self.map.map_width || [PointY.text intValue] > self.map.map_height)
   {
      NSString *str = [NSString stringWithFormat:@"地图大小:(%d*%d)",self.map.map_width, self.map.map_height];
      UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"顶点超出地图范围" message:str delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
      [alert show];
   }
   else
   {
      // 打开数据库连接
      sqliteHelper = [[SQLiteHelper alloc] init];
      [sqliteHelper openSqliteWithFileName:@"wifilocation.sqlite"];
      
      // 生成数据
      
      // 有上一坐标，则生成区间点数据
      if (![@"" isEqual: lastPointX.text])
      {
         // 此段路径两顶点坐标
         int x_last = [lastPointX.text intValue];
         int y_last = [lastPointY.text intValue];
         int x = [PointX.text intValue];
         int y = [PointY.text intValue];
         
         // 路径距离
         double distance = sqrt((double)(x - x_last) * (x - x_last) + (double)(y - y_last) * (y - y_last));
         
         // 生成的段中间点数(切分的段数-1)
         int segment = (int)distance / 100;

         // 生成路径节点坐标数组
         for (int i = 1; i <= segment + 1; i ++)
         {
            // 新节点坐标
            int x_new = 0;
            int y_new = 0;
            
            // 最后一个点应为输入的端点，或分段为0
            if (i == segment + 1 || 0 == segment)
            {
               x_new = x;
               y_new = y;
            }
            // 正常求解点坐标
            else
            {
               x_new = x_last + (x - x_last) / segment * i;
               y_new = y_last + (y - y_last) / segment * i;
            }
            
            // 如果最后一个中间点距离顶点太近，则不添加该点
            if (i <= segment && sqrt((double)(x - x_new) * (x - x_new) + (double)(y - y_new) * (y - y_new)) <= 50)
            {
               continue;
            }
            
            // 写入数据
            [sqliteHelper insertWithString:[NSString stringWithFormat:@"insert into simu_info (map_id,real_x,real_y) values ('%d','%d','%d')", self.map.map_id, x_new, y_new]];
         }
      }
      // 没有上一坐标(无实验数据)，则仅创建一个新的点
      else
      {
         // 写入数据
         [sqliteHelper insertWithString:[NSString stringWithFormat:@"insert into simu_info (map_id,real_x,real_y) values ('%d','%d','%d')", self.map.map_id, [PointX.text intValue], [PointY.text intValue]]];
      }
      
      // 替换上一顶点数据
      lastPointX.text = PointX.text;
      lastPointY.text = PointY.text;
      PointX.text = @"";
      PointY.text = @"";
      
      // 刷新路径节点列表
      [self loadData];
      [self.tableview reloadData];
      
      MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
      hud.labelText = @"已生成仿真路径节点";
      hud.mode = MBProgressHUDModeText;
      dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
         // Do something...
         
         dispatch_async(dispatch_get_main_queue(), ^{
            [hud hide:YES afterDelay:0.6];
         });
      });

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
   hud.labelText = @"正在加载仿真路径...";
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
