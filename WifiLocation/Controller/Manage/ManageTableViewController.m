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
    
    // iOS11导航栏样式
    if (@available(iOS 11.0, *)) {
        self.navigationController.navigationBar.prefersLargeTitles = TRUE;
    } else {
        // Fallback on earlier versions
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.section == 0 && indexPath.row == 0) {
        // 清空数据
        UIActionSheet * sheet = [[UIActionSheet alloc] initWithTitle:@"确定要清空所有实验数据？"  delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"清空数据" otherButtonTitles:nil];
        sheet.tag = 0;
        [sheet showInView:self.view];
    }
    else if(indexPath.section == 0 && indexPath.row == 1) {
        // 导出SQL文件
        UIActionSheet * sheet = [[UIActionSheet alloc] initWithTitle:@"导出SQL文件"  delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"导出...", nil];
        sheet.tag = 1;
        [sheet showInView:self.view];
    }
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


#pragma mark - 测试UIModalPresentationPopover
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


#pragma mark - 实现<UIActionSheetDelegate>的actionSHeet协议
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    // 清空数据
    if(actionSheet.tag == 0)
    {
        if (buttonIndex == 0) {

            NSLog(@"数据清空");
        }
        else if (buttonIndex == 1) {
        }
    }
    // 导出SQL文件
    else if(actionSheet.tag == 1)
    {
        if (buttonIndex == 0) {
            
            NSLog(@"正在导出SQL文件");
        }
        else if (buttonIndex == 1) {
        }
    }
}
@end
