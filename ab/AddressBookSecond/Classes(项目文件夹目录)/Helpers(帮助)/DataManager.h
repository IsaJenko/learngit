//
//  DataManager.h
//  AddressBookSecond
//
//  Created by jinke on 15/9/15.
//  Copyright (c) 2015年 . All rights reserved.
//

#import <Foundation/Foundation.h>
@class Contact;
@interface DataManager : NSObject

// 声明创建单例对象的方法
+ (instancetype) sharedDataManager;

#pragma mark - 声明方法

// 增
- (void) addContact:(Contact *)contact;

// 删
- (void) deleteContactWithIndexPath:(NSIndexPath *)indexPath;

// 改
- (void) changeContactAtIndexPath:(NSIndexPath *)indexPath withContact:(Contact *)contact;

// 查询全部
- (NSArray *) findAllContact;

// 根据条件查询
- (Contact *) findContactWithIndexPath:(NSIndexPath *)indexPath;

// 移动数据
- (void) moveDataFromIndexPath:(NSIndexPath *)fromIndexPath
                   ToIndexPath:(NSIndexPath *)toIndexPath;









@end
