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

@implementation ConfigTableViewController
@synthesize APNotSetup, FPNotSetup, RouteNotSetup;

- (void)viewDidLoad {
    [super viewDidLoad];
   
   // 通过StoryBoard Segue传值修改title,详见MapsTableViewController.m
   self.navigationItem.title = self.map.map_name;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
   UIViewController *receive = segue.destinationViewController;
   if ([segue.identifier isEqualToString:@"APDetail"]) {
      APViewController *receive = segue.destinationViewController;

      receive.map_id = self.map.map_id;
   }
   else if ([segue.identifier isEqualToString:@"FPDetail"]) {
      FPViewController *receive = segue.destinationViewController;
      
      receive.map_id = self.map.map_id;
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
      NSLog(@"数据已清空");
   }
   else if (buttonIndex == 1) {
   }
}
@end
