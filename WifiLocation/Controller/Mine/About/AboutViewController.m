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
   NSLog(@"***************************************************************");
//    [self obtainData];
   NSLog(@"***************************************************************");
   [self downLoad];
   
   self.navigationItem.hidesBackButton = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
   NSString *domainStr = @"http://music.163.com/api/song/detail/?id=29744810&ids=%5B29744810%5D";
   
   NSString *baiduStr = @"http://www.baidu.com";
   
   NSURL *URL = [NSURL URLWithString:domainStr];
   AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//   manager.requestSerializer = [AFHTTPRequestSerializer serializer];
   
   [manager GET:URL.absoluteString parameters:nil success:^(NSURLSessionTask *task, id responseObject) {
      NSLog(@"JSON: %@", responseObject);
   } failure:^(NSURLSessionTask *operation, NSError *error) {
      NSLog(@"Error: %@", error);
   }];
   
   [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)downLoad{
   
   //1.创建管理者对象
   AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
   //2.确定请求的URL地址
   NSURL *url = [NSURL URLWithString:@"https://ss0.bdstatic.com/5aV1bjqh_Q23odCf/static/superman/img/logo/bd_logo1_31bdc765.png"];
   
   //3.创建请求对象
   NSURLRequest *request = [NSURLRequest requestWithURL:url];
   
   //下载任务
   NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
      //打印下下载进度
      NSLog(@"%lf",1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
      
   } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
      //下载地址
      NSLog(@"默认下载地址:%@",targetPath);
      
      //设置下载路径，通过沙盒获取缓存地址，最后返回NSURL对象
      NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
      return [NSURL fileURLWithPath:filePath];
      
      
   } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
      
      //下载完成调用的方法
      
      NSLog(@"下载完成：");
      NSLog(@"%@--%@",response,filePath);
   }];
   
   //开始启动任务
   [task resume];
}

@end
