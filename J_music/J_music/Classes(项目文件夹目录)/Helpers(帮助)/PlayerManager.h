//
//  PlayerManager.h
//  J_music
//
//  Created by jinke on 15/10/13.
//  Copyright © 2015年 IsaJenko.github.io. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PlayerManagerDelegate <NSObject>

// 播放过程中，参数是秒数
- (void) playingWithTime:(NSTimeInterval)time;
// 一首歌播放结束
- (void) didStop;

@end

@interface PlayerManager : NSObject

@property (nonatomic,assign) id <PlayerManagerDelegate> delegate;
@property (nonatomic,assign) BOOL isPlaying;
@property (nonatomic,assign) CGFloat sound;

// 判断播放模式
@property (nonatomic,assign) NSInteger playType;

+ (instancetype) sharedPlayerManager;
- (void) playingWithURLstr:(NSString *) URLstr;
- (void) play;
- (void) pause;
// 从指定时间开始播放
- (void) seekToTime:(NSTimeInterval)time;


@end
