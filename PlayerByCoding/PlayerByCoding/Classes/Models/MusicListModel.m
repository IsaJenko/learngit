//
//  MusicListModel.m
//  MusicPlayer_OC
//
//  Created by LakesMac on 15/10/9.
//  Copyright © 2015年 Lake. All rights reserved.
//

#import "MusicListModel.h"

@implementation MusicListModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        _ID = (NSInteger)value;
    }
}

@end
