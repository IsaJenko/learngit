//
//  Person.m
//  MVCbook
//
//  Created by jinke on 15/9/12.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "Person.h"

@implementation Person
- (instancetype) initWithPersonName:(NSString *) personName
                        PhoneNumber:(NSString *) phoneNumber{
    if (self = [super init]) {
        _PersonName = personName;
        _PhoneNumber = phoneNumber;
    }
    return self;
}
+ (instancetype) personWithPersonName:(NSString *) personName
                          PhoneNumber:(NSString *) phoneNumber{
    Person *person = [[Person alloc] initWithPersonName:personName PhoneNumber:phoneNumber];
    return person;
}
- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ %@", _PersonName,_PhoneNumber];
}
@end
