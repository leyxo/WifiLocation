//
//  HelpViewController.m
//  WifiLocation
//
//  Created by LEY's MacBook on 17/03/01.
//  Copyright © 2017年 LEY's MacBook. All rights reserved.
//

#import "HelpViewController.h"

@implementation HelpViewController
@synthesize webView;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
   
   webView.delegate = self;
   NSURL * url = [NSURL URLWithString:@"http://leyxo.site"];
   NSURLRequest * request = [NSURLRequest requestWithURL:url];
   [webView loadRequest:request];

//   // 设置内容Inset
//   webView.scrollView.contentInset = UIEdgeInsetsMake(44+20, 0, 44, 0);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
}

- (void)viewWillDisappear:(BOOL)animated {
   // 页面消失时取消活动指示器
   [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
   [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
   [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
   
   // 屏蔽连接
//   [self.webView stringByEvaluatingJavaScriptFromString:@"\"$(document).ready(function(){$(\"#re_verify_code a\").click(function(event){event.preventDefault();});});"];
   
   // 去除长按后出现的文本选取框
   [self.webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
   [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
   
   UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"无法连接网络" message:@"麻烦爸爸开一下wifi或者移动数据什么的，谢谢~" preferredStyle:UIAlertControllerStyleAlert];
   
   UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"那就不看了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) { [self.navigationController popViewControllerAnimated:YES]; }];
   UIAlertAction* settingAction = [UIAlertAction actionWithTitle:@"滚去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) { [self openURL:UIApplicationOpenSettingsURLString]; }];

   //@"Prefs:root=MOBILE_DATA_SETTINGS_ID" 在iOS 10已经被禁用
   
   [alert addAction:settingAction];
   [alert addAction:defaultAction];
   [self presentViewController:alert animated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)Share:(id)sender {
   UIActionSheet * sheet = [[UIActionSheet alloc] initWithTitle:@"用其他程序打开帮助文档页面"  delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"在 Safari 中打开", nil];
   [sheet showInView:self.view];
}

// 实现<UIActionSheetDelegate>的actionSHeet协议
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
   if (buttonIndex == 0) {
      [self openURL:HELP_PAGE_URL];
   }
   else if (buttonIndex == 1) {
   }
}

- (void)openURL:(NSString *)urlStr{
   NSURL * url = [NSURL URLWithString:urlStr];
   [[UIApplication sharedApplication] openURL:url];
}
@end
