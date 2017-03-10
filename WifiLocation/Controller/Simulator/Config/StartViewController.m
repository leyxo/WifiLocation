//
//  StartViewController.m
//  WifiLocation
//
//  Created by LEY's MacBook on 17/03/10.
//  Copyright © 2017年 LEY's MacBook. All rights reserved.
//

#import "StartViewController.h"

@implementation StartViewController
@synthesize drawView;

- (void)viewDidLoad {
    [super viewDidLoad];
   
   self.navigationItem.title = self.map.map_name;
   self.navigationItem.hidesBackButton = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated {
   // 算法名称
   NSMutableArray *nameArray = [NSMutableArray arrayWithObjects:@"所有算法", @"NN", @"KNN", @"WKNN", @"贝叶斯算法", nil];
   NSString *name = [nameArray objectAtIndex:self.algo];
   MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
   hud.labelText = [NSString stringWithFormat:@"算法: %@", name];
   hud.mode = MBProgressHUDModeIndeterminate;
   dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{ dispatch_async(dispatch_get_main_queue(), ^{ [hud hide:YES afterDelay:1.0]; }); });
   
   // 开始实验
   [self loadData];
}


#pragma mark - 加载数据
-(void)loadData{
   // 传参并调用drawRect()
   drawView.map = self.map;
   drawView.algo = self.algo;
   
   // 在新的RunLoop里进行刷新图像 http://m.blog.csdn.net/article/details?id=50899435
   dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
      //更新变量
      dispatch_async(dispatch_get_main_queue(), ^{
         //更新动画
         [self.drawView setNeedsDisplay];
      });
   });
}


#pragma mark - 屏幕旋转触发刷新
// 手动添加的，带有动画的屏幕旋转发生时的动作
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
   // 算法名称
   NSMutableArray *nameArray = [NSMutableArray arrayWithObjects:@"所有算法", @"NN", @"KNN", @"WKNN", @"贝叶斯算法", nil];
   NSString *name = [nameArray objectAtIndex:self.algo];
   MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
   hud.labelText = [NSString stringWithFormat:@"算法: %@", name];
   hud.mode = MBProgressHUDModeIndeterminate;
   dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{ dispatch_async(dispatch_get_main_queue(), ^{ [hud hide:YES afterDelay:1.0]; }); });
   
   [self loadData];
}


#pragma mark - Button

- (IBAction)End:(id)sender {
   [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)SaveToPhoto:(id)sender {
   UIActionSheet * sheet = [[UIActionSheet alloc] initWithTitle:@"分享实验结果"  delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"保存到相册", @"分享至…",nil];
   [sheet showInView:self.view];
   
   
}

- (IBAction)Examples:(id)sender {
   MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
   hud.mode = MBProgressHUDModeCustomView;
   hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Example.png"]];
   dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{ dispatch_async(dispatch_get_main_queue(), ^{ [hud hide:YES afterDelay:5.0]; }); });
}

// 实现<UIActionSheetDelegate>的actionSHeet协议
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
   // 保存到相册
   if (buttonIndex == 0) {
      CGSize s = self.drawView.bounds.size;
      UIGraphicsBeginImageContextWithOptions(s, NO, [UIScreen mainScreen].scale);
      [drawView.layer renderInContext:UIGraphicsGetCurrentContext()];
      UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
      UIGraphicsEndImageContext();
      
      UIImageWriteToSavedPhotosAlbum(image,self,nil,nil);
      
      MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
      hud.labelText = [NSString stringWithFormat:@"已保存到相册"];
      hud.mode = MBProgressHUDModeText;
      dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{ dispatch_async(dispatch_get_main_queue(), ^{ [hud hide:YES afterDelay:1.6]; }); });
   }
   else if (buttonIndex == 1) {
   }
}

@end
