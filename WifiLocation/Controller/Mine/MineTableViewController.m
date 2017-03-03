//
//  MineTableViewController.m
//  WifiLocation
//
//  Created by LEY's MacBook on 17/03/01.
//  Copyright © 2017年 LEY's MacBook. All rights reserved.
//

#import "MineTableViewController.h"
#import "AboutViewController.h"

@interface MineTableViewController ()

@end

@implementation MineTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
   
   // segue.identifier：获取连线的ID
   // if ([segue.identifier isEqualToString:@"About"]) {
      // segue.destinationViewController：获取连线时所指的界面（VC）
      UIViewController *receive = segue.destinationViewController;
   
      // 隐藏TabBar
      receive.hidesBottomBarWhenPushed = YES;
   // }
}


@end
