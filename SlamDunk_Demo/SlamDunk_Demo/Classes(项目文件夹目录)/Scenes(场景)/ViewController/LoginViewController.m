//
//  LoginViewController.m
//  SlamDunk_Demo
//
//  Created by jinke on 15/10/25.
//  Copyright © 2015年 IsaJenko.github.io. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;

@end

@implementation LoginViewController
- (IBAction)loginAction:(UIButton *)sender {
    
    CommunityViewController *communityVC = [self.storyboard instantiateViewControllerWithIdentifier:@"centerTBC"];
    Person *person = [Person new];
    person.name = self.nameTextField.text;
    person.pwd = self.pwdTextField.text;
     NSInteger flag = [[PersonManager sharedPersonManager] personLoginWithPerson:person];
    if (flag == 0) {
        UIAlertController *alertController = nil;
        
        alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"用户名或密码输入错误，请重新输入" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action4 = [UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"取消");
        }];
        
        [alertController addAction:action4];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }else
    {
        [self showDetailViewController:communityVC sender:nil];
    }
}
- (IBAction)toRegisterAction:(UIButton *)sender {
    
    RegisterViewController *registerViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"registerVC"];
    [self showViewController:registerViewController sender:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
