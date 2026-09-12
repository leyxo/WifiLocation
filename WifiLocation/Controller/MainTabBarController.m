//
//  MainTabBarController.m
//  WifiLocation
//
//  Created by LEY's MacBook on 17/03/01.
//  Copyright © 2017年 LEY's MacBook. All rights reserved.
//

#import "MainTabBarController.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - 键盘快捷键实现
- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (NSArray<UIKeyCommand *>*)keyCommands {
    return @[
        [UIKeyCommand keyCommandWithInput:@"1" modifierFlags:UIKeyModifierCommand action:@selector(selectTab:) discoverabilityTitle:@"地图"],
        [UIKeyCommand keyCommandWithInput:@"2" modifierFlags:UIKeyModifierCommand action:@selector(selectTab:) discoverabilityTitle:@"管理"],
        [UIKeyCommand keyCommandWithInput:@"3" modifierFlags:UIKeyModifierCommand action:@selector(selectTab:) discoverabilityTitle:@"用户"],
    ];
}

- (void)selectTab:(UIKeyCommand *)sender {
    NSString *selectedTab = sender.input;
    self.selectedIndex = selectedTab.intValue - 1;
}

@end
