//
//  StartViewController.h
//  WifiLocation
//
//  Created by LEY's MacBook on 17/03/10.
//  Copyright © 2017年 LEY's MacBook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapModel.h"
#import "StartDrawView.h"

@interface StartViewController : UIViewController <UIActionSheetDelegate, UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet StartDrawView *drawView;

- (IBAction)End:(id)sender;
- (IBAction)SaveToPhoto:(id)sender;
- (IBAction)Examples:(id)sender;

// 接收segue传值
@property (nonatomic) MapModel *map;

// 算法 0:所有算法 1:NN 2:KNN 3:WKNN 4:贝叶斯
@property (nonatomic) int algo;

@end
