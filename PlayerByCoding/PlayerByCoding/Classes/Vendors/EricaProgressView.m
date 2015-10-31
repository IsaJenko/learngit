//
//  EricaProgressView.m
//  PlayerByCoding
//
//  Created by LakesMac on 15/10/10.
//  Copyright © 2015年 Lake. All rights reserved.
//

#import "EricaProgressView.h"

#define k_totalValue      (self.maxValue - self.minValue)
#define k_maxFrameWidth   self.maxFrame.size.width
#define k_maxFrameHeight  self.maxFrame.size.height



@interface EricaProgressView ()
@property (nonatomic,strong) UIView *MaxValueView;
@property (nonatomic,strong) UIView *CurrentValueView;

@property (nonatomic,assign) CGRect currentFrame;
@property (nonatomic,assign) CGRect maxFrame;

@end
@implementation EricaProgressView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _minValue = 0.0;
        _maxValue = 1.0;
        _maxFrame = frame;
        [self addAllViews];
    }
    return self;
}

- (void)addAllViews{
    self.backgroundColor = [UIColor clearColor];
    
    self.MaxValueView = [[UIView alloc] initWithFrame:self.bounds];
    [self addSubview:self.MaxValueView];
    
    self.CurrentValueView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width / 2, self.bounds.size.height)];
    _currentFrame = self.CurrentValueView.bounds;
    _currentValue = self.currentFrame.size.width / self.maxFrame.size.width;
    [self addSubview:self.CurrentValueView];
}

- (instancetype)initWithFrame:(CGRect)frame currentTintColor:(UIColor *)currentTintColor maxTintColor:(UIColor *)maxTintColor{
    
    EricaProgressView *er = [[EricaProgressView alloc] initWithFrame:frame];
    er.MaxValueView.backgroundColor = maxTintColor;
    er.CurrentValueView.backgroundColor = currentTintColor;
    return er;
}

- (void)setCurrentPersent:(CGFloat)currentPersent{
    currentPersent = currentPersent>1?1:currentPersent;
    currentPersent = currentPersent<0?0:currentPersent;
    _currentValue = k_totalValue * currentPersent;
    _currentFrame = CGRectMake(0, 0, k_maxFrameWidth * currentPersent, k_maxFrameHeight);
    self.CurrentValueView.frame = _currentFrame;
}
- (void)currentPersentMake:(CGFloat)currentPersent{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [self setCurrentPersent:currentPersent];
    [UIView commitAnimations];
}

- (void)setCurrentVlue:(CGFloat)currentValue{
    CGFloat currentPersent = (currentValue - _minValue) / k_totalValue;
    [self setCurrentPersent:currentPersent];
}

- (void)CurrentVlueMake:(CGFloat)currentValue{
    CGFloat currentPersent = currentValue / k_totalValue;
    [self currentPersentMake:currentPersent];
}


#pragma mark Color Setters
- (void)setCurrentTintColor:(UIColor *)currentTintColor{
    self.CurrentValueView.backgroundColor = currentTintColor;
}
- (void)setMaxTintColor:(UIColor *)maxTintColor{
    self.MaxValueView.backgroundColor = maxTintColor;
}




@end
