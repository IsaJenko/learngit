//
//  CommunityGM.h
//  SlamDunk_Demo
//
//  Created by jinke on 15/10/23.
//  Copyright © 2015年 IsaJenko.github.io. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommunityGM : NSObject

@property (nonatomic,copy) NSString *cell_type;
@property (nonatomic,copy) NSString *comments_count;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSString *ID;
@property (nonatomic,copy) NSString *is_collected;
@property (nonatomic,copy) NSString *resourceable_id;
@property (nonatomic,copy) NSString *resourceable_type;
@property (nonatomic,copy) NSString *resourceable_url;
@property (nonatomic,copy) NSString *share_content;
@property (nonatomic,copy) NSString *share_image;
@property (nonatomic,copy) NSString *share_title;
@property (nonatomic,copy) NSString *share_url;
@property (nonatomic,strong) NSArray *topics;

@property (nonatomic,copy) NSString *avator_url; // 用户头像
@property (nonatomic,copy) NSString *nick_name; // 用户ID
@property (nonatomic,copy) NSString *formatter_published_at; // 时间

@end
