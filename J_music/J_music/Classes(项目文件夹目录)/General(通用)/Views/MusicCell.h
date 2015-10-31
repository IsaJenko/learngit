//
//  MusicCell.h
//  J_music
//
//  Created by jinke on 15/10/13.
//  Copyright © 2015年 IsaJenko.github.io. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MusicCell : UITableViewCell

@property (nonatomic,strong) Music *music;

@property (weak, nonatomic) IBOutlet UIImageView *songImageView;
@property (weak, nonatomic) IBOutlet UILabel *songNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *singerNameLabel;

@end
