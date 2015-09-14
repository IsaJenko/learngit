//
//  AddPersonViewController.h
//  MVCbook
//
//  Created by jinke on 15/9/12.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Person;
// 设置协议并写方法
@protocol AddPersonViewControllerDelegate <NSObject>

- (void) getPerson:(Person *)person;


@end
@interface AddPersonViewController : UIViewController

// 设置代理属性
@property (nonatomic,assign) id <AddPersonViewControllerDelegate> delegate;
//@property (nonatomic,strong) UIButton *button;

@end
