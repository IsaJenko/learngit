//
//  ComHotCell.m
//  SlamDunk_Demo
//
//  Created by jinke on 15/10/24.
//  Copyright © 2015年 IsaJenko.github.io. All rights reserved.
//

#import "ComHotCell.h"

@interface ComHotCell ()

@property (nonatomic,strong) UIView *myView;
@property (nonatomic,strong) UIImageView *myImageView;
@property (nonatomic,strong) UILabel *nick_name;
@property (nonatomic,strong) UILabel *formattedLabel;
@property (nonatomic,strong) UILabel *contentLabel;
@property (nonatomic,strong) UIImageView *avatorImageView;


@end

@implementation ComHotCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addAllViews];
    }
    return self;
}
- (void) addAllViews
{
    [self.contentView addSubview:self.myView];
    self.myImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
    [_myView addSubview:_myImageView];
    
    self.avatorImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 155, 40, 40)];
    _avatorImageView.layer.cornerRadius = 20;
    _avatorImageView.layer.masksToBounds = YES;
    [_myView addSubview:_avatorImageView];
    
    self.nick_name = [[UILabel alloc] initWithFrame:CGRectMake(55, 155, 100, 30)];
    //    _nick_name.text = @"我是标题";
    _nick_name.textColor = [UIColor whiteColor];
    _nick_name.font = [UIFont fontWithName:[UIFont familyNames][0] size:15];
    _nick_name.numberOfLines = 0;
    [_myView addSubview:_nick_name];
    
    self.formattedLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 170, 100, 30)];
    //    _formattedLabel.text = @"3天前";
    _formattedLabel.textColor = [UIColor grayColor];
    _formattedLabel.font = [UIFont fontWithName:[UIFont familyNames][1] size:13];
    _formattedLabel.numberOfLines = 0;
    [_myView addSubview:_formattedLabel];
    
    self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 210, 150, 70)];
    //    _contentLabel.text = @"白领们每天都很忙？不只是做不完的工作，也不是经常失调的饮食营养，而是极度...";
    _contentLabel.textColor = [UIColor lightGrayColor];
    _contentLabel.font = [UIFont fontWithName:[UIFont familyNames][2] size:15];
    _contentLabel.numberOfLines = 0;
    [_myView addSubview:_contentLabel];
}
- (UIView *)myView
{
    if (!_myView) {
        self.myView = [[UIView alloc] init];
//        _myView.backgroundColor = [UIColor grayColor];
    }
    return _myView;
}
- (void)setCommunityGM:(CommunityGM *)communityGM
{
    [self.myImageView sd_setImageWithURL:[NSURL URLWithString:communityGM.share_image]];
    [self.avatorImageView sd_setImageWithURL:[NSURL URLWithString:communityGM.avator_url]];
    self.nick_name.text = communityGM.nick_name;
    self.formattedLabel.text = communityGM.formatter_published_at;
    self.contentLabel.text = communityGM.share_content;
}
- (void) layoutSubviews
{
    [super layoutSubviews];
    self.myView.frame = self.contentView.bounds;
}
@end
