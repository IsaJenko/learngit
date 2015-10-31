//
//  DataManager.h
//  SlamDunk_Demo
//
//  Created by jinke on 15/10/23.
//  Copyright © 2015年 IsaJenko.github.io. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^CallBackBlock)();
typedef void (^HotBlock)();
typedef void (^PictureBlock)();
typedef void (^NBABlock)();




@interface DataManager : NSObject

@property (nonatomic,strong) NSArray *communityHotArray;
@property (nonatomic,strong) NSArray *communityTopicArray;
@property (nonatomic,strong) NSArray *communityPictureArray;
@property (nonatomic,strong) NSArray *nbaNewsArray;
@property (nonatomic,strong) NSArray *rank_idArr;
@property (nonatomic,copy) CallBackBlock callBackBlock;
@property (nonatomic,copy) HotBlock hotBlock;
@property (nonatomic,copy) PictureBlock pictureBlock;
@property (nonatomic,copy) NBABlock nbaBlock;


+ (instancetype) sharedDataManager;
- (void) loadCommunityTopicData;
- (void) loadCommunityPictureData;
- (void) refreshCommunityPictureDataWithID:(NSString *)ID;
- (void) loadNBANEWSData;
- (void) loadCommunityHotData;
- (void) refreshCommunityHotDataWithRank_id:(NSString *)rank_id Page:(NSInteger)page;
- (void) deleteAllData;
- (void) deleteHotData;
- (void) deleteAllNBANews;
@end
