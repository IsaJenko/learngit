//
//  DataManager.m
//  AddressBookSecond
//
//  Created by jinke on 15/9/15.
//  Copyright (c) 2015年 . All rights reserved.
//

#import "DataManager.h"
#import <UIKit/UIKit.h>
@interface DataManager()

@property (nonatomic,strong) NSMutableArray *allDataArray;

@end
@implementation DataManager

+ (instancetype) sharedDataManager
{
    // 声明静态变量，设置为空
    static DataManager *dataManager = nil;
    // 判断指针是否存在
    if (dataManager == nil) {
        // 不存在则创建
        dataManager = [[DataManager alloc] init];
    }
    // 返回对象
    return dataManager;
    
}




// 增
- (void) addContact:(Contact *)contact
{
    [self.allDataArray addObject:contact];
}

// 删
- (void) deleteContactWithIndexPath:(NSIndexPath *)indexPath
{
    [self.allDataArray removeObjectAtIndex:indexPath.row];
}

// 改
- (void) changeContactAtIndexPath:(NSIndexPath *)indexPath withContact:(Contact *)contact
{
    self.allDataArray[indexPath.row] = contact;
}

// 查询全部
- (NSArray *) findAllContact
{
    return [self.allDataArray copy];
}

// 根据条件查询
- (Contact *) findContactWithIndexPath:(NSIndexPath *)indexPath
{
    return self.allDataArray[indexPath.row];
}

// 移动数据
- (void) moveDataFromIndexPath:(NSIndexPath *)fromIndexPath
                   ToIndexPath:(NSIndexPath *)toIndexPath
{
    Contact *contact = self.allDataArray[fromIndexPath.row];
    [self.allDataArray removeObject:contact];
    [self.allDataArray insertObject:contact atIndex:toIndexPath.row];
}
- (NSMutableArray *)allDataArray
{
    if (!_allDataArray) {
        self.allDataArray = [NSMutableArray array];
    }
    return _allDataArray;
}
@end
