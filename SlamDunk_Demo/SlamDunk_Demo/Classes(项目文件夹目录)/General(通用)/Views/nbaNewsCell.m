//
//  nbaNewsCell.m
//  SlamDunk_Demo
//
//  Created by jinke on 15/10/23.
//  Copyright © 2015年 IsaJenko.github.io. All rights reserved.
//

#import "nbaNewsCell.h"

@interface nbaNewsCell ()

@property (weak, nonatomic) IBOutlet UIImageView *newsImageView;

@property (weak, nonatomic) IBOutlet UILabel *digestLabel;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation nbaNewsCell


- (void)setNbaNews:(NBANEWS *)nbaNews
{
    self.digestLabel.text = nbaNews.title;
    self.titleLabel.text = nbaNews.digest;
    [self.newsImageView sd_setImageWithURL:[NSURL URLWithString:nbaNews.imgsrc]];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
