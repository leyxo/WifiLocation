//
//  LoginViewController.m
//  WifiLocation
//
//  Created by LEY's MacBook on 17/03/12.
//  Copyright © 2017年 LEY's MacBook. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

// 点击View空白区域收起键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
   [self.view endEditing:YES];
}

- (IBAction)Login:(id)sender {
   [self dismissViewControllerAnimated:YES completion:nil];
   
   MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
   hud.labelText = [NSString stringWithFormat:@"登录成功"];
   hud.mode = MBProgressHUDModeText;
   dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{ dispatch_async(dispatch_get_main_queue(), ^{ [hud hide:YES afterDelay:1.0]; }); });
}
@end
