//
//  MineTableViewController.h
//  WifiLocation
//
//  Created by LEY's MacBook on 17/03/01.
//  Copyright © 2017年 LEY's MacBook. All rights reserved.
//

#import <UIKit/UIKit.h>
#define pictureHeight 200
#define kScreenbounds [UIScreen mainScreen].bounds
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight  [UIScreen mainScreen].bounds.size.height

@interface MineTableViewController : UITableViewController

// 表头下拉放大背景
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIImageView *blurImageView;

@end
