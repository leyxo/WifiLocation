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
      NSString * filePath = [bundle pathForResource:@"ap_info" ofType:@"plist"];
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
   APTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"APCell"];
   
   cell.ap_id.text = [[[listData objectAtIndex:[indexPath row]] objectForKey:@"ap_id"] description];
   cell.ap_x.text = [[[listData objectAtIndex:[indexPath row]] objectForKey:@"ap_x"] description];
   cell.ap_y.text = [[[listData objectAtIndex:[indexPath row]] objectForKey:@"ap_y"] description];
   cell.ap_sendpower.text = [[[listData objectAtIndex:[indexPath row]] objectForKey:@"ap_sendpower"] description];
   cell.ap_sendgain.text = [[[listData objectAtIndex:[indexPath row]] objectForKey:@"ap_sendgain"] description];
   cell.ap_receiverefer.text = [[[listData objectAtIndex:[indexPath row]] objectForKey:@"ap_receiverefer"] description];
   
   if([@"是" isEqual: [[[listData objectAtIndex:[indexPath row]] objectForKey:@"ap_isrefer"] description]]) {
      cell.ap_isrefer.text = @"⭐️";
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

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
   
   // segue.identifier：获取连线的ID
   if ([segue.identifier isEqualToString:@"EditAP"]) {
      // segue.destinationViewController：获取连线时所指的界面（VC）
      EditAPTableViewController *receive = segue.destinationViewController;
      
      NSIndexPath *indexPath = [self.tableview indexPathForSelectedRow];
      
      if([@"是" isEqual: [[[listData objectAtIndex:[indexPath row]] objectForKey:@"ap_isrefer"] description]]) {
         receive.segueIsreferSwitch = YES;
      }
      else {
         receive.segueIsreferSwitch = NO;
      }

      receive.segueReceiverefer = [[[listData objectAtIndex:[indexPath row]] objectForKey:@"ap_receiverefer"] intValue];
      receive.segueX = [[[listData objectAtIndex:[indexPath row]] objectForKey:@"ap_x"] intValue];
      receive.segueY = [[[listData objectAtIndex:[indexPath row]] objectForKey:@"ap_y"] intValue];
      receive.segueSendpower = [[[listData objectAtIndex:[indexPath row]] objectForKey:@"ap_sendpower"] intValue];
      receive.segueSendgain = [[[listData objectAtIndex:[indexPath row]] objectForKey:@"ap_sendgain"] intValue];
      receive.ap_id = [[[listData objectAtIndex:[indexPath row]] objectForKey:@"ap_id"] intValue];
   }
}


@end
