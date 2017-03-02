//
//  MapsTableViewController.h
//  WifiLocation
//
//  Created by LEY's MacBook on 17/03/01.
//  Copyright © 2017年 LEY's MacBook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MapsTableViewController : UITableViewController

@property (nonatomic, retain) NSMutableArray * listData;

// 临时存储选择的indexPath
@property (nonatomic, retain) NSIndexPath * selectIndexPath;

@end
