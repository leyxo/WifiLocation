//
//  RouteTableViewController.h
//  WifiLocation
//
//  Created by LEY's MacBook on 17/03/01.
//  Copyright © 2017年 LEY's MacBook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SimuModel.h"
#import "MapModel.h"
#import "SimuDrawView.h"

@interface RouteViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet SimuDrawView *drawView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic, retain) NSMutableArray * listData;

@property (weak, nonatomic) IBOutlet UILabel *lastPointX;
@property (weak, nonatomic) IBOutlet UILabel *lastPointY;
@property (weak, nonatomic) IBOutlet UITextField *PointX;
@property (weak, nonatomic) IBOutlet UITextField *PointY;

- (IBAction)Clear:(id)sender;
- (IBAction)Add:(id)sender;

// 临时存储一个FP
@property (nonatomic) SimuModel * simu;

// 接收segue传值
@property (nonatomic) MapModel *map;

@end
