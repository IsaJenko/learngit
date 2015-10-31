//
//  PlayerManager.m
//  J_music
//
//  Created by jinke on 15/10/13.
//  Copyright © 2015年 IsaJenko.github.io. All rights reserved.
//

#import "PlayerManager.h"
@import AVFoundation;

@interface PlayerManager ()

@property (nonatomic,strong) AVPlayer *player;
@property (nonatomic,strong) NSTimer *timer;

@end

@implementation PlayerManager

+ (instancetype) sharedPlayerManager
{
    static PlayerManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [PlayerManager new];
        manager.playType = 1;
    });
    return manager;
}
- (instancetype)init
{
    if (self = [super init]) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didToStop) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    }
    return self;
}
- (void) didToStop
{
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didStop)]) {
        [self.delegate didStop];
    }
}
- (void) playingWithURLstr:(NSString *) URLstr
{
    
    NSURL *url = [NSURL URLWithString:URLstr];
    AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:url];
    [self.player replaceCurrentItemWithPlayerItem:item];
    [self.player addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"status"]) {
        if (self.player.status == AVPlayerStatusReadyToPlay) {
                 [self play];
        }
    }
}
- (void) play
{
    if (self.isPlaying == YES) {
        return;
    }
    
    [self.player play];
    
    self.isPlaying = YES;
    // 开启定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
}
- (void) pause
{
    if (self.isPlaying == NO) {
        return;
            }
    [self.player pause];
    self.isPlaying = NO;
    // 停止计时器
    [self.timer invalidate];
    self.timer = nil;

}
- (void) timerAction
{
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(playingWithTime:)]) {
        NSTimeInterval time = self.player.currentTime.value / self.player.currentTime.timescale;
        [self.delegate playingWithTime:time];
    }
}
- (void)seekToTime:(NSTimeInterval)time
{
    [self.player seekToTime:CMTimeMakeWithSeconds(time, self.player.currentTime.timescale) completionHandler:^(BOOL finished) {
        [self play];
    }];
}
- (void)setSound:(CGFloat)sound
{
    self.player.volume = sound;
}
- (CGFloat)sound
{
    return self.player.volume;
}
- (AVPlayer *)player
{
    if (!_player) {
        self.player = [AVPlayer new];
    }
    return _player;
}

@end
