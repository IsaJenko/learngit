//
//  LyricManager.m
//  J_music
//
//  Created by jinke on 15/10/13.
//  Copyright © 2015年 IsaJenko.github.io. All rights reserved.
//

#import "LyricManager.h"

@interface LyricManager ()
{
    NSInteger _index;
}
@property (nonatomic,strong) NSMutableArray *allDataArray;
@end

@implementation LyricManager
+ (instancetype)sharedLyricManager
{
    static LyricManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [LyricManager new];
    });
    return manager;
}
- (void)loadLyricWithString:(NSString *)lyricStr
{
    [self.allDataArray removeAllObjects];
    NSArray *array = [lyricStr componentsSeparatedByString:@"\n"];
    for (NSString *itemStr in array) {
        NSArray *timeAndStr = [itemStr componentsSeparatedByString:@"]"];
        if ([timeAndStr.firstObject length] == 0) {
            continue;
        }
        // 获取时间
        NSString *timeStr = [timeAndStr.firstObject substringFromIndex:1];
        NSArray *timeArray = [timeStr componentsSeparatedByString:@":"];
        NSString *minute = timeArray.firstObject;
        NSString *second = timeArray.lastObject;
        NSTimeInterval time = minute.floatValue * 60 + second.floatValue;
        // 获取内容
        NSString *string = timeAndStr.lastObject;
        Lyric *lyric = [Lyric lyricWithTime:time string:string];
        [self.allDataArray addObject:lyric];
    }
}
- (NSArray *)allLyricData
{
    return [self.allDataArray copy];
}
// 根据时间获取下标
- (NSInteger)lyricIndexWithTime:(NSTimeInterval)time
{
    for (int i = 0; i < self.allDataArray.count; i ++) {
        Lyric *lyric = self.allDataArray[i];
        if (time < lyric.time) {
            _index = (i - 1 > 0) ? (i - 1) : 0;
            break;
        }
    }
    return _index;
}
- (NSString *)lyricStringWithIndexPath:(NSIndexPath *)indexPath
{
    Lyric *lyric = self.allDataArray[indexPath.row];
    return lyric.string;
}
- (NSMutableArray *)allDataArray
{
    if (!_allDataArray) {
        self.allDataArray = [NSMutableArray array];
    }
    return _allDataArray;
}
@end
