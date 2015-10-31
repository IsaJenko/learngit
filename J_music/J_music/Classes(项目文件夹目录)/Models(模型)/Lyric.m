//
//  Lyric.m
//  J_music
//
//  Created by jinke on 15/10/13.
//  Copyright © 2015年 IsaJenko.github.io. All rights reserved.
//

#import "Lyric.h"

@implementation Lyric
- (instancetype)initWithTime:(NSTimeInterval)time
                      string:(NSString *)string
{
    if (self = [super init]) {
        _time = time;
        _string = [string copy];
    }
    return self;
}
+ (instancetype)lyricWithTime:(NSTimeInterval)time
                       string:(NSString *)string
{
    return [[Lyric alloc] initWithTime:time string:string];
}
@end
