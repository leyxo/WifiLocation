//
//  AboutViewController.m
//  WifiLocation
//
//  Created by LEY's MacBook on 17/03/01.
//  Copyright © 2017年 LEY's MacBook. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController
@synthesize GoodButton, AwfulButton;

- (void)viewDidLoad {
    [super viewDidLoad];
   goodFontSize = 15;
   awfulFontSize = 15;
   
   self.navigationItem.hidesBackButton = YES;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma 摇动彩蛋
-(BOOL)canBecomeFirstResponder
{
   return YES;
}

-(void)viewDidAppear:(BOOL)animated
{
   [super viewDidAppear:animated];
   [self becomeFirstResponder];
}

-(void)viewWillDisappear:(BOOL)animated
{
   [self resignFirstResponder];
   [super viewWillDisappear:animated];
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
   if (event.type == UIEventSubtypeMotionShake)
   {
      NSLog(@"Shake Began");
   }
}

-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
   if (event.type == UIEventSubtypeMotionShake)
   {
      NSLog(@"Shake End");
      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请不要用力摇晃手机！" message:@"我知道你看到这个软件很激动..." delegate:self cancelButtonTitle:@"嗯，好的" otherButtonTitles:@"知道啦~", nil];
      [alert setTag:0];
      [alert show];
   }
}

-(void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
   if (event.type == UIEventSubtypeMotionShake)
   {
      NSLog(@"Shake Cancelled");
   }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)GoodOnClick:(id)sender {
   UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"谢谢支持，哼~" message:@"良心软件" delegate:self cancelButtonTitle:@"不客气!" otherButtonTitles:@"我错了...", nil];
   [alert setTag:1];
   [alert show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex;{
   if(alertView.tag == 1)
   {
      if (buttonIndex == 0 || buttonIndex == 1)
      {
         [self.navigationController popViewControllerAnimated:YES];
      }
   }
}

- (IBAction)AwfulOnClick:(id)sender {
   if(awfulFontSize > 0) {
   GoodButton.titleLabel.font = [UIFont systemFontOfSize: ++goodFontSize];
   AwfulButton.titleLabel.font = [UIFont systemFontOfSize: --awfulFontSize];
   }
}
@end
