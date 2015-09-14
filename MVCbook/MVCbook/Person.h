//
//  Person.h
//  MVCbook
//
//  Created by jinke on 15/9/12.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
#pragma mark - 声明属性
@property (nonatomic,copy) NSString *PersonName;
@property (nonatomic,copy) NSString *PhoneNumber;

- (instancetype) initWithPersonName:(NSString *) personName
                        PhoneNumber:(NSString *) phoneNumber;
+ (instancetype) personWithPersonName:(NSString *) personName
                          PhoneNumber:(NSString *) phoneNumber;
@end
