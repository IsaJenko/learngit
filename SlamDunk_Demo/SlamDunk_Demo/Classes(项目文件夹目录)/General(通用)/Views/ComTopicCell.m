//
//  ComTopicCell.m
//  SlamDunk_Demo
//
//  Created by jinke on 15/10/23.
//  Copyright © 2015年 IsaJenko.github.io. All rights reserved.
//

#import "ComTopicCell.h"

@interface ComTopicCell ()

@property (weak, nonatomic) IBOutlet UIImageView *ComTopicImageView;

@property (weak, nonatomic) IBOutlet UILabel *ComTopicLabel;

@end

@implementation ComTopicCell

- (void)setCommunityTopic:(CommunityTopic *)communityTopic
{
    self.ComTopicLabel.text = [NSString stringWithFormat:@"%@参与 | %@阅读",communityTopic.feed_count,communityTopic.view_count];
    self.ComTopicImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"cropped_%@.jpg",communityTopic.ID]];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
