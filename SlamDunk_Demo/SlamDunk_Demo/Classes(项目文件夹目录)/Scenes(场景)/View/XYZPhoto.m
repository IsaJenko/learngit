//
//  XYZPhoto.m
//  demo6_PhotoRiver
//
//  Created by BOBO on 15/3/23.
//  Copyright (c) 2015年 BobooO. All rights reserved.
//

#import "XYZPhoto.h"

@implementation XYZPhoto

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor blackColor];
        self.imageView = [[UIImageView alloc]initWithFrame:self.bounds];
        self.drawView = [[XYZDrawView alloc]initWithFrame:self.bounds];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.drawView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.drawView];
        [self addSubview:self.imageView];
        
        NSTimer *timer = [NSTimer timerWithTimeInterval:0.02 target:self selector:@selector(movePhotos) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:@"NSDefaultRunLoopMode"];
        
        self.layer.borderWidth = 1;
        self.layer.borderColor = [[UIColor whiteColor] CGColor];
        
//        [NSTimer scheduledTimerWithTimeInterval:1/30 target:self selector:@selector(movePhotos) userInfo:nil repeats:YES];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImage)];
        [self addGestureRecognizer:tap];
        
        UISwipeGestureRecognizer *swip = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipImage)];
        [swip setDirection:UISwipeGestureRecognizerDirectionLeft | UISwipeGestureRecognizerDirectionRight];
        [self addGestureRecognizer:swip];
        
        
    }
    return self;
}

- (void)tapImage {
    
    [UIView animateWithDuration:0.5 animations:^{
        
        if (self.state == XYZPhotoStateNormal) {
            self.oldFrame = self.frame;
            self.oldAlpha = self.alpha;
            self.oldSpeed = self.speed;
            self.frame = CGRectMake(20, 20, self.superview.bounds.size.width - 40, self.superview.bounds.size.height - 40);
            self.imageView.frame = self.bounds;
            self.drawView.frame = self.bounds;
            [self.superview bringSubviewToFront:self];
            self.speed = 0;
            self.alpha = 1;
            self.state = XYZPhotoStateBig;
            
        } else if (self.state == XYZPhotoStateBig) {
            self.frame = self.oldFrame;
            self.alpha = self.oldAlpha;
            self.speed = self.oldSpeed;
            self.imageView.frame = self.bounds;
            self.drawView.frame = self.bounds;
            self.state = XYZPhotoStateNormal;
        }
        
    }];
   
}

- (void)swipImage {
    
    if (self.state == XYZPhotoStateBig) {
        [self exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
        self.state = XYZPhotoStateDraw;
    } else if (self.state == XYZPhotoStateDraw){
        [self exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
        self.state = XYZPhotoStateBig;
    }
}


- (void)updateImage:(UIImage *)image {
    self.imageView.image = image;
    NSLog(@"image......");
}


- (void)setImageAlphaAndSpeedAndSize:(float)alpha {
    self.alpha = alpha;
    self.speed = alpha;
    self.transform = CGAffineTransformScale(self.transform, alpha, alpha);
}

- (void)movePhotos {
    self.center = CGPointMake(self.center.x + self.speed, self.center.y );
    if (self.center.x > self.superview.bounds.size.width + self.frame.size.width/2) {
        self.center = CGPointMake(-self.frame.size.width/2, arc4random()%(int)(self.superview.bounds.size.height - self.bounds.size.height) + self.bounds.size.height/2);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
