//
//  EricaProgressView.h
//  PlayerByCoding
//
//  Created by LakesMac on 15/10/10.
//  Copyright © 2015年 Lake. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EricaProgressView : UIView

//default is 0.5
@property (nonatomic,assign) CGFloat currentValue;
//default is 0.5
@property (nonatomic,assign) CGFloat currentPersent;

//default is 1.0
@property (nonatomic,assign) CGFloat maxValue;
//default is 0
@property (nonatomic,assign) CGFloat minValue;


@property (nonatomic,strong) UIColor *currentTintColor;
@property (nonatomic,strong) UIColor *maxTintColor;

- (instancetype)initWithFrame:(CGRect)frame
             currentTintColor:(UIColor *)currentTintColor
                 maxTintColor:(UIColor *)maxTintColor;
- (void)setCurrentPersent:(CGFloat)currentPersent;
- (void)setCurrentVlue:(CGFloat)currentValue;
- (void)currentPersentMake:(CGFloat)currentPersent;
- (void)CurrentVlueMake:(CGFloat)currentValue;
@end
