//
//  InfoViewController.m
//  MVCbook
//
//  Created by jinke on 15/9/12.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "InfoViewController.h"
#import "InfoView.h"
@interface InfoViewController ()
@property (nonatomic,strong) InfoView *infoView;
@end

@implementation InfoViewController
- (void)loadView
{
    self.infoView = [InfoView alloc];
    self.infoView.person = _person;
    self.infoView = [self.infoView initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.infoView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.infoView.nameLabel.text = self.person.PersonName;
//    self.infoView.numberLabel.text = self.person.PhoneNumber;
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
