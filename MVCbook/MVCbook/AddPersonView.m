//
//  AddPersonView.m
//  MVCbook
//
//  Created by jinke on 15/9/12.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "AddPersonView.h"
#import "Person.h"
@implementation AddPersonView

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
    UITextField *personNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(30, 100, self.frame.size.width - 60, 40)];
    personNameTextField.borderStyle = UITextBorderStyleRoundedRect;
    personNameTextField.placeholder = @"请输入姓名";
    personNameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self addSubview:personNameTextField];
    _nameTextField = personNameTextField;

    
    
    UITextField *personNumberTextField = [[UITextField alloc] initWithFrame:CGRectMake(30, 200, self.frame.size.width - 60, 40)];
    personNumberTextField.borderStyle = UITextBorderStyleRoundedRect;
    personNumberTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    personNumberTextField.placeholder = @"请输入电话号码";
    personNumberTextField.keyboardType = UIKeyboardTypeNumberPad;
        [self addSubview:personNumberTextField];
    _numberTextField = personNumberTextField;
    
    
   }











@end
