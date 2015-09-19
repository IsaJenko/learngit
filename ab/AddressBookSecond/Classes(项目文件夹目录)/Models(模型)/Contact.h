//
//  Contact.h
//  AddressBookSecond
//
//  Created by jinke on 15/9/15.
//  Copyright (c) 2015年 . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Contact : NSObject
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *phone;
@property (nonatomic,copy) NSString *introduce;
- (instancetype) initWithName:(NSString *)name
                        phone:(NSString *)phone
                    introduce:(NSString *)introduce;
+ (instancetype) contactWithName:(NSString *)name
                        phone:(NSString *)phone
                    introduce:(NSString *)introduce;
@end
