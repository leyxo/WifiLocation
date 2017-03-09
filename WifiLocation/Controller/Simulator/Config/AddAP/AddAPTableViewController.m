//
//  AddAPTableViewController.m
//  WifiLocation
//
//  Created by LEY's MacBook on 17/03/01.
//  Copyright © 2017年 LEY's MacBook. All rights reserved.
//

#import "AddAPTableViewController.h"

@interface AddAPTableViewController ()

@end

@implementation AddAPTableViewController
@synthesize isrefer;
@synthesize receivereferCell;
@synthesize receiverefer, x, y, sendpower, sendgain;
@synthesize map_id;

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

- (IBAction)Cancel:(id)sender {
   UIActionSheet * sheet = [[UIActionSheet alloc] initWithTitle:@"确定要放弃编辑?" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"放弃" otherButtonTitles:nil];
   [sheet showInView:self.view];
   
}

// 实现<UIActionSheetDelegate>的actionSHeet协议
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
   if (buttonIndex == 0) {
      [self.navigationController popViewControllerAnimated:YES];
   }
   else if (buttonIndex == 1) {
   }
}

- (IBAction)Save:(id)sender {
   // 打开数据库连接
   sqliteHelper = [[SQLiteHelper alloc] init];
   [sqliteHelper openSqliteWithFileName:@"wifilocation.sqlite"];
   
   // 修改数据
   // 是参考节点
   if(isrefer.on == YES) {
      [sqliteHelper insertWithString:[NSString stringWithFormat:@"insert into ap_info (ap_isrefer,map_id,ap_x, ap_y, ap_sendpower, ap_sendgain) values ('%@','%d','%d','%d','%d','%d')", @"是", self.map_id, [x.text intValue], [y.text intValue], [sendpower.text intValue], [sendgain.text intValue]]];
   }
   // 非参考节点
   else {
      [sqliteHelper insertWithString:[NSString stringWithFormat:@"insert into ap_info (ap_isrefer,ap_receiverefer,map_id,ap_x, ap_y, ap_sendpower, ap_sendgain) values ('%@','%d','%d','%d','%d','%d','%d')", @"", [receiverefer.text intValue], self.map_id, [x.text intValue], [y.text intValue], [sendpower.text intValue], [sendgain.text intValue]]];
   }

   [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)isreferSwitch:(id)sender {
   if(isrefer.on == YES) {
      [receivereferCell setHidden:YES];
      receiverefer.text = @"";
   }
   else {
      [receivereferCell setHidden:NO];
   }
}

@end
