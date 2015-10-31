//
//  MusicPlayerViewController.h
//  J_music
//
//  Created by jinke on 15/10/13.
//  Copyright © 2015年 IsaJenko.github.io. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MusicPlayerViewController : UIViewController

+ (instancetype) sharedMusicPlayer;

@property (nonatomic,assign) NSInteger index;

@end
