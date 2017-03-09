//
//  AddAPTableViewController.h
//  WifiLocation
//
//  Created by LEY's MacBook on 17/03/01.
//  Copyright © 2017年 LEY's MacBook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddAPTableViewController : UITableViewController <UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UISwitch *isrefer;
@property (weak, nonatomic) IBOutlet UITextField *receiverefer;
@property (weak, nonatomic) IBOutlet UITextField *x;
@property (weak, nonatomic) IBOutlet UITextField *y;
@property (weak, nonatomic) IBOutlet UITextField *sendpower;
@property (weak, nonatomic) IBOutlet UITextField *sendgain;
// 处理隐藏Cell
@property (weak, nonatomic) IBOutlet UITableViewCell *receivereferCell;

- (IBAction)Cancel:(id)sender;
- (IBAction)Save:(id)sender;
- (IBAction)isreferSwitch:(id)sender;

// 接收segue传值
@property (nonatomic) int map_id;

@end
