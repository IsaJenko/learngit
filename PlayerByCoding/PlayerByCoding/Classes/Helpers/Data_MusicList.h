//
//  Data_MusicList.h
//  MusicPlayer_OC
//
//  Created by LakesMac on 15/10/9.
//  Copyright © 2015年 Lake. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^ResultComplete)(void);

@interface Data_MusicList : NSObject

@property (nonatomic,copy) ResultComplete resultComplete;

+ (instancetype)shareData_MusicList;

- (NSInteger)numberOfItems;
- (id)modelAtIndex:(NSInteger)index;

@end
