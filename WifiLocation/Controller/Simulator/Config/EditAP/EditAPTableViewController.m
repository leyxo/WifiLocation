//
//  EditAPTableViewController.m
//  WifiLocation
//
//  Created by LEY's MacBook on 17/03/02.
//  Copyright © 2017年 LEY's MacBook. All rights reserved.
//

#import "EditAPTableViewController.h"

@interface EditAPTableViewController ()

@end

@implementation EditAPTableViewController
@synthesize isreferSwitch, receiverefer, x, y, sendpower, sendgain;
@synthesize receivereferCell;
@synthesize ap;

- (void)viewDidLoad {
    [super viewDidLoad];
   
   self.navigationItem.prompt = [[NSString alloc] initWithFormat:@"节点ID %d", self.ap.ap_id];
   
   isreferSwitch.enabled = NO;
   if([@"是" isEqual: self.ap.ap_isrefer]) {
      isreferSwitch.on = YES;
   }
   if(isreferSwitch.on == YES) {
      [receivereferCell setHidden:YES];
   }

   x.text = [[NSString alloc] initWithFormat:@"%d", self.ap.ap_x];
   y.text = [[NSString alloc] initWithFormat:@"%d", self.ap.ap_y];
   sendpower.text = [[NSString alloc] initWithFormat:@"%d", self.ap.ap_sendpower];
   sendgain.text = [[NSString alloc] initWithFormat:@"%d", self.ap.ap_sendgain];
   receiverefer.text = [[NSString alloc] initWithFormat:@"%d", self.ap.ap_receiverefer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
   [x becomeFirstResponder];
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
   if(isreferSwitch.on == YES) {
   [sqliteHelper updataWithString:[NSString stringWithFormat:@"update ap_info set ap_x = '%d',ap_y = '%d',ap_sendpower = '%d',ap_sendgain = '%d' where ap_id = '%d'", [x.text intValue], [y.text intValue], [sendpower.text intValue], [sendgain.text intValue], self.ap.ap_id]];
   }
   // 非参考节点
   else {
      [sqliteHelper updataWithString:[NSString stringWithFormat:@"update ap_info set ap_x = '%d',ap_y = '%d',ap_sendpower = '%d',ap_sendgain = '%d',ap_receiverefer = '%d' where ap_id = '%d'", [x.text intValue], [y.text intValue], [sendpower.text intValue], [sendgain.text intValue], [receiverefer.text intValue], self.ap.ap_id]];
   }
   
   [self.navigationController popViewControllerAnimated:YES];
   
   MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
   hud.labelText = [NSString stringWithFormat:@"修改成功"];
   hud.mode = MBProgressHUDModeText;
   dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{ dispatch_async(dispatch_get_main_queue(), ^{ [hud hide:YES afterDelay:0.6]; }); });
}

#pragma mark - 键盘快捷键实现
- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (NSArray<UIKeyCommand *>*)keyCommands {
    return @[
        [UIKeyCommand keyCommandWithInput:UIKeyInputLeftArrow modifierFlags:UIKeyModifierCommand action:@selector(back:) discoverabilityTitle:@"返回"],

    ];
}

- (void)back:(UIKeyCommand *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
