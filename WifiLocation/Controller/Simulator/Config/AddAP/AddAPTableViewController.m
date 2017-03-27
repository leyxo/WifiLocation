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
@synthesize map;

- (void)viewDidLoad {
    [super viewDidLoad];
   
   // 添加负号
   receiverefer.text = @"-";

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
   [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)Save:(id)sender {
    if ([x.text isEqualToString: @""] || [y.text isEqualToString:@""])
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
        hud.labelText = @"请输入完整坐标";
        hud.mode = MBProgressHUDModeText;
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{ dispatch_async(dispatch_get_main_queue(), ^{ [hud hide:YES afterDelay:0.6]; }); });
    }
    else if ([sendpower.text isEqualToString: @""])
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
        hud.labelText = @"请输入发送功率";
        hud.mode = MBProgressHUDModeText;
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{ dispatch_async(dispatch_get_main_queue(), ^{ [hud hide:YES afterDelay:0.6]; }); });
    }
    else if ([sendgain.text isEqualToString: @""])
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
        hud.labelText = @"请输入发送增益";
        hud.mode = MBProgressHUDModeText;
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{ dispatch_async(dispatch_get_main_queue(), ^{ [hud hide:YES afterDelay:0.6]; }); });
    }
    else if ([x.text intValue] < 0 || [x.text intValue] > map.map_width || [y.text intValue] < 0 || [y.text intValue] > map.map_height)
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
        hud.labelText = [NSString stringWithFormat:@"坐标超出地图范围 (%d*%d)",self.map.map_width, self.map.map_height];
        hud.mode = MBProgressHUDModeText;
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{ dispatch_async(dispatch_get_main_queue(), ^{ [hud hide:YES afterDelay:1.6]; }); });
    }
    else
    {
        // 打开数据库连接
        sqliteHelper = [[SQLiteHelper alloc] init];
        [sqliteHelper openSqliteWithFileName:@"wifilocation.sqlite"];
        
        // 添加数据
        // 是参考节点
        if(isrefer.on == YES) {
            [sqliteHelper insertWithString:[NSString stringWithFormat:@"insert into ap_info (ap_isrefer,map_id,ap_x, ap_y, ap_sendpower, ap_sendgain) values ('%@','%d','%d','%d','%d','%d')", @"是", self.map.map_id, [x.text intValue], [y.text intValue], [sendpower.text intValue], [sendgain.text intValue]]];
        }
        // 非参考节点
        else {
            [sqliteHelper insertWithString:[NSString stringWithFormat:@"insert into ap_info (ap_isrefer,ap_receiverefer,map_id,ap_x, ap_y, ap_sendpower, ap_sendgain) values ('%@','%d','%d','%d','%d','%d','%d')", @"", [receiverefer.text intValue], self.map.map_id, [x.text intValue], [y.text intValue], [sendpower.text intValue], [sendgain.text intValue]]];
        }
        
        [self.navigationController popViewControllerAnimated:YES];
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
        hud.labelText = [NSString stringWithFormat:@"添加成功"];
        hud.mode = MBProgressHUDModeText;
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{ dispatch_async(dispatch_get_main_queue(), ^{ [hud hide:YES afterDelay:0.6]; }); });
    }
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
