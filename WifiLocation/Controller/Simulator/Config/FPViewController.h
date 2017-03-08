//
//  FPTableViewController.h
//  WifiLocation
//
//  Created by LEY's MacBook on 17/03/01.
//  Copyright © 2017年 LEY's MacBook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FPModel.h"

@interface FPViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UITextField *distance;
@property (weak, nonatomic) IBOutlet UITextField *receivegain;

@property (nonatomic, retain) NSMutableArray * listData;

- (IBAction)Generate:(id)sender;

// 临时存储一个FP
@property (nonatomic) FPModel * fp;

// 接收segue传值
@property (nonatomic) int map_id;

@end
