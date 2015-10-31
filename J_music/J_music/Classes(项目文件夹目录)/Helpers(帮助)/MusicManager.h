//
//  MusicManager.h
//  J_music
//
//  Created by jinke on 15/10/13.
//  Copyright © 2015年 IsaJenko.github.io. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MusicManager : NSObject

typedef void (^Result) ();

+ (instancetype) sharedMusicManager;

@property (nonatomic,strong) NSArray *allMusic;
@property (nonatomic,copy) Result result;

@end
