//
//  SettingsTableViewController.m
//  WifiLocation
//
//  Created by LEY's MacBook on 17/03/27.
//  Copyright © 2017年 LEY's MacBook. All rights reserved.
//

#import "SettingsTableViewController.h"

@interface SettingsTableViewController ()

@property(nonatomic, assign)BOOL isHiddenItem;

@end

@implementation SettingsTableViewController
@synthesize charsetLabel, poolLabel;
@synthesize isLocalServer;

- (void)viewDidLoad {
    [super viewDidLoad];

    self.isHiddenItem = YES;
    charsetList = [[NSArray alloc] initWithObjects:@"utf-8", @"GB2312", @"GBK", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.section == 2 && indexPath.row == 3) {
        // 字符集

    }
    else if(indexPath.section == 2 && indexPath.row == 5) {
        // 连接池
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                                 delegate:self
                                                        cancelButtonTitle:@"取消"
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:@"true", @"false", nil];
        [actionSheet showInView:self.view];
        actionSheet.tag = 1;
    }
}


#pragma mark - UIPickerViewDataSource
// pickerView 列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// pickerView 每列个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return [charsetList count];
    }
    
    return [charsetList count];
}

// pickerView 列中标题
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [charsetList objectAtIndex:row];
}

// pickerView 选中一项
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    charsetLabel.text = [charsetList objectAtIndex:row];
}


#pragma mark - 实现<UIActionSheetDelegate>的actionSHeet协议
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    // 连接池
    if(actionSheet.tag == 1)
    {
        if (buttonIndex == 0) {
            poolLabel.text = @"true";
        }
        else if (buttonIndex == 1) {
            poolLabel.text = @"false";
        }
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

// 处理隐藏cell
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2 && indexPath.row == 4) {
        return 118;
    }
    if (indexPath.section == 1 && indexPath.row == 1 && self.isHiddenItem) {
        return 0;
    }
    return 44;
}

- (IBAction)isLocalServerSwitch:(id)sender {
   if(isLocalServer.on == YES) {
      self.isHiddenItem = YES;
   }
   else {
      self.isHiddenItem = NO;
   }
   [self.tableView reloadData];
}
@end
