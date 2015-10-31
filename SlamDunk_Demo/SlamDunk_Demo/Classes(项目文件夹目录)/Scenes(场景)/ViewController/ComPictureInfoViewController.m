//
//  ComPictureInfoViewController.m
//  SlamDunk_Demo
//
//  Created by jinke on 15/10/24.
//  Copyright © 2015年 IsaJenko.github.io. All rights reserved.
//

#import "ComPictureInfoViewController.h"

@interface ComPictureInfoViewController ()

@end

@implementation ComPictureInfoViewController

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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
