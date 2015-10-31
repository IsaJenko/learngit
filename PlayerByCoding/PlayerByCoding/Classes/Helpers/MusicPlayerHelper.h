//
//  MusicPlayerHelper.h
//  PlayerByCoding
//
//  Created by LakesMac on 15/10/12.
//  Copyright © 2015年 Lake. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol MusicPlayerHelperDelegate <NSObject>

- (void)playingSecondCanged:(NSTimeInterval)second;
- (void)musicDidStop;

@end

@interface MusicPlayerHelper : NSObject

@property (nonatomic,assign) id<MusicPlayerHelperDelegate> delegate;

@property (nonatomic,assign,getter=isPlaying) BOOL playing;

+ (instancetype)sharedMusicPlayerHelper;

- (void)playMusicWithURLString:(NSString *)URLString;

- (void)play;
- (void)pause;


@end
