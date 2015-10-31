//
//  MusicListModel.h
//  MusicPlayer_OC
//
//  Created by LakesMac on 15/10/9.
//  Copyright © 2015年 Lake. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MusicListModel : NSObject

@property (nonatomic,copy) NSString
*mp3Url,
*name,
*picUrl,
*blurPicUrl,
*album,
*singer,
*artists_name,
*lyric;
@property (nonatomic,assign) NSInteger ID, duration;



@end
