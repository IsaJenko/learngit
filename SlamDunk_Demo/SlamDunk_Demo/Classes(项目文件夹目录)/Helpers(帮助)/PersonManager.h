//
//  PersonManager.h
//  SlamDunk_Demo
//
//  Created by jinke on 15/10/26.
//  Copyright © 2015年 IsaJenko.github.io. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonManager : NSObject

+ (instancetype) sharedPersonManager;
- (void) openDB;
- (void) closeDB;
- (void) createTable;
- (void) deleteAllPerson;
- (void) insertPerson:(Person *)person;
- (NSArray *) selectedAllPersons;
// 注册方法
- (NSInteger) personRegisterWithPerson:(Person *)person;
// 登录方法
- (NSInteger) personLoginWithPerson:(Person *)person;

@end
