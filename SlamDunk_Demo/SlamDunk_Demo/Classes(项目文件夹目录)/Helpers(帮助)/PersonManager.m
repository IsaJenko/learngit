//
//  PersonManager.m
//  SlamDunk_Demo
//
//  Created by jinke on 15/10/26.
//  Copyright © 2015年 IsaJenko.github.io. All rights reserved.
//

#import "PersonManager.h"

@implementation PersonManager

+ (instancetype) sharedPersonManager
{
    static PersonManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [PersonManager new];
    });
    return manager;
}
static sqlite3 *db = nil;
- (void) openDB
{
    if (db) {
        return;
    }
    NSString *path = NSHomeDirectory();
    path = [path stringByAppendingPathComponent:@"person.sqlite"];
    int result = sqlite3_open([path UTF8String], &db);
    if (result == SQLITE_OK) {
        NSLog(@"打开成功");
    }else
    {
        NSLog(@"打开失败");
    }
}
- (void) closeDB
{
    int result = sqlite3_close(db);
    if (result == SQLITE_OK) {
        db = nil;
        NSLog(@"关闭成功");
    }else
    {
        NSLog(@"关闭失败");
    }
}
- (void) createTable
{
    NSString *createString = @"CREATE TABLE IF NOT EXISTS 'person' ('number' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 'name' TEXT NOT NULL, 'pwd' INTEGER NOT NULL)";
    int result = sqlite3_exec(db, createString.UTF8String, NULL, NULL, NULL);
    if (result == SQLITE_OK) {
        NSLog(@"创建表成功");
    }else
    {
        NSLog(@"创建表失败");
    }
}
- (void) deleteAllPerson
{
    NSString *deleteString = [NSString stringWithFormat:@"DELETE FROM person"];
    int result = sqlite3_exec(db, deleteString.UTF8String, NULL, NULL, NULL);
    if (result == SQLITE_OK) {
        NSLog(@"删除 成功");
    }else{
        NSLog(@"删除 失败");
    }
}
- (void) insertPerson:(Person *)person
{
    NSString *insertString = [NSString stringWithFormat:@"INSERT INTO person (name,pwd) VALUES ('%@','%@')",person.name,person.pwd];
    int result = sqlite3_exec(db, insertString.UTF8String, NULL, NULL, NULL);
    if (result == SQLITE_OK) {
        NSLog(@"添加成功");
    }else
    {
        NSLog(@"添加失败");
    }
    
}
- (NSArray *) selectedAllPersons
{
    // 准备数组
    NSMutableArray *array = nil;
    // 准备伴随指针
    sqlite3_stmt *stmt = nil;
    // 准备SQL语句
    NSString *selectString = @"SELECT * FROM person";
    // 准备执行
    int result = sqlite3_prepare_v2(db, selectString.UTF8String, -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        array = [[NSMutableArray alloc] initWithCapacity:20];
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            // number,name,age,gender
            Person *person = [Person new];
            person.number = sqlite3_column_int(stmt, 0);
            // 根据字段查询的字符串需要强转为const char *类型后，再转化为OC字符串
            person.name = [NSString stringWithUTF8String:(const char *) sqlite3_column_text(stmt, 1)];
            
            person.pwd = [NSString stringWithUTF8String:(const char *) sqlite3_column_text(stmt, 2)];
            
            [array addObject:person];
        }
        NSLog(@"查询 成功");
    }else{
        NSLog(@"查询 失败");
    }
    
    // 释放伴随指针
    sqlite3_finalize(stmt);
    return array;

}
// 注册方法
- (NSInteger) personRegisterWithPerson:(Person *)person
{
    int flag = 0;
    [[PersonManager sharedPersonManager] openDB];
    [[PersonManager sharedPersonManager] createTable];
    NSArray *array = [[PersonManager sharedPersonManager] selectedAllPersons];
    for (Person *_person in array) {
        if ([person.name isEqualToString:_person.name]) {
            NSLog(@"用户名已经被注册，请重新输入");
            flag = 1;
        }else if (flag == 0)
        {
            [[PersonManager sharedPersonManager] insertPerson:person];
            NSLog(@"注册成功");
        }
    }
    [[PersonManager sharedPersonManager] closeDB];
    return flag;
}
// 登录方法
- (NSInteger) personLoginWithPerson:(Person *)person
{
    int flag = 0;
    [[PersonManager sharedPersonManager] openDB];
    [[PersonManager sharedPersonManager] createTable];
    NSArray *array = [[PersonManager sharedPersonManager] selectedAllPersons];
    for (Person *_person in array) {
        if ([person.name isEqualToString:_person.name] && [person.pwd isEqualToString:_person.pwd]) {
            NSLog(@"登录成功");
            flag = 1;
        }else if (flag == 0)
        {
            NSLog(@"用户名或密码输入错误，请重新输入");
        }
    }
    [[PersonManager sharedPersonManager] closeDB];
    return flag;
}
@end
