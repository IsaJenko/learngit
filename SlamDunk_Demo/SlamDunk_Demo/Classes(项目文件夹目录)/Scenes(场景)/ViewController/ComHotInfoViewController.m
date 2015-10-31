//
//  ComHotInfoViewController.m
//  SlamDunk_Demo
//
//  Created by jinke on 15/10/26.
//  Copyright © 2015年 IsaJenko.github.io. All rights reserved.
//

#import "ComHotInfoViewController.h"

@interface ComHotInfoViewController ()

@end

@implementation ComHotInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height)];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.communityGM.share_url]]];
    webView.userInteractionEnabled = YES;
    [self.view addSubview:webView];
    
    UILabel *cancelLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, self.view.frame.size.width, 30)];
    cancelLabel.text = @"点击我返回";
    cancelLabel.textAlignment = NSTextAlignmentCenter;
    cancelLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:cancelLabel];

}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
