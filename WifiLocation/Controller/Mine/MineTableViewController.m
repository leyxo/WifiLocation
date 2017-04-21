//
//  MineTableViewController.m
//  WifiLocation
//
//  Created by LEY's MacBook on 17/03/01.
//  Copyright © 2017年 LEY's MacBook. All rights reserved.
//

#import "MineTableViewController.h"
#import "AboutViewController.h"

#import "LoginViewController.h"

@interface MineTableViewController ()

@end

@implementation MineTableViewController
@synthesize imageView, headerView, blurImageView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建imageView
    imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, pictureHeight)];
    [imageView setImage:[UIImage imageNamed:@"Desktop.jpg"]];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    // 创建headerView
    headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, pictureHeight)];
    [headerView addSubview:imageView];
    self.tableView.tableHeaderView = headerView;
    
   // 测试登录页面，需要删掉
   LoginViewController * loginViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"loginViewController"];
    
    self.definesPresentationContext = YES; //self is presenting view controller
    loginViewController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
   
    [self.navigationController presentViewController:loginViewController animated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
   
   // segue.identifier：获取连线的ID
   // if ([segue.identifier isEqualToString:@"About"]) {
      // segue.destinationViewController：获取连线时所指的界面（VC）
      UIViewController *receive = segue.destinationViewController;
   
      // 隐藏TabBar
      receive.hidesBottomBarWhenPushed = YES;
   // }
}


#pragma mark - HeadView

//scrollView的方法视图滑动时 实时调用
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat yOffset = self.tableView.contentOffset.y;
    //向上偏移量变正  向下偏移量变负
    if (yOffset < 0) {
        CGFloat factor = ABS(yOffset)+200;
        CGRect f = CGRectMake(-([[UIScreen mainScreen] bounds].size.width*factor/200-[[UIScreen mainScreen] bounds].size.width)/2,-ABS(yOffset), [[UIScreen mainScreen] bounds].size.width*factor/200, factor);
        imageView.frame = f;
        [self.navigationController setNavigationBarHidden:YES animated:NO];
    }
    else {
        CGRect f = headerView.frame;
        f.origin.y = 0;
        headerView.frame = f;
        imageView.frame = CGRectMake(0, f.origin.y, [[UIScreen mainScreen] bounds].size.width, 200);
        [self.navigationController setNavigationBarHidden:NO animated:NO];
        
        // 渐变navigationBar
        CGFloat alpha = yOffset / 100;
        if(alpha > 1) {
            alpha = 1;
        }
        UIColor *naviColor = [UIColor colorWithRed:(float)26/255 green:(float)26/255 blue:(float)26/255 alpha:alpha];
//        self.navigationController.navigationBar.barTintColor = naviColor;
    }
}

@end
