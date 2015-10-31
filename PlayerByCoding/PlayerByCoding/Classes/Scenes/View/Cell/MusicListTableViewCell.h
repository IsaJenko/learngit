//
//  MusicListTableViewCell.h
//  MusicPlayer_OC
//
//  Created by LakesMac on 15/10/9.
//  Copyright © 2015年 Lake. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MusicListModel;
@interface MusicListTableViewCell : UITableViewCell

@property (nonatomic,strong) MusicListModel *model;

@end
