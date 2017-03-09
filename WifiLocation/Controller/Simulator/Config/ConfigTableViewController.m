//
//  ConfigTableViewController.m
//  WifiLocation
//
//  Created by LEY's MacBook on 17/03/01.
//  Copyright © 2017年 LEY's MacBook. All rights reserved.
//

#import "ConfigTableViewController.h"
#import "APViewController.h"
#import "FPViewController.h"
#import "RouteViewController.h"

@implementation ConfigTableViewController
@synthesize APNotSetup, FPNotSetup, RouteNotSetup;
@synthesize StartLabel, CDFLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
   
   // 通过StoryBoard Segue传值修改title,详见MapsTableViewController.m
   self.navigationItem.title = self.map.map_name;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [self loadData];
}

#pragma mark - 加载数据
-(void)loadData{
   // 打开数据库连接
   sqliteHelper = [[SQLiteHelper alloc] init];
   [sqliteHelper openSqliteWithFileName:@"wifilocation.sqlite"];
   
   // 设置配置情况的显示
   NSMutableArray *array = [[NSMutableArray alloc] init];
   // 读取ap_info信息
   array =  [sqliteHelper selectFromAPInfo:self.map.map_id];
   if(array.count != 0) {
      APNotSetup.text = @"";
   }
   else {
      APNotSetup.text = @"未配置";
   }
   // 读取fp_info信息
   array =  [sqliteHelper selectFromFPInfo:self.map.map_id];
   if(array.count != 0) {
      FPNotSetup.text = @"";
   }
   else {
      FPNotSetup.text = @"未配置";
   }
   // 读取simu_info信息
   array =  [sqliteHelper selectFromSimuInfo:self.map.map_id];
   if(array.count != 0) {
      RouteNotSetup.text = @"";
   }
   else {
      RouteNotSetup.text = @"未配置";
   }
   
   // 设置实验选项变为灰色/系统蓝色
   if([APNotSetup.text isEqual: @"未配置"] || [FPNotSetup.text isEqual: @"未配置"] || [RouteNotSetup.text isEqual: @"未配置"]) {
      StartLabel.textColor = [UIColor grayColor];
      CDFLabel.textColor = [UIColor grayColor];
   }
   else {
      StartLabel.textColor = self.view.tintColor;
      CDFLabel.textColor = self.view.tintColor;
   }
}


#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   [tableView deselectRowAtIndexPath:indexPath animated:YES];
   if(indexPath.section == 2 && indexPath.row == 0) {
      // 开始仿真实验
      if([APNotSetup.text isEqual: @"未配置"] || [FPNotSetup.text isEqual: @"未配置"] || [RouteNotSetup.text isEqual: @"未配置"]) {
         MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
         hud.labelText = @"木有配置完呢，别闹...";
         hud.mode = MBProgressHUDModeText;
         dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            // Do something...
            dispatch_async(dispatch_get_main_queue(), ^{
               [hud hide:YES afterDelay:0.6];
            });
         });
      }
   }
   else if(indexPath.section == 2 && indexPath.row == 1) {
      // 生成CDF曲线
      if([APNotSetup.text isEqual: @"未配置"] || [FPNotSetup.text isEqual: @"未配置"] || [RouteNotSetup.text isEqual: @"未配置"]) {
         MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
         hud.labelText = @"木有配置完呢，别闹...";
         hud.mode = MBProgressHUDModeText;
         dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            // Do something...
            dispatch_async(dispatch_get_main_queue(), ^{
               [hud hide:YES afterDelay:0.6];
            });
         });
      }
   }
}


#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
   UIViewController *receive = segue.destinationViewController;
   if ([segue.identifier isEqualToString:@"APDetail"]) {
      APViewController *receive = segue.destinationViewController;

      receive.map = self.map;
   }
   else if ([segue.identifier isEqualToString:@"FPDetail"]) {
      FPViewController *receive = segue.destinationViewController;
      
      receive.map = self.map;
   }
   else if ([segue.identifier isEqualToString:@"SimuDetail"]) {
      RouteViewController *receive = segue.destinationViewController;
      
      receive.map = self.map;
   }
   
}

#pragma mark - Button
- (IBAction)Clear:(id)sender {
   NSString *str =[[NSString alloc] initWithFormat:@"确定要清空地图%@的所有数据?", self.map.map_name];
   
   UIActionSheet * sheet = [[UIActionSheet alloc] initWithTitle:str  delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"清空数据" otherButtonTitles:nil];
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
      [sqliteHelper deleteWithString:[NSString stringWithFormat:@"delete from ap_info where map_id = '%d'", self.map.map_id]];
      [sqliteHelper deleteWithString:[NSString stringWithFormat:@"delete from fp_info where map_id = '%d'", self.map.map_id]];
      
      // 刷新配置状态
      [self loadData];
      
      MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
      hud.labelText = @"已清空所有实验数据";
      hud.mode = MBProgressHUDModeText;
      dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
         // Do something...
         
         dispatch_async(dispatch_get_main_queue(), ^{
            [hud hide:YES afterDelay:0.6];
         });
      });

      NSLog(@"数据已清空");
   }
   else if (buttonIndex == 1) {
   }
}
@end
