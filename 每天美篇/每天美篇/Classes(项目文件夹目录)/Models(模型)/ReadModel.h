//
//  ReadModel.h
//  每天美篇
//
//  Created by lanou3g on 15/10/21.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReadModel : NSObject
@property (nonatomic, assign) NSInteger number;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *extra;
@property (nonatomic, assign) NSString *status;
@property (nonatomic, strong) NSString *title;
@end
