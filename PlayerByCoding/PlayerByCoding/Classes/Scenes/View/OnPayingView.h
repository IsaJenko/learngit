//
//  OnPayingView.h
//  PlayerByCoding
//
//  Created by LakesMac on 15/10/11.
//  Copyright © 2015年 Lake. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EricaProgressView.h"
#import "CircleProgressView.h"

@interface OnPayingView : UIView

@property (nonatomic,strong) UIView *mainBackView;
@property (nonatomic,strong) UIView *titleBackView;
@property (nonatomic,strong) UIView *buttonBackView;
@property (nonatomic,strong) UIView *imageBackView;
@property (nonatomic,strong) CircleProgressView *circleProgressView;

@property (nonatomic,strong) UIImageView *imageView;

@property (nonatomic,strong) EricaProgressView *progressView;

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *singerLabel;
@property (nonatomic,strong) UILabel *durationLabel;

@property (nonatomic,strong) UIButton *listButton;
@property (nonatomic,strong) UIButton *playButton;
@property (nonatomic,strong) UIButton *nextButton;
@property (nonatomic,strong) UIButton *prevButton;

@property (nonatomic,strong) UITableView *lrcTabelView;


//- (void)rotationImageView;
- (void)rotation;

@end
