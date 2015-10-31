//
//  DataManager.m
//  SlamDunk_Demo
//
//  Created by jinke on 15/10/23.
//  Copyright © 2015年 IsaJenko.github.io. All rights reserved.
//

#import "DataManager.h"

@interface DataManager ()

@property (nonatomic,strong) NSMutableArray *allComHotData;
@property (nonatomic,strong) NSMutableArray *allComTopicData;
@property (nonatomic,strong) NSMutableArray *allComPictureData;
@property (nonatomic,strong) NSMutableArray *allNewsData;
@property (nonatomic,strong) NSMutableArray *ComHotRank_id;

@end

@implementation DataManager

+ (instancetype) sharedDataManager
{
    static DataManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [DataManager new];
    });
    return manager;
}
// 社区主题数据
- (void) loadCommunityTopicData
{
    /*
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
    
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:kComTopicURL]];
        NSURLSession *session = [NSURLSession sharedSession];
        
        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
//                        NSLog(@"%@",array);
            for (NSDictionary *dict in array) {
                CommunityTopic *communityTopic = [CommunityTopic new];
                [communityTopic setValuesForKeysWithDictionary:dict];
                [self.allComTopicData addObject:communityTopic];
            }
     
     self.callBackBlock();
     
        }];
        [dataTask resume];
        
     //    });*/
        
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:kComTopicURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        for (NSDictionary *dict in responseObject) {
            CommunityTopic *communityTopic = [CommunityTopic new];
            [communityTopic setValuesForKeysWithDictionary:dict];
            [self.allComTopicData addObject:communityTopic];
        }
        
        self.callBackBlock();
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}
// 刷新晒图数据 上拉加载
- (void) refreshCommunityPictureDataWithID:(NSString *)ID;
{
                    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager GET:[NSString stringWithFormat:@"http://app.dunkhome.com/v2/feeds?type=recent&id=%@&prepend=0&separated_id=%@",ID,ID] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            for (NSDictionary *dict in responseObject) {
                NSDictionary *contentDict = [dict valueForKey:@"content_data"];
                CommunityGM *communityGM = [CommunityGM new];
                communityGM.content = [contentDict valueForKey:@"content"];
                communityGM.share_content = [contentDict valueForKey:@"share_content"];
                communityGM.share_image = [contentDict valueForKey:@"share_image"];
                communityGM.share_url = [contentDict valueForKey:@"share_url"];
                NSDictionary *avatorDict = [dict valueForKey:@"avator_data"];
                communityGM.formatter_published_at = [avatorDict valueForKey:@"formatted_published_at"];
                NSDictionary *creatorDict = [avatorDict valueForKey:@"creator"];
                communityGM.avator_url = [creatorDict valueForKey:@"avator_url"];
                communityGM.nick_name = [creatorDict valueForKey:@"nick_name"];
                [self.allComPictureData addObject:communityGM];
                
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
}
- (void) deleteAllData
{
    [self.allComPictureData removeAllObjects];
}
// 社区晒图数据
-(void) loadCommunityPictureData
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:kCommunityPictureURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                for (NSDictionary *dict in responseObject) {
                NSDictionary *contentDict = [dict valueForKey:@"content_data"];
                CommunityGM *communityGM = [CommunityGM new];
                communityGM.content = [contentDict valueForKey:@"content"];
                communityGM.ID = [contentDict valueForKey:@"id"];
                communityGM.share_content = [contentDict valueForKey:@"share_content"];
                communityGM.share_image = [contentDict valueForKey:@"share_image"];
                communityGM.share_url = [contentDict valueForKey:@"share_url"];
                NSDictionary *avatorDict = [dict valueForKey:@"avator_data"];
                communityGM.formatter_published_at = [avatorDict valueForKey:@"formatted_published_at"];
                NSDictionary *creatorDict = [avatorDict valueForKey:@"creator"];
                communityGM.avator_url = [creatorDict valueForKey:@"avator_url"];
                communityGM.nick_name = [creatorDict valueForKey:@"nick_name"];
                [self.allComPictureData addObject:communityGM];
                }
        self.pictureBlock();
        
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
        }
