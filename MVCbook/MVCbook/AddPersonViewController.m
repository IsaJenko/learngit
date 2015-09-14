//
//  AddPersonViewController.m
//  MVCbook
//
//  Created by jinke on 15/9/12.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "AddPersonViewController.h"
#import "AddPersonView.h"
#import "Person.h"
@interface AddPersonViewController () <UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,strong) AddPersonView *addPersonView;

@end

@implementation AddPersonViewController
- (void)loadView
{
    self.addPersonView = [[AddPersonView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.addPersonView;
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加保存联系人按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(savePerson:)];
    
    // 添加 添加照片按钮
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
//    button.frame = CGRectMake(50, 300, 100, 100);
//    button.layer.cornerRadius = 50;
//    button.layer.borderWidth = 1;
//    [button setTitle:@"添加照片" forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(addPhoto:) forControlEvents:UIControlEventTouchUpInside];
//    //    button.backgroundColor = [UIColor blackColor];
//    button.layer.masksToBounds = YES;
//    _button = button;
//    [self.view addSubview:_button];
    

}
// 添加按钮的点击事件
//- (void) addPhoto:(UIButton *)sender
//{
//    UIImagePickerController *imagePickerC = [UIImagePickerController new];
//    imagePickerC.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
//    imagePickerC.delegate = self;
//    imagePickerC.allowsEditing = NO;
//    [self presentViewController:imagePickerC animated:YES completion:nil];
//}
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
//{
//    NSLog(@"%@",info);
//    [_button setImage: [info valueForKey:@"UIImagePickerControllerOriginalImage" ] forState:UIControlStateNormal ];
//    [picker dismissViewControllerAnimated:YES completion:nil];
//}

- (void) savePerson:(UIBarButtonItem *) sender
{
    Person *person = [Person personWithPersonName:self.addPersonView.nameTextField.text PhoneNumber:self.addPersonView.numberTextField.text];
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(getPerson:)]) {
        [self.delegate getPerson:person];
    }
    [self.navigationController popViewControllerAnimated:YES];
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
