//
//  AddContactViewController.m
//  AddressBookSecond
//
//  Created by jinke on 15/9/15.
//  Copyright (c) 2015年 . All rights reserved.
//

#import "AddContactViewController.h"
#import "AddContactView.h"
#import "Contact.h"
#import "DataManager.h"
@interface AddContactViewController ()
@property (nonatomic,strong) AddContactView *addContactView;
@end

@implementation AddContactViewController
- (void)loadView
{
    self.addContactView = [[AddContactView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.addContactView.backgroundColor = [UIColor whiteColor];
    self.view = self.addContactView;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelAction:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(saveAction:)];
    
}
- (void) saveAction:(UIBarButtonItem *)sender
{
    // 获取输入内容
    NSString *name = self.addContactView.nameTextField.text;
    NSString *phone = self.addContactView.phoneTextField.text;
    NSString *introduce = self.addContactView.introduceTextField.text;
    // 拼成模型
    Contact *contact = [Contact contactWithName:name phone:phone introduce:introduce];
    // 保存数据
    [[DataManager sharedDataManager] addContact:contact];
    // 取消页面
    [self dismissViewControllerAnimated:YES completion:nil];
    
    NSLog(@"保存");
}
- (void) cancelAction:(UIBarButtonItem *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
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
