//
//  OnPlayingFootView.m
//  MusicPlayer_OC
//
//  Created by LakesMac on 15/10/9.
//  Copyright © 2015年 Lake. All rights reserved.
//

#import "OnPlayingFootView.h"
#import "MusicListModel.h"


@interface OnPlayingFootView ()
@property (nonatomic,strong) UIVisualEffectView *blurView;
@property (nonatomic,strong) UILabel *MusicNameLabel;
@property (nonatomic,strong) UIProgressView *progressView;

@property (nonatomic,assign) CGRect trueFrame;
@property (nonatomic,assign) CGRect hiddenFrame;

@property (nonatomic,assign) UIButton *showOnPlayingMusic;

@end
@implementation OnPlayingFootView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _trueFrame = frame;
        
        [self addAllViews];
        _hiddenFrame = self.frame;
    }
    return self;
}

- (void)addAllViews{
    self.backgroundColor = [UIColor clearColor];
    
    self.frame = CGRectMake(self.trueFrame.origin.x,kMainScreenBounds.size.height, self.trueFrame.size.width, self.trueFrame.size.height);
    
    self.blurView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:(UIBlurEffectStyleDark)]];
    self.blurView.frame = self.bounds;
    [self addSubview:self.blurView];
//    
    self.MusicNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, self.bounds.size.width - 20, 30)];
    self.MusicNameLabel.textColor = kTintColorGreen_1;
    [self addSubview:self.MusicNameLabel];
//
    self.progressView = [[UIProgressView alloc] initWithProgressViewStyle:(UIProgressViewStyleBar)];
    self.progressView.frame = self.bounds;
    [self addSubview:self.progressView];
    
//
    
    
    
//    self.progressView.progress = 0.4;
    self.progressView.progressTintColor = kTintColorOrange;
    self.MusicNameLabel.text = @"正在播放:";
}

- (void)setModel:(MusicListModel *)model{
    self.MusicNameLabel.text = [NSString stringWithFormat:@"正在播放：%@",model.name];
}

- (void)setPersent:(CGFloat)persent{
    self.progressView.progress = persent;
}

- (void)show{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    self.frame = self.trueFrame;
    [UIView commitAnimations];
    _isShow = YES;
}

- (void)hidden{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    self.frame = self.hiddenFrame;
    [UIView commitAnimations];
    _isShow = NO;
}

+ (instancetype)shareOnPlayingFootView{
    static OnPlayingFootView *onplayingView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        onplayingView = [[self alloc] initWithFrame:CGRectMake(0, kMainScreenBounds.size.height - 60, kMainScreenBounds.size.width, 60)];
    });
    return onplayingView;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _touchUpInside();
}

@end
