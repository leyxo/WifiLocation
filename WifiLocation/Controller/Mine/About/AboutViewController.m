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
@synthesize imageView;

- (void)viewDidLoad {
    [super viewDidLoad];
   goodFontSize = 15;
   awfulFontSize = 15;
   hasClickedAwful = NO;
   
#pragma mark AFNetworking
   // 测试AFNetworking
   NSLog(@"***************************************************************");
//    [self obtainData];
   NSLog(@"***************************************************************");
   [self downLoad];
   
   self.navigationItem.hidesBackButton = YES;
   
#pragma mark 手势操作
   // 拖拽事件
   UIPanGestureRecognizer *pan=[[UIPanGestureRecognizer alloc]init];
   [self.imageView addGestureRecognizer:pan];
   [pan addTarget:self action:@selector(handlePan:)];
   // 旋转
   UIRotationGestureRecognizer *rotate=[[UIRotationGestureRecognizer alloc]init];
   [self.imageView addGestureRecognizer:rotate];
   [rotate addTarget:self action:@selector(rotateView:)];
   // 缩放
   UIPinchGestureRecognizer *pinch=[[UIPinchGestureRecognizer alloc]init];
   [self.imageView addGestureRecognizer:pinch];
   [pinch addTarget:self action:@selector(pinchView:)];
   
   // 使用代理，以同时响应多个手势
   pan.delegate=self;
   rotate.delegate=self;
   pinch.delegate=self;
   
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



// 使view可以实现响应Shake手势
-(BOOL)canBecomeFirstResponder
{
   return YES;
}

-(void)viewDidAppear:(BOOL)animated
{
   [super viewDidAppear:animated];
   // 使view响应Shake手势
   [self becomeFirstResponder];
}

-(void)viewWillDisappear:(BOOL)animated
{
   // 显示Navi
//   [self.navigationController setNavigationBarHidden:NO animated:YES];
   self.navigationController.tabBarController.hidesBottomBarWhenPushed=NO;
   
   // 使view放弃响应Shake手势
   [self resignFirstResponder];
   [super viewWillDisappear:animated];
}


#pragma mark - Shake手势
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
      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"???" message:@"" delegate:self cancelButtonTitle:@"" otherButtonTitles:nil];
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


#pragma mark - Button
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

#pragma mark - 测试AFNetworking
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


#pragma mark - 手势操作
// 惯性滚动拖拽
- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
   //视图前置操作
   [recognizer.view.superview bringSubviewToFront:recognizer.view];
   CGPoint center = recognizer.view.center;
   CGFloat cornerRadius = recognizer.view.frame.size.width / 2;
   CGPoint translation = [recognizer translationInView:self.view];
   // NSLog(@"%@", NSStringFromCGPoint(translation));
   recognizer.view.center = CGPointMake(center.x + translation.x, center.y + translation.y);
   [recognizer setTranslation:CGPointZero inView:self.view];
   if (recognizer.state == UIGestureRecognizerStateEnded)
   {
      //计算速度向量的长度，当他小于200时，滑行会很短
      CGPoint velocity = [recognizer velocityInView:self.view];
      CGFloat magnitude = sqrtf((velocity.x * velocity.x) + (velocity.y * velocity.y));
      CGFloat slideMult = magnitude / 800;
      //NSLog(@"magnitude: %f, slideMult: %f", magnitude, slideMult);
      //e.g. 397.973175, slideMult: 1.989866
      //基于速度和速度因素计算一个终点
      float slideFactor = 0.1 * slideMult;
      CGPoint finalPoint = CGPointMake(center.x + (velocity.x * slideFactor),
                                       center.y + (velocity.y * slideFactor));
      //限制最小［cornerRadius］和最大边界值［self.view.bounds.size.width - cornerRadius］，以免拖动出屏幕界限
      finalPoint.x = MIN(MAX(finalPoint.x, cornerRadius),
      self.view.bounds.size.width - cornerRadius);
      finalPoint.y = MIN(MAX(finalPoint.y, cornerRadius),
                         self.view.bounds.size.height - cornerRadius);
      //使用 UIView 动画使 view 滑行到终点
      [UIView animateWithDuration:slideFactor*2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{ recognizer.view.center = finalPoint; } completion:nil];
   }
}

-(void)panView:(UIPanGestureRecognizer*)pan
{
   //以控制器上的view的左上角为坐标原点
   CGPoint point=[pan locationInView:pan.view];
//   NSLog(@"拖拽事件");
//   NSLog(@"获取到的触摸点的位置为:%@",NSStringFromCGPoint(point));
   CGPoint point1=[pan translationInView:pan.view];
   //   NSLog(@"拖拽事件");
   //   NSLog(@"获取到的触摸点的位置为:%@",NSStringFromCGPoint(point));

   //手指拖动，让自定义的view也跟着手指移动
   CGPoint temp=self.imageView.center;
   temp.x+=point1.x;
   temp.y+=point1.y;
   self.imageView.center=temp;

   //清空
   [pan setTranslation:CGPointZero inView:pan.view];
}

-(void)rotateView:(UIRotationGestureRecognizer*)gesture
{
   //旋转的弧度：gesture.rotation
//   NSLog(@"旋转事件，旋转的弧度为:%1f",gesture.rotation);

   //让图片跟随手指一起旋转
   //每次从最初的位置开始
//   self.iconView.transform=CGAffineTransformMakeRotation(gesture.rotation);

   //在传入的transform的基础上旋转
   //在之前的基础上，让图片跟随一起旋转（去掉自动布局）
   //注意问题：以风火轮的速度旋转
   self.imageView.transform=CGAffineTransformRotate(self.imageView.transform, gesture.rotation);
   //将旋转的弧度清零
   //（注意不是将图片旋转的弧度清零，而是将当前手指旋转的弧度清零）
   gesture.rotation=0;
}

-(void)pinchView:( UIPinchGestureRecognizer* )pinch
{
   //缩放的比例    pinch.scale;
//   NSLog(@"缩放：%f",pinch.scale);
   //对图片进行缩放
//   self.iconView.transform=CGAffineTransformMakeScale(pinch.scale,pinch.scale);
   //在已有的基础上对图片进行缩放
   self.imageView.transform=CGAffineTransformScale(self.imageView.transform, pinch.scale, pinch.scale);
   //清零
   pinch.scale=1.0;
}

//实现代理方法
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
   //默认为NO,这里设置为YES
   return YES;
}

@end
