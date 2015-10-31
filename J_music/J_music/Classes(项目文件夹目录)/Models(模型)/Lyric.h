//
//  Lyric.h
//  J_music
//
//  Created by jinke on 15/10/13.
//  Copyright © 2015年 IsaJenko.github.io. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Lyric : NSObject

@property (nonatomic,assign) NSTimeInterval time;
@property (nonatomic,copy) NSString *string;

- (instancetype)initWithTime:(NSTimeInterval)time
                      string:(NSString *)string;
+ (instancetype)lyricWithTime:(NSTimeInterval)time
                       string:(NSString *)string;
@end
