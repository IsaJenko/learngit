//
//  OnPlayingViewController.m
//  PlayerByCoding
//
//  Created by LakesMac on 15/10/11.
//  Copyright © 2015年 Lake. All rights reserved.
//

#import "OnPlayingViewController.h"
#import "OnPayingView.h"
#import "MusicListModel.h"
#import "UIImageView+WebCache.h"
#import "MusicPlayerHelper.h"

#import "LyricHelper.h"

@interface OnPlayingViewController ()<UITableViewDataSource,UITableViewDelegate,MusicPlayerHelperDelegate>
{
    
    NSInteger _currentIndex;
    MusicListModel *_currentMusic;
    NSTimeInterval _currentSecond;
    
}
@property (nonatomic,strong) OnPayingView *onPlayingView;



@end

@implementation OnPlayingViewController

- (void)loadView{
    self.onPlayingView = [[OnPayingView alloc] initWithFrame:kMainScreenBounds];
    self.view = self.onPlayingView;
}

+ (instancetype)sharedOnPlayingViewController{
    static OnPlayingViewController *onplayingVC = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        onplayingVC = [OnPlayingViewController new];
    });
    return onplayingVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setButtonAndTableView];
    [MusicPlayerHelper sharedMusicPlayerHelper].delegate = self;
}

- (void)viewWillAppear:(BOOL)animated{
    [self setCurrentMusic];
}

- (void)setCurrentMusic{
    if (self.Index == -1) {
        return;
    }
    _currentIndex = _Index;
    if (_currentMusic == [[Data_MusicList shareData_MusicList] modelAtIndex:self.Index]) {
        return;
    }
    _currentMusic = [[Data_MusicList shareData_MusicList] modelAtIndex:self.Index];
    [[LyricHelper sharedLyrcHelper] lyrcString:_currentMusic.lyric];
    [self playMusic];
}

- (void)setIndex:(NSInteger)Index{
    _Index = Index;
    
}

- (void)playMusic{
    self.onPlayingView.titleLabel.text = _currentMusic.name;
    self.onPlayingView.singerLabel.text = _currentMusic.singer;
    [self.onPlayingView.imageView sd_setImageWithURL:[NSURL URLWithString:_currentMusic.picUrl] placeholderImage:[UIImage imageNamed:@"DefaultImage"]];
    NSInteger min = (_currentMusic.duration / 1000) / 60;
    NSInteger sec = (_currentMusic.duration / 1000) % 60;
    if (sec < 10) {
        NSString *sec0 = [NSString stringWithFormat:@"0%ld",sec];
        self.onPlayingView.durationLabel.text = [NSString stringWithFormat:@"- %ld:%@",min,sec0];
    }
    self.onPlayingView.durationLabel.text = [NSString stringWithFormat:@"- %ld:%ld",min,sec];
    
    [[MusicPlayerHelper sharedMusicPlayerHelper] playMusicWithURLString:_currentMusic.mp3Url];
    [OnPlayingFootView shareOnPlayingFootView].model = _currentMusic;
    [self.onPlayingView.playButton setImage:[UIImage imageNamed:@"pause_playButton"] forState:(UIControlStateNormal)];
    [self.onPlayingView.lrcTabelView reloadData];
    
    
    
    [self.onPlayingView.progressView currentPersentMake:1];
    self.onPlayingView.circleProgressView.persent = 1;
}


- (void)setButtonAndTableView{
    
    [self.onPlayingView.listButton addTarget:self action:@selector(backToListAction) forControlEvents:(UIControlEventTouchUpInside)];
    // Do any additional setup after loading the view.
    self.onPlayingView.lrcTabelView.delegate = self;
    self.onPlayingView.lrcTabelView.dataSource = self;
    self.onPlayingView.lrcTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.onPlayingView.lrcTabelView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"lrc"];
    
    [self.onPlayingView.playButton addTarget:self action:@selector(playOrPauseAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.onPlayingView.nextButton addTarget:self action:@selector(nextMusicAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.onPlayingView.prevButton addTarget:self action:@selector(prevMusicAction) forControlEvents:(UIControlEventTouchUpInside)];
}
//播放暂停按钮动作
- (void)playOrPauseAction:(UIButton *)sender{
    if ([MusicPlayerHelper sharedMusicPlayerHelper].isPlaying) {
        [[MusicPlayerHelper sharedMusicPlayerHelper] pause];
        [sender setImage:[UIImage imageNamed:@"play_playButton"] forState:(UIControlStateNormal)];
    }else{
        [[MusicPlayerHelper sharedMusicPlayerHelper] play];
        [sender setImage:[UIImage imageNamed:@"pause_playButton"] forState:(UIControlStateNormal)];
    }
}
//下一首
- (void)nextMusicAction{
    if (_currentIndex == [Data_MusicList shareData_MusicList].numberOfItems - 1) {
        _Index = 0;
    }else{
        _Index = _currentIndex + 1;
    }
    [self setCurrentMusic];
    
    
}
//上一首
- (void)prevMusicAction{
    if (_currentIndex <= 0) {
        _Index = [Data_MusicList shareData_MusicList].numberOfItems - 1;
    }else{
        _Index = _currentIndex - 1;
    }
    [self setCurrentMusic];
}

//返回按钮
- (void)backToListAction{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        [[OnPlayingFootView shareOnPlayingFootView] show];
    }];
    
}


