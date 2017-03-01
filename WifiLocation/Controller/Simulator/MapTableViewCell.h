//
//  MapTableViewCell.h
//  WifiLocation
//
//  Created by LEY's MacBook on 17/03/01.
//  Copyright © 2017年 LEY's MacBook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MapTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *map_name;
@property (weak, nonatomic) IBOutlet UILabel *map_info;
@property (weak, nonatomic) IBOutlet UILabel *map_width;
@property (weak, nonatomic) IBOutlet UILabel *map_height;

@end
