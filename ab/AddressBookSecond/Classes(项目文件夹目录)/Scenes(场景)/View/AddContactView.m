//
//  AddContactView.m
//  AddressBookSecond
//
//  Created by jinke on 15/9/15.
//  Copyright (c) 2015年 . All rights reserved.
//

#import "AddContactView.h"

@implementation AddContactView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addAllViews];
    }
    return self;
}
- (void) addAllViews
{
    
    // 姓名
    self.nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 100, self.bounds.size.width - 40, 35)];
    _nameTextField.placeholder = @"请输入姓名";
    [self addSubview:_nameTextField];
    // 手机号
    self.phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 150, self.bounds.size.width - 40, 35)];
    _phoneTextField.placeholder = @"请输入手机号";
    _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self addSubview:_phoneTextField];
    // 自我介绍
    self.introduceTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 200, self.bounds.size.width - 40, 35)];
    _introduceTextField.placeholder = @"请输入个人简介";
    [self addSubview:_introduceTextField];

    
    // 利用forin循环给textField给属性
    for (UITextField *textField in self.subviews) {
        textField.borderStyle = UITextBorderStyleLine;
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.textAlignment = NSTextAlignmentCenter;
    }
    
    
    
    
    
    
}
@end
