//
//  AboutViewController.m
//  WifiLocation
//
//  Created by LEY's MacBook on 17/03/01.
//  Copyright © 2017年 LEY's MacBook. All rights reserved.
//

#import "AboutViewController.h"
#import <AFNetworking.h> //主要用于网络请求方法
#import <UIKit+AFNetworking.h> //里面有异步加载图片的方法

@interface AboutViewController ()

@end

@implementation AboutViewController
@synthesize GoodButton, AwfulButton;

- (void)viewDidLoad {
    [super viewDidLoad];
   goodFontSize = 15;
   awfulFontSize = 15;
   hasClickedAwful = NO;
   
   // 测试AFNetworking
   // [self obtainData];
   
   self.navigationItem.hidesBackButton = YES;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewWillAppear:(BOOL)animated{
   // 隐藏Navi
//   [self.navigationController setNavigationBarHidden:YES animated:YES];
   self.navigationController.tabBarController.hidesBottomBarWhenPushed=YES;
   
   [super viewWillAppear:animated];
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
   // 显示Navi
//   [self.navigationController setNavigationBarHidden:NO animated:YES];
   self.navigationController.tabBarController.hidesBottomBarWhenPushed=NO;
   
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
      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"" delegate:self cancelButtonTitle:@"" otherButtonTitles:nil];
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
   UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"谢谢支持!" message:@"良心软件" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil];
   [alert setTag:2];
   
   UIAlertView * alert_shitman = [[UIAlertView alloc] initWithTitle:@"哼~多谢" message:nil delegate:self cancelButtonTitle:@"不客气!" otherButtonTitles:@"我错了...", nil];
   [alert_shitman setTag:1];
   
   if(!hasClickedAwful) {
      [alert show];
   }
   else {
      [alert_shitman show];
   }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex;{
   if(alertView.tag == 1)
   {
      if (buttonIndex == 0)
      {
         GoodButton.titleLabel.font = [UIFont systemFontOfSize: ++goodFontSize];
      }
      else if(buttonIndex == 1)
      {
         [self.navigationController popViewControllerAnimated:YES];

      }
   }
   else if(alertView.tag == 2)
   {
      if (buttonIndex == 0)
      {
         [self.navigationController popViewControllerAnimated:YES];
      }
   }
}

- (IBAction)AwfulOnClick:(id)sender {
   hasClickedAwful = YES;
   if(awfulFontSize > 0) {
   GoodButton.titleLabel.font = [UIFont systemFontOfSize: ++goodFontSize];
   AwfulButton.titleLabel.font = [UIFont systemFontOfSize: --awfulFontSize];
   }
}

#pragma 测试AFNetworking
-(void)obtainData
{
   // 启动系统风火轮
   [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
   
   //前面写服务器给的域名,后面拼接上需要提交的参数，假如参数是key＝1
   NSString *domainStr = @"http://music.163.com/api/song/detail/?id=29744810&ids=%5B29744810%5D&csrf_token=";
   
   AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
   manager.responseSerializer = [AFHTTPResponseSerializer serializer];
   
   //以get的形式提交，只需要将上面的请求地址给GET做参数就可以
   [manager GET:domainStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
      // 隐藏系统风火轮
      [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
      
      //json解析
      NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
      
      NSLog(@"---获取到的json格式的字典--%@",resultDic);
      
   } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
      
      // 解析失败隐藏系统风火轮(可以打印error.userInfo查看错误信息)
      [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
      
   }];
}



@end
