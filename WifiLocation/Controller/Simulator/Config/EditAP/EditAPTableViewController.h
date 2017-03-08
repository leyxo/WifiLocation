//
//  EditAPTableViewController.h
//  WifiLocation
//
//  Created by LEY's MacBook on 17/03/02.
//  Copyright © 2017年 LEY's MacBook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APModel.h"

@interface EditAPTableViewController : UITableViewController <UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UISwitch *isreferSwitch;
@property (weak, nonatomic) IBOutlet UITextField *receiverefer;
@property (weak, nonatomic) IBOutlet UITextField *x;
@property (weak, nonatomic) IBOutlet UITextField *y;
@property (weak, nonatomic) IBOutlet UITextField *sendpower;
@property (weak, nonatomic) IBOutlet UITextField *sendgain;

- (IBAction)Cancel:(id)sender;
- (IBAction)Save:(id)sender;

// 处理隐藏Cell
@property (weak, nonatomic) IBOutlet UITableViewCell *receivereferCell;

// 接收segue传值
@property (nonatomic) APModel *ap;

@end
