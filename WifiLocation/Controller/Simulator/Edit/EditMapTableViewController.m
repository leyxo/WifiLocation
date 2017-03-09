//
//  EditMapTableViewController.m
//  WifiLocation
//
//  Created by LEY's MacBook on 17/03/02.
//  Copyright © 2017年 LEY's MacBook. All rights reserved.
//

#import "EditMapTableViewController.h"

@interface EditMapTableViewController ()

@end

@implementation EditMapTableViewController
@synthesize map_name, map_info, map_width, map_height;

- (void)viewDidLoad {
    [super viewDidLoad];
   
   self.navigationItem.prompt = [NSString stringWithFormat:@"地图ID %d", self.map.map_id];
   
   map_name.text = self.map.map_name;
   map_info.text = self.map.map_info;
   map_width.text = [[NSString alloc] initWithFormat:@"%d", self.map.map_width];
   map_height.text = [[NSString alloc] initWithFormat:@"%d", self.map.map_height];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
   [map_width becomeFirstResponder];
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
   [sqliteHelper updataWithString:[NSString stringWithFormat:@"update map_info set map_name = '%@',map_width = '%d',map_height = '%d',map_info = '%@' where map_id = '%d'",map_name.text, [map_width.text intValue], [map_height.text intValue], map_info.text, self.map.map_id]];
   
   [self.navigationController popViewControllerAnimated:YES];
}

@end
