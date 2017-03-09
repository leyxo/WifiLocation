//
//  APDrawView.h
//  WifiLocation
//
//  Created by LEY's MacBook on 17/03/09.
//  Copyright © 2017年 LEY's MacBook. All rights reserved.
//

// AP配置及指纹节点配置公用同一个DrawView

#import <UIKit/UIKit.h>
#import "MapModel.h"
#import "APModel.h"
#import "FPModel.h"

@interface APDrawView : UIView

@property (nonatomic) MapModel *map;

// 临时存储一个AP
@property (nonatomic) APModel * ap;
// 临时存储一个FP
@property (nonatomic) FPModel * fp;

@end
