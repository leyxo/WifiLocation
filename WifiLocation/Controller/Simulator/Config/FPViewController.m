//
//  FPTableViewController.m
//  WifiLocation
//
//  Created by LEY's MacBook on 17/03/01.
//  Copyright © 2017年 LEY's MacBook. All rights reserved.
//

#import "FPViewController.h"
#import "FPTableViewCell.h"

@implementation FPViewController
@synthesize imageView;
@synthesize listData;
@synthesize tableview;
@synthesize drawView;
@synthesize distance, receivegain;

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
   
   // 读取fp_info信息
   NSMutableArray *array = [[NSMutableArray alloc] init];
   array =  [sqliteHelper selectFromFPInfo:self.map.map_id];
   
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
   // 收起键盘
   [self.view endEditing:YES];
   
   if ([distance.text isEqual: @""])
   {
      UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"请输入节点间距" message:@"" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
      [alert show];
   }
   else if ([receivegain.text isEqual: @""])
   {
      UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"请输入接收增益" message:@"" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
      [alert show];
   }
   else if (self.map.map_height > self.map.map_width ? [distance.text intValue] > self.map.map_width / 2 : [distance.text intValue] > self.map.map_height / 2)
   {
      UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"所选节点间距过大" message:@"间距过大会影响实验结果" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
      [alert show];

   }
   else if (self.map.map_height > self.map.map_width ? [distance.text intValue] < self.map.map_width / 100 : [distance.text intValue] < self.map.map_height / 100)
   {
      UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"所选节点间距过小" message:@"间距过小会影响系统性能" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
      [alert show];
   }
   else
   {
      // 打开数据库连接
      sqliteHelper = [[SQLiteHelper alloc] init];
      [sqliteHelper openSqliteWithFileName:@"wifilocation.sqlite"];
   
      // 删除数据
      [sqliteHelper deleteWithString:[NSString stringWithFormat:@"delete from fp_info where map_id = '%d'", self.map.map_id]];
   
      // 生成数据
      for(int i = [distance.text intValue]; i < self.map.map_width; i += [distance.text intValue])
         for(int j = [distance.text intValue]; j < self.map.map_height; j += [distance.text intValue])
         {
            [sqliteHelper insertWithString:[NSString stringWithFormat:@"insert into fp_info (map_id,fp_x,fp_y,fp_receivegain) values ('%d','%d','%d','%d')", self.map.map_id, i, j, [receivegain.text intValue]]];
         }
   
      // 刷新FP列表
      [self loadData];
      [self.tableview reloadData];
   
      MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
      hud.labelText = @"已生成指纹节点";
      hud.mode = MBProgressHUDModeText;
      dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
         // Do something...
      
         dispatch_async(dispatch_get_main_queue(), ^{
            [hud hide:YES afterDelay:0.6];
         });
      });
   
      // 清空控件
      distance.text = @"";
      receivegain.text = @"";
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
   hud.labelText = @"正在加载指纹节点...";
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
