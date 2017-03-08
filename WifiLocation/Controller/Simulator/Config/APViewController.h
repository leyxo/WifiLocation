//
//  APTableViewController.h
//  WifiLocation
//
//  Created by LEY's MacBook on 17/03/01.
//  Copyright © 2017年 LEY's MacBook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APModel.h"

@interface APViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic, retain) NSMutableArray * listData;

// 临时存储一个AP
@property (nonatomic) APModel * ap;

// 接收segue传值
@property (nonatomic) int map_id;

@end
