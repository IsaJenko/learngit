//
//  MusicListTableViewCell.m
//  MusicPlayer_OC
//
//  Created by LakesMac on 15/10/9.
//  Copyright © 2015年 Lake. All rights reserved.
//

#import "MusicListTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "MusicListModel.h"

@interface MusicListTableViewCell ()
@property (weak, nonatomic) IBOutlet UIView *shandowView;
@property (weak, nonatomic) IBOutlet UIView *MainBackView;

@property (weak, nonatomic) IBOutlet UIImageView *musicImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *singerLabel;


@end

@implementation MusicListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    return [super initWithCoder:aDecoder];
    
}

- (void)setModel:(MusicListModel *)model{
    self.shandowView.layer.shadowOpacity = 1;
    self.shandowView.layer.shadowOffset = CGSizeMake(0, 1);
//    self.shandowView.backgroundColor = [UIColor clearColor];
    self.shandowView.layer.cornerRadius = 10;
    
    self.MainBackView.layer.cornerRadius = 10;
    self.MainBackView.layer.masksToBounds = YES;
    
    self.nameLabel.text     = model.name;
    self.singerLabel.text   = model.singer;
    [self.musicImage sd_setImageWithURL:[NSURL URLWithString:model.picUrl] placeholderImage:[UIImage imageNamed:@"DefaultImage"]];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
