//
//  OnPayingView.m
//  PlayerByCoding
//
//  Created by LakesMac on 15/10/11.
//  Copyright © 2015年 Lake. All rights reserved.
//

#import "OnPayingView.h"


@implementation OnPayingView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addAllViews];
    }
    return self;
}

- (void)addAllViews{
    self.backgroundColor = [UIColor blackColor];
    self.mainBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, kMainScreenBounds.size.width, kMainScreenBounds.size.height - 20)];
    self.mainBackView.layer.cornerRadius = 10;
    self.mainBackView.layer.masksToBounds = YES;
    [self addSubview:self.mainBackView];
    
    self.titleBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.mainBackView.frame.size.width, self.mainBackView.frame.size.height * 0.382)];
    self.titleBackView.backgroundColor = kTintColorGreen_2;
    [self.mainBackView addSubview:self.titleBackView];
    
    self.buttonBackView = [[UIView alloc] initWithFrame:CGRectMake(0, self.titleBackView.frame.size.height, self.mainBackView.frame.size.width, self.mainBackView.frame.size.height - self.titleBackView.frame.size.height)];
    self.buttonBackView.backgroundColor = [UIColor whiteColor];
    [self.mainBackView addSubview:self.buttonBackView];
    
    
    self.progressView = [[EricaProgressView alloc] initWithFrame:CGRectMake(0, self.titleBackView.frame.size.height - 15, self.mainBackView.frame.size.width, 30) currentTintColor:kTintColorOrange maxTintColor:kTintColorGreen_3];
    [self.mainBackView addSubview:self.progressView];
    
    CGFloat imageBackViewWidth = self.mainBackView.frame.size.width *0.382 + 20;
    self.imageBackView = [[UIView alloc] initWithFrame:CGRectMake(self.mainBackView.frame.size.width / 2 - imageBackViewWidth / 2, self.progressView.frame.origin.y + 15 - imageBackViewWidth / 2, imageBackViewWidth, imageBackViewWidth)];
    self.imageBackView.backgroundColor = kTintColorGreen_1;
    self.imageBackView.layer.cornerRadius = imageBackViewWidth / 2;
    self.imageBackView.alpha = 0.4;
    [self.mainBackView addSubview:self.imageBackView];
    
    self.circleProgressView = [[CircleProgressView alloc] initWithFrame:self.imageBackView.frame];
    
    self.circleProgressView.persent = 1;
    [self.mainBackView addSubview:self.circleProgressView];
    
    
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.imageBackView.frame.size.width - 10, self.imageBackView.frame.size.height - 10)];
    [self.imageView setImage:[UIImage imageNamed:@"DefaultImage"]];
    self.imageView.center = CGPointMake(self.imageBackView.frame.origin.x + self.imageBackView.frame.size.width / 2, self.imageBackView.frame.origin.y + imageBackViewWidth / 2);
    self.imageView.layer.cornerRadius = self.imageView.frame.size.width / 2;
    self.imageView.layer.masksToBounds = YES;
    [self.mainBackView addSubview:self.imageView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, self.mainBackView.frame.size.width - 20, 30)];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.text = @"Breath The Air";
    self.titleLabel.font = [UIFont systemFontOfSize:23];
    [self.titleBackView addSubview:self.titleLabel];
    
    self.singerLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLabel.frame.origin.x, self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height, self.titleLabel.frame.size.width, self.titleLabel.frame.size.height)];
    self.singerLabel.textColor = [UIColor whiteColor];
    self.singerLabel.font = [UIFont systemFontOfSize:14];
    self.singerLabel.text = @"Michael jackson";
    [self.titleBackView addSubview:self.singerLabel];
    
    self.durationLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.singerLabel.frame.origin.x, self.singerLabel.frame.origin.y + self.singerLabel.frame.size.height, self.singerLabel.frame.size.width, self.singerLabel.frame.size.height)];
    self.durationLabel.textColor = [UIColor whiteColor];
    self.durationLabel.font = [UIFont systemFontOfSize:14];
    self.durationLabel.text = @"-02:42";
    [self.titleBackView addSubview:self.durationLabel];
    
    UIImage *listButtonImage = [UIImage imageNamed:@"listButton"];
    listButtonImage = [listButtonImage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    self.listButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [self.listButton setImage:listButtonImage forState:(UIControlStateNormal)];
    self.listButton.frame = CGRectMake(self.mainBackView.frame.size.width - 55, 30 , 35, 35);
    self.listButton.layer.cornerRadius = 35 / 2;
    self.listButton.layer.masksToBounds = YES;
    [self.titleBackView addSubview:self.listButton];
    
    self.playButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [self.playButton setImage:[UIImage imageNamed:@"play_playButton"] forState:(UIControlStateNormal)];
    self.playButton.tintColor = [UIColor whiteColor];
    self.playButton.backgroundColor = kTintColorOrange;
    self.playButton.frame = CGRectMake(self.imageView.frame.origin.x + self.imageView.frame.size.width / 2 - 30,self.imageView.frame.size.height + self.imageView.frame.origin.y + 30, 60, 60);
    self.playButton.layer.cornerRadius = 30;
    self.playButton.layer.borderColor = kTintColorGreen_1.CGColor;
//    self.playButton.layer.borderWidth = 2;
    [self.mainBackView addSubview:self.playButton];
    
    self.nextButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.nextButton.tintColor = [UIColor whiteColor];
    self.nextButton.backgroundColor = kTintColorGreen_3;
    self.nextButton.frame = CGRectMake(self.playButton.frame.origin.x + self.playButton.frame.size.width + 40, self.playButton.frame.origin.y - 10, 40, 40);
    self.nextButton.layer.cornerRadius = 20;
//    self.nextButton.layer.borderWidth = 2;
    self.nextButton.layer.borderColor = kTintColorGreen_1.CGColor;
    self.nextButton.layer.masksToBounds = YES;
    [self.nextButton setImage:[UIImage imageNamed:@"next_nextButton"] forState:(UIControlStateNormal)];
    [self.mainBackView addSubview:self.nextButton];
    
    self.prevButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.prevButton.tintColor = [UIColor whiteColor];
    self.prevButton.backgroundColor = kTintColorGreen_3;
    self.prevButton.frame = CGRectMake(self.playButton.frame.origin.x - 40 - 40, self.playButton.frame.origin.y - 10, 40, 40);
    self.prevButton.layer.cornerRadius = 20;
//    self.prevButton.layer.borderWidth = 2;
    self.prevButton.layer.borderColor = kTintColorGreen_1.CGColor;
    self.prevButton.layer.masksToBounds = YES;
    [self.prevButton setImage:[UIImage imageNamed:@"prev_prevButton"] forState:(UIControlStateNormal)];
    [self.mainBackView addSubview:self.prevButton];
    
    self.lrcTabelView = [[UITableView alloc] initWithFrame:CGRectMake(30, self.playButton.frame.size.height + self.playButton.frame.origin.y + 20, self.mainBackView.frame.size.width - 60, self.mainBackView.frame.size.height - self.playButton.frame.size.height - self.playButton.frame.origin.y - 60) style:(UITableViewStylePlain)];
//    self.lrcTabelView.backgroundColor = [UIColor grayColor];
    [self.mainBackView addSubview:self.lrcTabelView];
    
    [self.progressView currentPersentMake:1];
}

//- (void)rotationImageView{
//    [NSTimer scheduledTimerWithTimeInterval:0.03 target:self selector:@selector(rotation) userInfo:nil repeats:YES];
//}
- (void)rotation{
        self.imageView.transform = CGAffineTransformRotate(self.imageView.transform, M_PI_4 / 500);
}

@end
