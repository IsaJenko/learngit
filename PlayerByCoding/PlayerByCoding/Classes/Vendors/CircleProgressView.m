//
//  CircleProgressView.m
//  CriclProgressView
//
//  Created by LakesMac on 15/10/12.
//  Copyright © 2015年 Lake. All rights reserved.
//

#import "CircleProgressView.h"

@interface CircleProgressView ()
@property (nonatomic,strong) UIView *mainBackView;
@property (nonatomic,strong) UIView *progressView;

@end

@implementation CircleProgressView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addAllViews];
    }
    return self;
}

- (void)addAllViews{
    self.backgroundColor = [UIColor clearColor];
    
    self.progressView = [[UIView alloc] initWithFrame:self.bounds];
    self.progressView.backgroundColor = [UIColor clearColor];
    self.progressView.layer.masksToBounds = YES;
    [self addSubview:self.progressView];
    
    self.mainBackView = [[UIView alloc] initWithFrame:self.bounds];
    self.mainBackView.backgroundColor = [UIColor clearColor];
    self.mainBackView.layer.cornerRadius = self.mainBackView.frame.size.width / 2;
    self.mainBackView.layer.borderColor = kTintColorOrange.CGColor;
    self.mainBackView.layer.borderWidth = 4;
    [self.progressView addSubview:self.mainBackView];
}

- (void)setPersent:(CGFloat)persent{
    _persent = persent;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    self.progressView.bounds = CGRectMake(-self.bounds.size.width * (1- persent), 0, self.bounds.size.width, self.bounds.size.height);
    self.progressView.frame = CGRectMake(-self.bounds.size.width * (1- persent), 0, self.bounds.size.width, self.bounds.size.height);
    [UIView commitAnimations];
}

@end
