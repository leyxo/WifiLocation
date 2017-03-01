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
   
   webView.delegate = self;
   NSURL * url = [NSURL URLWithString:@"http://leyxo.site"];
   NSURLRequest * request = [NSURLRequest requestWithURL:url];
   [webView loadRequest:request];
//   NSLog(@"Loaded");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
//   NSLog(@"%@", [webView stringByEvaluatingJavaScriptFromString:@"document.body.innerHTML"]);
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
//   NSLog(@"Web view load error. Info: %@", [error description]);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
