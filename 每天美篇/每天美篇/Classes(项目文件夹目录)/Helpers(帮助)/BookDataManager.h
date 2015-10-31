//
//  BookDataManager.h
//  每天美篇
//
//  Created by lanou3g on 15/10/21.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookDataManager : NSObject

+ (instancetype)shareManager;
- (void)open;
- (void)close;
- (void)createTable;
- (void)insetReadModel:(ReadModel *)readModel;
- (NSArray *)selectAllReadModel;
- (void)deleteWithReadModel:(NSInteger)number;
- (ReadModel *)selectWithTitle:(NSInteger)number;
- (void)deleteWithtitle:(NSString *)title;
@end
