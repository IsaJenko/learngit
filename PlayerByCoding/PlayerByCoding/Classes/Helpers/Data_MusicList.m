//
//  Data_MusicList.m
//  MusicPlayer_OC
//
//  Created by LakesMac on 15/10/9.
//  Copyright © 2015年 Lake. All rights reserved.
//

#import "Data_MusicList.h"
#import "MusicListModel.h"

@interface Data_MusicList ()

@property (nonatomic,strong) NSMutableArray *allDataArray;

@end

@implementation Data_MusicList

+ (instancetype)shareData_MusicList{
    static Data_MusicList *data = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        data = [self new];
    });
    return data;
}

- (instancetype)init{
    if (self = [super init]) {
        [self loadData];
    }
    return self;
}

- (void)loadData{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
       
        NSArray *array = [NSArray arrayWithContentsOfURL:[NSURL URLWithString:kMusicListURL]];
        for (NSDictionary *dic in array) {
            MusicListModel *model = [MusicListModel new];
            [model setValuesForKeysWithDictionary:dic];
            [self.allDataArray addObject:model];
            NSLog(@"%@",model.name);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            self.resultComplete();
        });
        
    });
    
}


- (NSInteger)numberOfItems{
    return self.allDataArray.count;
}
- (id)modelAtIndex:(NSInteger)index{
    return self.allDataArray[index];
}



- (NSMutableArray *)allDataArray{
    if (!_allDataArray) {
        _allDataArray = [NSMutableArray array];
    }
    return _allDataArray;
}

@end