// 加载新闻数据
- (void) loadNBANEWSData
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:NBANEWS_URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSArray *tArray = [responseObject valueForKey:@"T1348649145984"];

            for (NSDictionary *dict in tArray) {
                NBANEWS *nbaNews = [NBANEWS new];
                [nbaNews setValuesForKeysWithDictionary:dict];
                [self.allNewsData addObject:nbaNews];
            }
        self.nbaBlock();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

}
- (void) deleteAllNBANews
{
    [self.allNewsData removeAllObjects];
}
// 加载热门数据
- (void) loadCommunityHotData
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:kComHotURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSArray *feedsArray = [responseObject valueForKey:@"feeds"];
        ComGMRank_id *comGMrank_id = [ComGMRank_id new];
            comGMrank_id.rank_id = [responseObject valueForKey:@"rank_id"];
        NSLog(@">>>>>>>>>>>>>>>>>>%@",comGMrank_id.rank_id);
        [self.ComHotRank_id addObject:comGMrank_id];
                for (NSArray *arrayA in feedsArray) {
                    CommunityGM *communityGM = [CommunityGM new];
                    NSDictionary *content_data = [arrayA valueForKey:@"content_data"];
                    communityGM.share_image = [content_data valueForKey:@"share_image"];
                    communityGM.share_content = [content_data valueForKey:@"share_content"];
                    communityGM.share_url = [content_data valueForKey:@"share_url"];
                    NSDictionary *avatorDict = [arrayA valueForKey:@"avator_data"];
                    communityGM.formatter_published_at = [avatorDict valueForKey:@"formatted_published_at"];
                    NSDictionary *creatorDict = [avatorDict valueForKey:@"creator"];
                    communityGM.avator_url = [creatorDict valueForKey:@"avator_url"];
                    communityGM.nick_name = [creatorDict valueForKey:@"nick_name"];
                    [self.allComHotData addObject:communityGM];
                }
        self.hotBlock();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

}
- (void) refreshCommunityHotDataWithRank_id:(NSString *)rank_id Page:(NSInteger)page
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:@"http://app.dunkhome.com/v2/feeds/v2_rank_id/%@/page/%ld",rank_id,page] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        for (NSArray *arrayA in responseObject) {
            
                CommunityGM *communityGM = [CommunityGM new];
                NSDictionary *content_data = [arrayA valueForKey:@"content_data"];
                communityGM.share_image = [content_data valueForKey:@"share_image"];
                communityGM.share_content = [content_data valueForKey:@"share_content"];
                communityGM.share_url = [content_data valueForKey:@"share_url"];
                NSDictionary *avatorDict = [arrayA valueForKey:@"avator_data"];
                communityGM.formatter_published_at = [avatorDict valueForKey:@"formatted_published_at"];
                NSDictionary *creatorDict = [avatorDict valueForKey:@"creator"];
                communityGM.avator_url = [creatorDict valueForKey:@"avator_url"];
                communityGM.nick_name = [creatorDict valueForKey:@"nick_name"];
                [self.allComHotData addObject:communityGM];
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

}
- (void) deleteHotData
{
    [self.allComHotData removeAllObjects];
}
- (void) refreshCommunityHotDataWithNumber:(NSInteger)number
{
    
}
- (NSMutableArray *)allComTopicData
{
    if (!_allComTopicData) {
        self.allComTopicData = [NSMutableArray new];
    }
    return _allComTopicData;
}
- (NSArray *)communityTopicArray
{
    return [self.allComTopicData copy];
}
- (NSMutableArray *)allComPictureData
{
    if (!_allComPictureData) {
        self.allComPictureData = [NSMutableArray array];
    }
    return _allComPictureData;
}
- (NSArray *)communityPictureArray
{
    return [self.allComPictureData copy];
}
- (NSArray *)nbaNewsArray
{
    return [self.allNewsData copy];
}
- (NSMutableArray *)allNewsData
{
    if (!_allNewsData) {
        self.allNewsData = [NSMutableArray array];
    }
    return _allNewsData;
}
- (NSArray *)communityHotArray
{
    return [self.allComHotData copy];
}
- (NSMutableArray *)allComHotData
{
    if (!_allComHotData) {
        self.allComHotData = [NSMutableArray array];
    }
    return _allComHotData;
}
- (NSMutableArray *)ComHotRank_id
{
    if (!_ComHotRank_id) {
        self.ComHotRank_id = [NSMutableArray array];
    }
    return _ComHotRank_id;
}
- (NSArray *)rank_idArr
{
    return [self.ComHotRank_id copy];
}
@end
