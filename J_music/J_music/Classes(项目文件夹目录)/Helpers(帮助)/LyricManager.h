//
//  LyricManager.h
//  J_music
//
//  Created by jinke on 15/10/13.
//  Copyright © 2015年 IsaJenko.github.io. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LyricManager : NSObject

@property (nonatomic,strong) NSArray *allLyricData;
+ (instancetype)sharedLyricManager;
// 加载歌曲，根据字符串
- (void) loadLyricWithString:(NSString *)lyricStr;
- (NSString *)lyricStringWithIndexPath:(NSIndexPath *)indexPath;
// 根据时间，获取下标
- (NSInteger)lyricIndexWithTime:(NSTimeInterval)time;

@end
