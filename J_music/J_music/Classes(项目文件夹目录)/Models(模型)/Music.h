//
//  Music.h
//  J_music
//
//  Created by jinke on 15/10/13.
//  Copyright © 2015年 IsaJenko.github.io. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Music : NSObject

@property (nonatomic,copy) NSString *mp3Url;
@property (nonatomic,copy) NSString *ID;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *picUrl;
@property (nonatomic,copy) NSString *blurPicUrl;
@property (nonatomic,copy) NSString *album;
@property (nonatomic,copy) NSString *singer;
@property (nonatomic,copy) NSString *duration;
@property (nonatomic,copy) NSString *artists_name;
@property (nonatomic,copy) NSString *lyric;

@end
