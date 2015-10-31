//
//  MusicManager.m
//  J_music
//
//  Created by jinke on 15/10/13.
//  Copyright © 2015年 IsaJenko.github.io. All rights reserved.
//

#import "MusicManager.h"

@interface MusicManager ()

@property (nonatomic,strong) NSMutableArray *allMusicArray;

@end

@implementation MusicManager

+ (instancetype)sharedMusicManager
{
    static MusicManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [MusicManager new];
    });
    return manager;
}

- (instancetype)init
{
    if (self = [super init]) {
        [self loadData];
    }
    return self;
}

- (void) loadData
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 子线程代码
        
        NSURL *url = [NSURL URLWithString:kMusicListURL];
        
        NSArray *array = [NSArray arrayWithContentsOfURL:url];
        
        for (NSDictionary *dict in array) {
            Music *music = [Music new];
            [music setValuesForKeysWithDictionary:dict];
            [self.allMusicArray addObject:music];
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // 返回主线程 函数回调
            self.result();
        });
    });
    
}
- (NSArray *)allMusic
{
    return [self.allMusicArray copy];
}
- (NSMutableArray *)allMusicArray
{
    if (!_allMusicArray) {
        self.allMusicArray = [NSMutableArray array];
    }
    return _allMusicArray;
}
@end
