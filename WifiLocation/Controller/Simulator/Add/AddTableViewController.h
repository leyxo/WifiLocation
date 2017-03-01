//
//  AddTableViewController.h
//  WifiLocation
//
//  Created by LEY's MacBook on 17/03/01.
//  Copyright © 2017年 LEY's MacBook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddTableViewController : UITableViewController <UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UITextField *map_name;
@property (weak, nonatomic) IBOutlet UITextField *map_width;
@property (weak, nonatomic) IBOutlet UITextField *map_height;
@property (weak, nonatomic) IBOutlet UITextView *map_info;

- (IBAction)Cancel:(id)sender;
- (IBAction)Save:(id)sender;

@end
