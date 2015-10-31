//
//  RegisterViewController.m
//  SlamDunk_Demo
//
//  Created by jinke on 15/10/25.
//  Copyright © 2015年 IsaJenko.github.io. All rights reserved.
//

#import "RegisterViewController.h"


@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;

@end

@implementation RegisterViewController

- (IBAction)toLoginVC:(UIButton *)sender {
    
    Person *person = [Person new];
    person.name = self.nameTextField.text;
    person.pwd = self.pwdTextField.text;

//    [[PersonManager sharedPersonManager] openDB];
//    [[PersonManager sharedPersonManager] createTable];
//    [[PersonManager sharedPersonManager] deleteAllPerson];
//    [[PersonManager sharedPersonManager] insertPerson:person];
//    NSArray *array = [[PersonManager sharedPersonManager] selectedAllPersons];
//    [[PersonManager sharedPersonManager] closeDB];
//    NSLog(@"%@",array);
    
     NSInteger flag = [[PersonManager sharedPersonManager] personRegisterWithPerson:person];
    if (flag == 1) {
        UIAlertController *alertController = nil;
        
        alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"用户名已经被注册，请重新输入" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action4 = [UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"取消");
        }];
        
        [alertController addAction:action4];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }else
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

@end
