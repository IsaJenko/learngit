//
//  LyricHelper.h
//  PlayerByCoding
//
//  Created by LakesMac on 15/10/12.
//  Copyright © 2015年 Lake. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LyricHelper : NSObject

+ (instancetype)sharedLyrcHelper;

- (void)lyrcString:(NSString *)string;

- (NSInteger)numberOfLiens;
- (NSString *)stringOfLineAtIndex:(NSInteger)index;
- (NSInteger)indexOfTime:(NSTimeInterval)second;

@end
