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

- (void)viewDidLoad {
    [super viewDidLoad];
   
   [self initData];
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
      NSString * filePath = [bundle pathForResource:@"fp_info" ofType:@"plist"];
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
    FPTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FPCell"];
    
   cell.fp_id.text = [[[listData objectAtIndex:[indexPath row]] objectForKey:@"fp_id"] description];
   cell.fp_x.text = [[[listData objectAtIndex:[indexPath row]] objectForKey:@"fp_x"] description];
   cell.fp_y.text = [[[listData objectAtIndex:[indexPath row]] objectForKey:@"fp_y"] description];
   cell.fp_receivegain.text = [[[listData objectAtIndex:[indexPath row]] objectForKey:@"fp_receivegain"] description];
    
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

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)Generate:(id)sender {
}
@end
