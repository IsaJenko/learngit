//
//  Contact.m
//  AddressBookSecond
//
//  Created by jinke on 15/9/15.
//  Copyright (c) 2015年 . All rights reserved.
//

#import "Contact.h"

@implementation Contact
- (instancetype) initWithName:(NSString *)name
                        phone:(NSString *)phone
                    introduce:(NSString *)introduce
{
    if (self = [super init]) {
        _name = name;
        _phone = phone;
        _introduce = introduce;
    }
    return self;
}
+ (instancetype) contactWithName:(NSString *)name
                           phone:(NSString *)phone
                       introduce:(NSString *)introduce
{
    return [[Contact alloc] initWithName:name phone:phone introduce:introduce];
}
- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ %@ %@", _name,_phone,_introduce];
}
@end
