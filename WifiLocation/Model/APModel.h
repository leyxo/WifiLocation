//
//  APModel.h
//  WifiLocation
//
//  Created by LEY's MacBook on 17/03/08.
//  Copyright © 2017年 LEY's MacBook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APModel : NSObject

@property   int         ap_id;
@property   NSString *  ap_isrefer;
@property   int         map_id;
@property   int         ap_x;
@property   int         ap_y;
@property   int         ap_sendpower;
@property   int         ap_sendgain;
@property   int         ap_receiverefer;

@end
