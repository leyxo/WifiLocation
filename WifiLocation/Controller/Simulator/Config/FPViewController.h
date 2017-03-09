//
//  FPTableViewController.h
//  WifiLocation
//
//  Created by LEY's MacBook on 17/03/01.
//  Copyright © 2017年 LEY's MacBook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FPModel.h"
#import "MapModel.h"
#import "APDrawView.h"

@interface FPViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet APDrawView *drawView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView; // 已废弃
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic, retain) NSMutableArray * listData;

@property (weak, nonatomic) IBOutlet UITextField *distance;
@property (weak, nonatomic) IBOutlet UITextField *receivegain;

- (IBAction)Generate:(id)sender;

// 临时存储一个FP
@property (nonatomic) FPModel * fp;

// 接收segue传值
@property (nonatomic) MapModel *map;

@end
