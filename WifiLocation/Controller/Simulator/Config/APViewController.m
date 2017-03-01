//
//  APTableViewController.m
//  WifiLocation
//
//  Created by LEY's MacBook on 17/03/01.
//  Copyright © 2017年 LEY's MacBook. All rights reserved.
//

#import "APViewController.h"
#import "APTableViewCell.h"

@interface APViewController ()

@end

@implementation APViewController
@synthesize imageView;
@synthesize listData;

- (void)viewDidLoad {
    [super viewDidLoad];
   
   [self initData];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
   
   cell.ap_id.text = [[listData objectAtIndex:[indexPath row]] objectForKey:@"ap_id"];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
