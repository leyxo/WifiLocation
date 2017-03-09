//
//  SimuTableViewCell.h
//  WifiLocation
//
//  Created by LEY's MacBook on 17/03/09.
//  Copyright © 2017年 LEY's MacBook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SimuTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *simu_id;
@property (weak, nonatomic) IBOutlet UILabel *real_x;
@property (weak, nonatomic) IBOutlet UILabel *real_y;

@end
