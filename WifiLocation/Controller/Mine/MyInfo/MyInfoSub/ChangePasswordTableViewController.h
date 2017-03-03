//
//  ChangePasswordTableViewController.h
//  WifiLocation
//
//  Created by LEY's MacBook on 17/03/03.
//  Copyright © 2017年 LEY's MacBook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangePasswordTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

- (IBAction)Save:(id)sender;

@end
