//
//  Person.h
//  SlamDunk_Demo
//
//  Created by jinke on 15/10/26.
//  Copyright © 2015年 IsaJenko.github.io. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *pwd;
@property (nonatomic,assign) NSInteger number;
- (instancetype) initWithDictionary:(NSDictionary *)dict;
@end
