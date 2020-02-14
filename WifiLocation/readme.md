
  readme.h
  WifiLocation

  Created by LEY's MacBook on 17/03/02.
  Copyright © 2017年 LEY's MacBook. All rights reserved.


 **************************  界面颜色初始化  **************************

 AppDelegate
    状态栏白色文字
       [application setStatusBarStyle:UIStatusBarStyleLightContent];
    Window白色背景
       self.window.backgroundColor = [UIColor whiteColor];


 MainTabBarController
    TabBar深灰色文字
       UIColor *tabColor = [UIColor darkGrayColor];
       [self.tabBar setTintColor:tabColor];


 BaseNavigationController
    背景颜色(26, 26, 26)
       UIColor *naviColor = [UIColor colorWithRed:(float)26/255 green:(float)26/255 blue:(float)26/255 alpha:1];
    NavVar背景颜色
       [self.navigationBar setBarTintColor:naviColor];
    NavBar图标白色
       [self.navigationBar setTintColor:[UIColor whiteColor]];
    NavBar标题白色
       [self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];


 ****************************  组织结构  ****************************

 MainTabBarController -> BaseNavigationController -> TableViewController


 ****************************  其他东西  ****************************

 在 AboutViewCOntroller.m 中进行了网络测试(AFNetworking.h)


 如果有自定义高度的NavigationBar和TabBar，可设置tableView的Inset区域，使Bar们下面磨砂
 self.tableview.contentInset = UIEdgeInsetsMake(44, 0, 56, 0);


 // 修改导航栏高度
 CGRect rect = self.navigationController.navigationBar.frame;
 self.navigationController.navigationBar.frame = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, 84);
 // title位置调高
 [self.navigationController.navigationBar setTitleVerticalPositionAdjustment:-40.0 forBarMetrics:UIBarMetricsDefault];
 // rightBarButtonItem
 [self.navigationItem.rightBarButtonItem setBackgroundVerticalPositionAdjustment:-40.0 forBarMetrics:UIBarMetricsDefault];