//播放完成
- (void)musicDidStop{
    [self nextMusicAction];
    [[MusicPlayerHelper sharedMusicPlayerHelper] play];
}

- (void)tableviewRow:(NSTimeInterval)second{
    if (_currentSecond == second) {
        return;
    }
    _currentSecond = second;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[[LyricHelper sharedLyrcHelper] indexOfTime:second] inSection:0];
    
    [self.onPlayingView.lrcTabelView selectRowAtIndexPath:indexPath animated:YES scrollPosition:(UITableViewScrollPositionMiddle)];
    
//    [self.onPlayingView.lrcTabelView scrollToRowAtIndexPath:indexPath atScrollPosition:(UITableViewScrollPositionMiddle) animated:YES];
//    
//    [self tableView:self.onPlayingView.lrcTabelView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:[[LyricHelper sharedLyrcHelper] indexOfTime:second] inSection:0]];
//    if ([NSIndexPath indexPathForRow:[[LyricHelper sharedLyrcHelper] indexOfTime:second] inSection:0].row != 0) {
//        [self tableView:self.onPlayingView.lrcTabelView didDeselectRowAtIndexPath:[NSIndexPath indexPathForRow:[[LyricHelper sharedLyrcHelper] indexOfTime:second] - 1 inSection:0]];
//    }

}

//播放秒变化
- (void)playingSecondCanged:(NSTimeInterval)second{
   
    [self.onPlayingView rotation];
    
    
    
    CGFloat persent = second / (_currentMusic.duration * (1.0 / 1000));
    [self.onPlayingView.progressView currentPersentMake:persent];

    CGFloat sw = 0.309 * kMainScreenBounds.size.width - 10;
    CGFloat swp = sw / kMainScreenBounds.size.width;
    CGFloat wP = 1 - 2 * (sw / kMainScreenBounds.size.width);
    
    if (persent >= swp && persent <= swp + wP) {
        CGFloat cp = ( persent - swp ) / wP;
        self.onPlayingView.circleProgressView.persent = cp;
    }else if (persent < swp){
        self.onPlayingView.circleProgressView.persent = 0;
    }
    
    
    [OnPlayingFootView shareOnPlayingFootView].persent = persent;
    
    if ([[LyricHelper sharedLyrcHelper] indexOfTime:second] != -1) {
        
        [self tableviewRow:second];

    }
    
    
    
    NSInteger min = (_currentMusic.duration / 1000- second) / 60;
    NSInteger sec = (NSInteger)(_currentMusic.duration / 1000 - second) % 60;
    
    NSString *secString = [NSString new];
    NSString *minString = [NSString new];
    if (min < 10) {
        minString = [NSString stringWithFormat:@"%ld",min];
    }else{
        minString = [NSString stringWithFormat:@"%ld",min];
    }
    if (sec < 10) {
        secString = [NSString stringWithFormat:@"0%ld",sec];
    }else{
        secString = [NSString stringWithFormat:@"%ld",sec];
    }
    NSString *time = [NSString stringWithFormat:@"- %@:%@",minString,secString];
    self.onPlayingView.durationLabel.text = time;
}

#pragma mark tableView Delegate & dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [LyricHelper sharedLyrcHelper].numberOfLiens;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lrc" forIndexPath:indexPath];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.textColor = kTintColorGreen_1;
    cell.textLabel.text = [[LyricHelper sharedLyrcHelper] stringOfLineAtIndex:indexPath.row];
    cell.textLabel.highlightedTextColor = kTintColorGreen_3;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
//    cell.textLabel.alpha = 0.5;
    cell.selectedBackgroundView = ({
        UIView *view = [UIView new];
        view;
    });
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 35;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    cell.textLabel.font = [UIFont systemFontOfSize:17];
//    cell.textLabel.textColor = kTintColorGreen_3;
//    cell.textLabel.alpha = 1;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
//        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//        cell.textLabel.font = [UIFont systemFontOfSize:17];
//        cell.textLabel.textColor = kTintColorGreen_3;
//        cell.textLabel.alpha = 1;
//    
//}
//
//- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath{
//        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//        cell.textLabel.alpha = 0.5;
//        cell.textLabel.textColor = kTintColorGreen_1;
//        cell.textLabel.font = [UIFont systemFontOfSize:15];
//}
//
////- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
////    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
////    cell.textLabel.alpha = 0.5;
////    cell.textLabel.textColor = kTintColorGreen_1;
////    cell.textLabel.font = [UIFont systemFontOfSize:15];
////}

@end
