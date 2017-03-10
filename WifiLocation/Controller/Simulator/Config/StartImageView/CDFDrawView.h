//
//  CDFDrawView.h
//  WifiLocation
//
//  Created by LEY's MacBook on 17/03/10.
//  Copyright © 2017年 LEY's MacBook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapModel.h"
#import "SimuModel.h"
#import "FPModel.h"
#import "APModel.h"

@interface CDFDrawView : UIView

@property (nonatomic) MapModel *map;

@property (nonatomic) int algo;

// 临时存储一个Simu
@property (nonatomic) SimuModel * simu;
// 临时存储一个AP
@property (nonatomic) APModel * ap;
// 临时存储一个FP
@property (nonatomic) FPModel * fp;

@end
