//
//  APTableViewCell.h
//  WifiLocation
//
//  Created by LEY's MacBook on 17/03/01.
//  Copyright © 2017年 LEY's MacBook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface APTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *ap_id;
@property (weak, nonatomic) IBOutlet UILabel *ap_x;
@property (weak, nonatomic) IBOutlet UILabel *ap_y;
@property (weak, nonatomic) IBOutlet UILabel *ap_isrefer;
@property (weak, nonatomic) IBOutlet UILabel *ap_receiverefer;
@property (weak, nonatomic) IBOutlet UILabel *ap_sendpower;
@property (weak, nonatomic) IBOutlet UILabel *ap_sendgain;

@end
