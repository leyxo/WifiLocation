//
//  FPTableViewCell.h
//  WifiLocation
//
//  Created by LEY's MacBook on 17/03/02.
//  Copyright © 2017年 LEY's MacBook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FPTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *fp_id;
@property (weak, nonatomic) IBOutlet UILabel *fp_x;
@property (weak, nonatomic) IBOutlet UILabel *fp_y;
@property (weak, nonatomic) IBOutlet UILabel *fp_receivegain;

@end
