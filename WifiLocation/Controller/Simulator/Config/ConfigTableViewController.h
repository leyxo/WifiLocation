//
//  ConfigTableViewController.h
//  WifiLocation
//
//  Created by LEY's MacBook on 17/03/01.
//  Copyright © 2017年 LEY's MacBook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapModel.h"

@interface ConfigTableViewController : UITableViewController <UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UILabel *APNotSetup;
@property (weak, nonatomic) IBOutlet UILabel *FPNotSetup;
@property (weak, nonatomic) IBOutlet UILabel *RouteNotSetup;

@property (weak, nonatomic) IBOutlet UILabel *StartLabel;
@property (weak, nonatomic) IBOutlet UILabel *CDFLabel;

- (IBAction)Clear:(id)sender;

// 接收segue传值
@property (nonatomic) MapModel *map;

@end
