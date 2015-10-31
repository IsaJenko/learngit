//
//  MusicPlayerHelper.m
//  PlayerByCoding
//
//  Created by LakesMac on 15/10/12.
//  Copyright © 2015年 Lake. All rights reserved.
//

#import "MusicPlayerHelper.h"
@import AVFoundation;

@interface MusicPlayerHelper ()

@property (nonatomic,strong) AVPlayer *player;

@property (nonatomic,strong) NSTimer *timer;

@end

@implementation MusicPlayerHelper

+ (instancetype)sharedMusicPlayerHelper{
    static MusicPlayerHelper *player = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        player = [self new];
    });
    return player;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endPlay) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    }
    return self;
}

- (void)playMusicWithURLString:(NSString *)URLString{
    NSURL *url = [NSURL URLWithString:URLString];
    AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:url];
    [self.player replaceCurrentItemWithPlayerItem:item];
    [self.player addObserver:self forKeyPath:@"status" options:(NSKeyValueObservingOptionNew) context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"status"]) {
        if (self.player.status == AVPlayerStatusReadyToPlay) {
            [self play];
            
        }
    }
}
- (void)play{
    if (_playing == YES) {
        return;
    }
    if (self.player.status != AVPlayerStatusReadyToPlay) {
        return;
    }
    
    [self.player play];
    _playing = YES;
    if (_timer) {
        return;
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
}
- (void)pause{
    if (_playing == NO) {
        return;
    }
    [self.player pause];
    _playing = NO;
    [self.timer invalidate];
    self.timer = nil;
}

- (void)timerAction{
    CGFloat currentTime = self.player.currentTime.value / self.player.currentTime.timescale;
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(playingSecondCanged:)]) {
        [self.delegate playingSecondCanged:currentTime];
    }
}

- (void)endPlay{
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(musicDidStop)]) {
        _playing = NO;
        [self.delegate musicDidStop];
    }
}

- (AVPlayer *)player{
    if (!_player) {
        _player = [AVPlayer new];
    }
    return _player;
}

@end
