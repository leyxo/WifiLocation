//
//  SimuDrawView.h
//  WifiLocation
//
//  Created by LEY's MacBook on 17/03/09.
//  Copyright © 2017年 LEY's MacBook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapModel.h"
#import "SimuModel.h"

@interface SimuDrawView : UIView

@property (nonatomic) MapModel *map;

// 临时存储一个Simu
@property (nonatomic) SimuModel * simu;

@end
