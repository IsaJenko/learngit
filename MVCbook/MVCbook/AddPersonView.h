//
//  AddPersonView.h
//  MVCbook
//
//  Created by jinke on 15/9/12.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Person;
@interface AddPersonView : UIView
@property (nonatomic,strong) Person *addPerson;
@property (nonatomic,strong) UITextField *nameTextField;
@property (nonatomic,strong) UITextField *numberTextField;
@end
