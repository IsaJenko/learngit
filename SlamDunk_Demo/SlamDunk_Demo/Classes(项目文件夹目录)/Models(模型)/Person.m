//
//  Person.m
//  SlamDunk_Demo
//
//  Created by jinke on 15/10/26.
//  Copyright © 2015年 IsaJenko.github.io. All rights reserved.
//

#import "Person.h"

@implementation Person
- (instancetype) initWithDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

@end
