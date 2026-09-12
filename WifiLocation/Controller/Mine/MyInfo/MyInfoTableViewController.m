//
//  MyInfoTableViewController.m
//  WifiLocation
//
//  Created by LEY's MacBook on 17/03/01.
//  Copyright © 2017年 LEY's MacBook. All rights reserved.
//

#import "MyInfoTableViewController.h"

@interface MyInfoTableViewController ()

@end

@implementation MyInfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}
 */

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   [tableView deselectRowAtIndexPath:indexPath animated:YES];
   // 选取头像
   if(indexPath.section == 0 && indexPath.row == 0) {
      [self callActionSheetFunc];
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


/**
 @ 调用ActionSheet
 */
- (void)callActionSheetFunc{
   UIActionSheet *actionSheet;
   
   if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
      actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择图像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册选择", nil];
   }else{
      actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择图像" delegate:self cancelButtonTitle:@"取消"destructiveButtonTitle:nil otherButtonTitles:@"从相册选择", nil];
   }
   
   actionSheet.tag = 1000;
   [actionSheet showInView:self.view];
}

// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
   if (actionSheet.tag == 1000) {
      NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;

      // 判断是否支持相机
      if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
         switch (buttonIndex) {
            case 0:
               //来源:相机
               sourceType = UIImagePickerControllerSourceTypeCamera;
               break;
            case 1:
               //来源:相册
               sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
               break;
            case 2:
               return;
         }
      }
      else switch (buttonIndex) {
         case 0:
            //来源:相册
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            break;
         case 1:
            return;
      }
      
      // 跳转到相机或相册页面
      UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
      imagePickerController.delegate = self;
      imagePickerController.allowsEditing = YES;
      imagePickerController.sourceType = sourceType;

      // 解决 Attempt to present <> on <MyInfoTableViewController> which is already presenting (null).
      [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
      
      [self presentViewController:imagePickerController animated:YES completion:^{ }];
   }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
   [picker dismissViewControllerAnimated:YES completion:^{
      
   }];
   
   UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
   self.HeadImage.image = image;
}

@end
