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
   
   self.navigationItem.prompt = [[NSString alloc] initWithFormat:@"节点%d", self.ap.ap_id];
   
   isreferSwitch.enabled = NO;
   if([@"是" isEqual: self.ap.ap_isrefer]) {
      isreferSwitch.on = YES;
   }
   if(isreferSwitch.on == YES) {
      [receivereferCell setHidden:YES];
   }

   x.text = [[NSString alloc] initWithFormat:@"%d", self.ap.ap_x];
   y.text = [[NSString alloc] initWithFormat:@"%d", self.ap.ap_x];
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
   [self.navigationController popViewControllerAnimated:YES];
}

@end
