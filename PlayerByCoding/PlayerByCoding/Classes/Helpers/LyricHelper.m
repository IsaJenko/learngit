//
//  LyricHelper.m
//  PlayerByCoding
//
//  Created by LakesMac on 15/10/12.
//  Copyright © 2015年 Lake. All rights reserved.
//

#import "LyricHelper.h"

@interface LyricHelper (){
    NSString *_stringCopy;
    NSString *_lrcString;
    NSString *_timeStringCopy;
    BOOL      _flag;
}
@property (nonatomic,strong) NSMutableArray *allArray;
//@property (nonatomic,strong) NSMutableArray *allArray;
@property (nonatomic,strong) NSMutableArray *allTimeArray;
@property (nonatomic,strong) NSMutableArray *allStringArray;


@end

@implementation LyricHelper

+ (instancetype)sharedLyrcHelper{
    static LyricHelper *helper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [self new];
    });
    return helper;
}

- (void)lyrcString:(NSString *)string{
    _allStringArray = nil;
    _allTimeArray = nil;
    NSArray *array = [string componentsSeparatedByString:@"["];
    for (NSString *string in array) {
        NSArray *time_lryicArray = [string componentsSeparatedByString:@"]"];
        
        if (time_lryicArray.count == 2) {
            [self.allTimeArray addObject:time_lryicArray[0]];
            [self.allStringArray addObject:time_lryicArray[1]];
        }
    }
    
}

- (NSInteger)numberOfLiens{
    if (_allStringArray) {
        return _allStringArray.count;
    }
    return 0;
}

- (NSString *)stringOfLineAtIndex:(NSInteger)index{
    return self.allStringArray[index];
}

- (NSInteger)indexOfTime:(NSTimeInterval)second{
    NSInteger min = second / 60;
    NSInteger sec = (NSInteger)second % 60;
    
    NSString *secString = [NSString new];
    NSString *minString = [NSString new];
    if (min < 10) {
        minString = [NSString stringWithFormat:@"0%ld",min];
    }else{
        minString = [NSString stringWithFormat:@"%ld",min];
    }
    if (sec < 10) {
        secString = [NSString stringWithFormat:@"0%ld",sec];
    }else{
        secString = [NSString stringWithFormat:@"%ld",sec];
    }
    NSString *time = [NSString stringWithFormat:@"%@:%@",minString,secString];
    NSInteger index = 0;
    for (NSString *string in self.allTimeArray) {
        if ([string hasPrefix:time]) {
            return index;
        }
        index ++;
    }
    return -1;
}

- (NSMutableArray *)allTimeArray{
    if (!_allTimeArray) {
        _allTimeArray = [NSMutableArray array];
    }
    return _allTimeArray;
}

- (NSMutableArray *)allStringArray{
    if (!_allStringArray) {
        _allStringArray = [NSMutableArray array];
    }
    return _allStringArray;
}
@end
