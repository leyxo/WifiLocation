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
   
   [self initData];
   
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 加载数据
-(void)initData{
   
   // 防止反复加载
   if(listData == nil) {
      // 初始化listView数据源数据
      NSBundle * bundle = [NSBundle mainBundle];
      NSString * filePath = [bundle pathForResource:@"map_info" ofType:@"plist"];
      NSMutableArray * data = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
      
      listData = data;
   }
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
   
   cell.map_name.text = [[listData objectAtIndex:[indexPath row]] objectForKey:@"map_name"];
   cell.map_info.text = [[listData objectAtIndex:[indexPath row]] objectForKey:@"map_info"];
   cell.map_width.text = [[[listData objectAtIndex:[indexPath row]] objectForKey:@"map_width"] description];
   cell.map_height.text = [[[listData objectAtIndex:[indexPath row]] objectForKey:@"map_height"] description];
   
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

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
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

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
   
   // segue.identifier：获取连线的ID
   if ([segue.identifier isEqualToString:@"MapDetail"]) {
      // segue.destinationViewController：获取连线时所指的界面（VC）
      ConfigTableViewController *receive = segue.destinationViewController;
      
      NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
      receive.segueMapNname = [[listData objectAtIndex:[indexPath row]] objectForKey:@"map_name"];
      receive.segueMapInfo = [[listData objectAtIndex:[indexPath row]] objectForKey:@"map_info"];
      receive.segueMapWidth = [[[listData objectAtIndex:[indexPath row]] objectForKey:@"map_width"] intValue];
      receive.segueMapHeight = [[[listData objectAtIndex:[indexPath row]] objectForKey:@"map_height"] intValue];
      
      // 这里不需要指定跳转了，因为在按扭的事件里已经有跳转的代码
      // [self.navigationController pushViewController:receive animated:YES];
   }
   else if ([segue.identifier isEqualToString:@"EditMap"]) {
      // segue.destinationViewController：获取连线时所指的界面（VC）
      EditMapTableViewController *receive = segue.destinationViewController;
      
      NSIndexPath *indexPath = selectIndexPath;
      receive.segueMapNname = [[listData objectAtIndex:[indexPath row]] objectForKey:@"map_name"];
      receive.segueMapInfo = [[listData objectAtIndex:[indexPath row]] objectForKey:@"map_info"];
      receive.segueMapWidth = [[[listData objectAtIndex:[indexPath row]] objectForKey:@"map_width"] intValue];
      receive.segueMapHeight = [[[listData objectAtIndex:[indexPath row]] objectForKey:@"map_height"] intValue];
   }
}


@end
