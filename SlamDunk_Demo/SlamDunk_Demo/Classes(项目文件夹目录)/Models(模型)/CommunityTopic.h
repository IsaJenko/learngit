//
//  CommunityTopic.h
//  SlamDunk_Demo
//
//  Created by jinke on 15/10/23.
//  Copyright © 2015年 IsaJenko.github.io. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommunityTopic : NSObject

@property (nonatomic,copy) NSString *brief;
@property (nonatomic,copy) NSString *feed_count;
@property (nonatomic,copy) NSString *ID;
@property (nonatomic,copy) NSString *image_url;
@property (nonatomic,copy) NSString *large_image_url;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *view_count;

@end
