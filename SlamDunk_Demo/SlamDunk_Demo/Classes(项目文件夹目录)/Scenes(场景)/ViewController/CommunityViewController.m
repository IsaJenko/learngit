//
//  CommunityViewController.m
//  SlamDunk_Demo
//
//  Created by jinke on 15/10/23.
//  Copyright © 2015年 IsaJenko.github.io. All rights reserved.
//

#import "CommunityViewController.h"

@interface CommunityViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *mySegmentedControl;

@property (nonatomic,strong) ComTopicTableViewController *comTopicTVC;
@property (nonatomic,strong) ComHotViewController *comHotVC;
@property (nonatomic,strong) ComPictureTableViewController *comPictureTVC;

@end

@implementation CommunityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.comTopicTVC = [ComTopicTableViewController new];
    [self addChildViewController:self.comTopicTVC];
    self.comHotVC = [ComHotViewController new];
    [self addChildViewController:self.comHotVC];
    self.comPictureTVC = [ComPictureTableViewController new];
    [self addChildViewController:self.comPictureTVC];
    
    [self.view addSubview:_comTopicTVC.view];
    
    self.mySegmentedControl.selectedSegmentIndex = 0;
    [self.mySegmentedControl addTarget:self action:@selector(segmentedControlAction:) forControlEvents:UIControlEventValueChanged];

}
- (void) segmentedControlAction:(UISegmentedControl *) sender
{
    [self.view.subviews.firstObject removeFromSuperview];
    UIViewController *insertVC = self.childViewControllers[sender.selectedSegmentIndex];
    [self.view addSubview:insertVC.view];
    self.tabBarController.tabBar.alpha = 1;
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
