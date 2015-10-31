//
//  MusicCell.m
//  J_music
//
//  Created by jinke on 15/10/13.
//  Copyright © 2015年 IsaJenko.github.io. All rights reserved.
//

#import "MusicCell.h"

@implementation MusicCell

- (void)setMusic:(Music *)music
{
    _songNameLabel.text = music.name;
    _singerNameLabel.text = music.singer;
    [_songImageView sd_setImageWithURL:[NSURL URLWithString:music.picUrl]];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
