//
//  SettingsTableViewController.h
//  WifiLocation
//
//  Created by LEY's MacBook on 17/03/27.
//  Copyright © 2017年 LEY's MacBook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsTableViewController : UITableViewController <UIPickerViewDelegate, UIPickerViewDataSource, UIActionSheetDelegate> {
    NSArray *charsetList;
}

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UISwitch *isLocalServer;

@property (weak, nonatomic) IBOutlet UIPickerView *charsetPickerView;

@property (weak, nonatomic) IBOutlet UILabel *charsetLabel;
@property (weak, nonatomic) IBOutlet UILabel *poolLabel;

- (IBAction)isLocalServerSwitch:(id)sender;
@end
