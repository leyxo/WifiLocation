//
//  AboutViewController.h
//  WifiLocation
//
//  Created by LEY's MacBook on 17/03/01.
//  Copyright © 2017年 LEY's MacBook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutViewController : UIViewController <UIAlertViewDelegate, UIGestureRecognizerDelegate> {
   int goodFontSize;
   int awfulFontSize;
   bool hasClickedAwful;
}
@property (weak, nonatomic) IBOutlet UIButton *GoodButton;
@property (weak, nonatomic) IBOutlet UIButton *AwfulButton;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)GoodOnClick:(id)sender;
- (IBAction)AwfulOnClick:(id)sender;

@end
