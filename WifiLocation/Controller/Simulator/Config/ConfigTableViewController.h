//
//  ConfigTableViewController.h
//  WifiLocation
//
//  Created by LEY's MacBook on 17/03/01.
//  Copyright © 2017年 LEY's MacBook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfigTableViewController : UITableViewController <UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *APNotSetup;
@property (weak, nonatomic) IBOutlet UILabel *FPNotSetup;
@property (weak, nonatomic) IBOutlet UILabel *RouteNotSetup;

// 接收segue传值
@property (nonatomic, retain) NSString    * segueMapNname;
@property (nonatomic, retain) NSString    * segueMapInfo;
@property (nonatomic)         int         segueMapWidth;
@property (nonatomic)         int         segueMapHeight;

- (IBAction)Clear:(id)sender;

@end
