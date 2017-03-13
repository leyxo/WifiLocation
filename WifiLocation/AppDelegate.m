//
//  AppDelegate.m
//  WifiLocation
//
//  Created by LEY's MacBook on 17/02/28.
//  Copyright © 2017年 LEY's MacBook. All rights reserved.
//

#import "AppDelegate.h"
#import "MapsTableViewController.h"

#import "MineTableViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   // 白色状态栏文字
   [application setStatusBarStyle:UIStatusBarStyleLightContent];
   
   self.window.backgroundColor = [UIColor whiteColor];
   
   return YES;
}

// 3D Touch ShorCut事件处理
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void(^)(BOOL succeeded))completionHandler{
   if([shortcutItem.type isEqualToString:@"map"]) {
//      MapsTableViewController *vc = [[MapsTableViewController alloc] init];
//      [self.window.rootViewController presentViewController:vc animated:YES completion:^{ }];
   }
   else if([shortcutItem.type isEqualToString:@"manage"]) {
//      UIViewController *vc = [[UIViewController alloc] init];
//      [self.window.rootViewController presentViewController:vc animated:YES completion:^{ }];
   }
   else if([shortcutItem.type isEqualToString:@"me"]) {
//      MineTableViewController *vc = [[MineTableViewController alloc] init];
//      [self.window.rootViewController presentViewController:vc animated:YES completion:^{ }];
   }
}

- (void)applicationWillResignActive:(UIApplication *)application {
   // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
   // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
   // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
   // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
   // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
   // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
   // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
