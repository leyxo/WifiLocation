//
//  ManageTableViewController.m
//  WifiLocation
//
//  Created by LEY's MacBook on 17/03/14.
//  Copyright © 2017年 LEY's MacBook. All rights reserved.
//

#import "ManageTableViewController.h"

#import "BaseNavigationController.h"
#import "MapsTableViewController.h"
#import "MineTableViewController.h"

@implementation ManageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

// 测试UIModalPresentationPopover
- (IBAction)Edit:(id)sender {

   // 一个NavigationController
   BaseNavigationController *navCon = [[BaseNavigationController alloc] init];
   
   //将UIViewController封装成为Popover
   navCon.modalPresentationStyle = UIModalPresentationPopover;
   // 设置popoverPresentationController的button or barbtton
   navCon.popoverPresentationController.barButtonItem = self.navigationItem.leftBarButtonItem;
   // 设置代理，以修改适配 *****这和下面的代理方法重写是关键！！！
   navCon.popoverPresentationController.delegate = self;
   // 设置大小
   navCon.preferredContentSize = CGSizeMake(320, 400);
   
   
   // 初始化MapsTableViewController
   MapsTableViewController * manageView = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MapsTableViewController"];
   // 放入NavigationController
   navCon.viewControllers = [[NSArray alloc] initWithObjects:manageView, nil];
   
   [self presentViewController:navCon animated:YES completion:nil];
}

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
   return UIModalPresentationNone; // 告知代理不适配iOS，就不会默认在iPhone上以Model弹出
}
@end
