//
//  TodayViewController.m
//  WifiLocationToday
//
//  Created by LEY's MacBook on 17/03/13.
//  Copyright © 2017年 LEY's MacBook. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

@interface TodayViewController () <NCWidgetProviding>

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
   if ([[UIDevice currentDevice].systemVersion doubleValue] >= 10.0) {
      self.extensionContext.widgetLargestAvailableDisplayMode = NCWidgetDisplayModeCompact;
   }
   self.preferredContentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 110);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)widgetActiveDisplayModeDidChange:(NCWidgetDisplayMode)activeDisplayMode withMaximumSize:(CGSize)maxSize{
   if (activeDisplayMode == NCWidgetDisplayModeCompact) {
      
      NSLog(@"maxSize-%@",NSStringFromCGSize(maxSize));// maxSize-{359, 110}
   }else{
      NSLog(@"maxSize-%@",NSStringFromCGSize(maxSize));// maxSize-{359, 616}
   }
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}

- (IBAction)AddMap:(id)sender {
}
@end
