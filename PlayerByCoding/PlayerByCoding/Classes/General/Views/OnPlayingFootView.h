//
//  OnPlayingFootView.h
//  MusicPlayer_OC
//
//  Created by LakesMac on 15/10/9.
//  Copyright © 2015年 Lake. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TouchUpInside)(void);

@class MusicListModel;

@interface OnPlayingFootView : UIView

+ (instancetype)shareOnPlayingFootView;

@property (nonatomic,assign,readonly) BOOL isShow;
@property (nonatomic,strong) MusicListModel *model;
@property (nonatomic,copy) TouchUpInside touchUpInside;

@property (nonatomic,assign) CGFloat persent;

- (void)show;
- (void)hidden;

@end
