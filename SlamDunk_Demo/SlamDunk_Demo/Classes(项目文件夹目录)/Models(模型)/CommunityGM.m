//
//  CommunityGM.m
//  SlamDunk_Demo
//
//  Created by jinke on 15/10/23.
//  Copyright © 2015年 IsaJenko.github.io. All rights reserved.
//

#import "CommunityGM.h"

@implementation CommunityGM

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        _ID = value;
    }
}

@end
