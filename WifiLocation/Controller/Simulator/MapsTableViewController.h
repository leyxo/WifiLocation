//
//  MapsTableViewController.h
//  WifiLocation
//
//  Created by LEY's MacBook on 17/03/01.
//  Copyright © 2017年 LEY's MacBook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapModel.h"

@interface MapsTableViewController : UITableViewController <UIActionSheetDelegate, UISearchBarDelegate, UISearchResultsUpdating>

@property (nonatomic, strong) UISearchController *searchController;

@property (nonatomic, retain) NSMutableArray * listData;
// 存放搜索过滤的结果
@property (nonatomic, retain) NSMutableArray * searchListData;

// 临时存储选择的indexPath
@property (nonatomic, retain) NSIndexPath * selectIndexPath;
// 临时存储一个Map
@property (nonatomic) MapModel * map;


@end
