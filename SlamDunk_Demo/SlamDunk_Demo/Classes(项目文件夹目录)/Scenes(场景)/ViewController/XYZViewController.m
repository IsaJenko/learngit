//
//  XYZViewController.m
//  demo6_PhotoRiver
//
//  Created by BOBO on 15/3/23.
//  Copyright (c) 2015年 BobooO. All rights reserved.
//

#import "XYZViewController.h"
#import "XYZPhoto.h"

#define IMAGEWIDTH 120
#define IMAGEHEIGHT 160

@interface XYZViewController ()
@property(nonatomic, strong) NSMutableArray * photos;
@end

@implementation XYZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(140, 10, 150, 30)];
    messageLabel.text = @"双击空白处试试";
    messageLabel.textColor = [UIColor redColor];
    [self.view addSubview:messageLabel];
    
    self.tabBarController.tabBar.hidden = YES;
    self.photos = [[NSMutableArray alloc]init];
    NSMutableArray *photoPaths = [[NSMutableArray alloc]init];
    
    NSString *path = [[NSBundle mainBundle] bundlePath];
    
    NSLog(@"path =%@", path);
    
    NSFileManager *fm = [NSFileManager defaultManager];
    
    NSArray *fileNames = [fm contentsOfDirectoryAtPath:path error:nil];
    for (NSString *fileName in fileNames ) {
        if ([fileName hasSuffix:@"jpg"] || [fileName hasSuffix:@"JPG"]) {
            NSString *photoPath = [path stringByAppendingPathComponent:fileName];
            [photoPaths addObject:photoPath];
        }
    }
    
    
    //添加9个图片到界面中
    if (photoPaths) {
        for (int i = 0; i < 11; i++) {
            float X = arc4random()%((int)self.view.bounds.size.width - IMAGEWIDTH);
            float Y = arc4random()%((int)self.view.bounds.size.height - IMAGEHEIGHT);
            float W = IMAGEWIDTH;
            float H = IMAGEHEIGHT;
            
            XYZPhoto *photo = [[XYZPhoto alloc]initWithFrame:CGRectMake(X, Y, W, H)];
            [photo updateImage:[UIImage imageWithContentsOfFile:photoPaths[i]]];
            [self.view addSubview:photo];
            
            float alpha = i*1.0/10 + 0.2;
            [photo setImageAlphaAndSpeedAndSize:alpha];
            
            [self.photos addObject:photo];
        }
    }

    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleTap)];
    [doubleTap setNumberOfTapsRequired:2];
    [self.view addGestureRecognizer:doubleTap];
    
}

- (void)doubleTap {
    
    NSLog(@"DoubleTap...........");
    self.tabBarController.tabBar.hidden = NO;
    for (XYZPhoto *photo in self.photos) {
        if (photo.state == XYZPhotoStateDraw || photo.state == XYZPhotoStateBig) {
            return;
        }
    }
    
    float W = self.view.bounds.size.width / 3;
    float H = self.view.bounds.size.height / 3;
    
    [UIView animateWithDuration:1 animations:^{
        for (int i = 0; i < self.photos.count; i++) {
            XYZPhoto *photo = [self.photos objectAtIndex:i];
            
            if (photo.state == XYZPhotoStateNormal) {
                photo.oldAlpha = photo.alpha;
                photo.oldFrame = photo.frame;
                photo.oldSpeed = photo.speed;
                photo.alpha = 1;
                photo.frame = CGRectMake(i%3*W, i/3*H, W, H);
                photo.imageView.frame = photo.bounds;
                photo.drawView.frame = photo.bounds;
                photo.speed = 0;
                photo.state = XYZPhotoStateTogether;
            } else if (photo.state == XYZPhotoStateTogether) {
                photo.alpha = photo.oldAlpha;
                photo.frame = photo.oldFrame;
                photo.speed = photo.oldSpeed;
                photo.imageView.frame = photo.bounds;
                photo.drawView.frame = photo.bounds;
                photo.state = XYZPhotoStateNormal;
            }
        }

    }];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
