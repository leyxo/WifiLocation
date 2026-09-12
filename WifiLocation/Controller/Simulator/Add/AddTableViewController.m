//
//  AddTableViewController.m
//  WifiLocation
//
//  Created by LEY's MacBook on 17/03/01.
//  Copyright © 2017年 LEY's MacBook. All rights reserved.
//

#import "AddTableViewController.h"

@interface AddTableViewController ()

@end

@implementation AddTableViewController
@synthesize map_name, map_info, map_width, map_height;

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated {
   [self.map_name becomeFirstResponder];
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
//   UIActionSheet * sheet = [[UIActionSheet alloc] initWithTitle:@"确定要放弃编辑?" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"放弃" otherButtonTitles:nil];
//   [sheet showInView:self.view];
   
//   [self.navigationController popViewControllerAnimated:YES];
   [self.navigationController dismissModalViewControllerAnimated:YES];
}

// 实现<UIActionSheetDelegate>的actionSHeet协议
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
   if (buttonIndex == 0) {
//      [self.navigationController popViewControllerAnimated:YES];
      [self.navigationController dismissModalViewControllerAnimated:YES];
   }
   else if (buttonIndex == 1) {
   }
}

- (IBAction)Save:(id)sender {
   // 打开数据库连接
   sqliteHelper = [[SQLiteHelper alloc] init];
   [sqliteHelper openSqliteWithFileName:@"wifilocation.sqlite"];
   
   // 写入数据
   [sqliteHelper insertWithString:[NSString stringWithFormat:@"insert into map_info(map_name,map_width,map_height,map_info) values ('%@','%d','%d','%@')", map_name.text, [map_width.text intValue], [map_height.text intValue], map_info.text]];
   
//   [self.navigationController popViewControllerAnimated:YES];
   [self.navigationController dismissModalViewControllerAnimated:YES];
   
   MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
   hud.labelText = [NSString stringWithFormat:@"添加成功"];
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
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

@end
