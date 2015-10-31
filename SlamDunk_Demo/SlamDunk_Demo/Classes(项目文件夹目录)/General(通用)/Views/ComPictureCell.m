//
//  ComPictureCell.m
//  SlamDunk_Demo
//
//  Created by jinke on 15/10/23.
//  Copyright © 2015年 IsaJenko.github.io. All rights reserved.
//

#import "ComPictureCell.h"

@interface ComPictureCell ()

@property (weak, nonatomic) IBOutlet UIImageView *comPictureImageView;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avatorImageView;
@property (weak, nonatomic) IBOutlet UILabel *nick_nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *formatterLabel;

@end

@implementation ComPictureCell

- (void)setCommunityGM:(CommunityGM *)communityGM
{
    [self.avatorImageView sd_setImageWithURL:[NSURL URLWithString:communityGM.avator_url]];
    self.nick_nameLabel.text = communityGM.nick_name;
    self.formatterLabel.text = communityGM.formatter_published_at;
    self.contentLabel.text = communityGM.share_content;
    [self.comPictureImageView sd_setImageWithURL:[NSURL URLWithString:communityGM.share_image]];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
