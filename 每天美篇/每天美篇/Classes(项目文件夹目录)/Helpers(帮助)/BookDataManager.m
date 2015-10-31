//
//  BookDataManager.m
//  每天美篇
//
//  Created by lanou3g on 15/10/21.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "BookDataManager.h"

@interface BookDataManager ()
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UIAlertController *alert;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation BookDataManager
+ (instancetype)shareManager
{
    static BookDataManager *manager = nil;
    if (!manager) {
        manager = [BookDataManager new];
    }
    return manager;
}
static sqlite3 *db = nil;
- (void)open
{
    if (db != nil) {
        return;
    }
    NSString *path = NSHomeDirectory();
    NSLog(@"%@",path);
    path = [path stringByAppendingPathComponent:@"ReadModel3.sqlite"];
    int result = sqlite3_open(path.UTF8String, &db);
    if (result == SQLITE_OK) {
        NSLog(@"打开成功");
    }else
    {
        NSLog(@"打开失败,%d",result);
    }
}
- (void)close
{
    int result = sqlite3_close(db);
    if (result == SQLITE_OK) {
        db = nil;
        NSLog(@"关闭成功");
    }
    else
    {
        NSLog(@"关闭失败,%d",result);
    }
}
- (void)createTable
{
    NSString *sqlString = @"CREATE TABLE IF NOT EXISTS 'readModel' ('number' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 'author' TEXT NOT NULL, 'content' TEXT NOT NULL, 'date' TEXT NOT NULL, 'extra' TEXT, 'status' INTEGER NOT NULL, 'title' TEXT NOT NULL)";
    char *error = nil;
    sqlite3_exec(db, sqlString.UTF8String, nil, nil, &error);
    if (!error) {
        NSLog(@"创建成功");
    }else
    {
        NSLog(@"创建失败");
    }
}
- (void)insetReadModel:(ReadModel *)readModel
{
    NSString *sqlString = [NSString stringWithFormat:@"insert into 'readModel' (author,content,date,extra,status,title) values ('%@','%@','%@','%@','%@','%@')",readModel.author,readModel.content,readModel.date,readModel.extra,readModel.status,readModel.title];
    char *error = nil;
    sqlite3_exec(db, sqlString.UTF8String, nil, nil, &error);
    if (!error) {
        NSLog(@"插入成功");
    }else
    {
        NSLog(@"插入失败");
    }
    
}


- (NSArray *)selectAllReadModel
{
   
    sqlite3_stmt *stmt = nil;
    NSString *sqlString = @"select * from 'readModel'";
    int result = sqlite3_prepare(db, sqlString.UTF8String, -1, &stmt, nil);
    if (result == SQLITE_OK) {
        self.dataArray = [[NSMutableArray alloc] initWithCapacity:20];
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            ReadModel *readModel = [ReadModel new];
            readModel.number = sqlite3_column_int(stmt, 0);
            readModel.author = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];
            readModel.content = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 2)];
            readModel.date = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 3)];
            readModel.extra = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 4)];
            readModel.status =[NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 5)];
            readModel.title = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 6)];
            [self.dataArray addObject:readModel];
        }
    }else{
        NSLog(@"查询失败，失败操作数为%d",result);
    }
    sqlite3_finalize(stmt);
    return _dataArray;
}
- (void)deleteWithReadModel:(NSInteger)number
{
    NSString *sqlString = [NSString stringWithFormat:@"delete from 'readModel' where number = %ld",(long)number];
    char *error = nil;
    sqlite3_exec(db, sqlString.UTF8String, nil, nil, &error);
    if (!error) {
        NSLog(@"删除成功");

    }else
    {
        NSLog(@"删除失败");
    }
}
- (void)deleteWithtitle:(NSString *)title
{
    NSString *sqlString = [NSString stringWithFormat:@"delete from 'readModel'  where title = %@",title];

    char *error = nil;
    sqlite3_exec(db, sqlString.UTF8String, nil, nil, &error);
    if (!error) {
        NSLog(@"删除成功");
    }else
    {
        NSLog(@"删除失败");
    }

}
- (ReadModel *)selectWithTitle:(NSInteger)number
{
    ReadModel *readModel = [ReadModel new];
    NSString *sqlString = [NSString stringWithFormat:@"select * from 'readModel' where number = '%ld'",(long)number];
    static sqlite3_stmt *stmt = nil;
    int result = sqlite3_prepare(db, sqlString.UTF8String, -1, &stmt, nil);
    if (result == SQLITE_OK) {
        
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            ReadModel *readModel = [ReadModel new];
            readModel.number = sqlite3_column_int(stmt, 0);
            readModel.author = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];
            readModel.content = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 2)];
            readModel.date = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 3)];
            readModel.extra = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 4)];
            readModel.status = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 5)];
            readModel.title = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 6)];
        }
    }else{
        NSLog(@"查询失败，失败操作数为%d",result);
    }

    return readModel;
    
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
