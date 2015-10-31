//
//  MusicPlayerViewController.m
//  J_music
//
//  Created by jinke on 15/10/13.
//  Copyright © 2015年 IsaJenko.github.io. All rights reserved.
//

#import "MusicPlayerViewController.h"

@interface MusicPlayerViewController () <PlayerManagerDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSInteger _currentIndex; // 保存当前下标
    Music *_currentMusic; // 保存当前音乐模型
}
#pragma mark - 声明属性
@property (weak, nonatomic) IBOutlet UILabel *songNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *singerNameLabel;
@property (weak, nonatomic) IBOutlet UISlider *timeSlider;
@property (weak, nonatomic) IBOutlet UISlider *soundSlider;
@property (weak, nonatomic) IBOutlet UITableView *lyricTableView;
@property (weak, nonatomic) IBOutlet UILabel *minuteLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;

#pragma  mark - 声明方法
- (IBAction)toMusicListButton:(UIButton *)sender;
- (IBAction)playOrPause:(id)sender;
- (IBAction)last:(UIButton *)sender;
- (IBAction)next:(UIButton *)sender;
- (IBAction)timeSlider:(UISlider *)sender;
- (IBAction)soundSlider:(UISlider *)sender;
@property (weak, nonatomic) IBOutlet UIButton *playOrPauseButton;
@property (weak, nonatomic) IBOutlet UIImageView *songImageView;
- (IBAction)musicClassifyButton:(UIButton *)sender;


@end

@implementation MusicPlayerViewController

+ (instancetype) sharedMusicPlayer
{
    static MusicPlayerViewController *musicPlayerVC = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        musicPlayerVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"musicPlayer"];
    });
    return musicPlayerVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _currentIndex = -2; // 防止第一次下标为空
    self.soundSlider.value = [PlayerManager sharedPlayerManager].sound;
    [PlayerManager sharedPlayerManager].delegate = self;
    [self.timeSlider setThumbImage:[UIImage imageNamed:@"icon_slider_3"] forState:UIControlStateNormal];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (_index == -1) {
        return;
    }
    if (_currentIndex == _index) {
        return;
    }
    self.songImageView.transform = CGAffineTransformMakeRotation(0);
    // 保存当前下标
    _currentIndex = _index;
    // 根据下表获取模型，显示信息，并播放音乐
    [self prepareForPlaying];
}
- (void) prepareForPlaying
{
    // 根据下标，获取模型
    _currentMusic = [MusicManager sharedMusicManager].allMusic[_currentIndex];
    // 显示信息
    [self showInfo];
    // 加载歌词
    [[LyricManager sharedLyricManager] loadLyricWithString:_currentMusic.lyric];
    [self.lyricTableView reloadData];
    
    int  time  =  [_currentMusic.duration intValue] / 1000;
    self.minuteLabel.text = [NSString stringWithFormat:@"%0.2d:%0.2d",time / 60,time % 60];
    
    // 播放歌曲
    [[PlayerManager sharedPlayerManager] playingWithURLstr:_currentMusic.mp3Url];
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (self.index == -1) {
        return;
    }
    [[PlayerManager sharedPlayerManager] play];
}
- (void) showInfo
{
    _songNameLabel.text = _currentMusic.name;
    _singerNameLabel.text = [NSString stringWithFormat:@"- %@ -",_currentMusic.singer];
    [_songImageView sd_setImageWithURL:[NSURL URLWithString:_currentMusic.picUrl]];
    // 修改时间滑杆的最大值
    _timeSlider.maximumValue = [_currentMusic.duration doubleValue] / 1000;
    [self.playOrPauseButton setImage:[UIImage imageNamed:@"iconpause"] forState:UIControlStateNormal];
}


- (IBAction)toMusicListButton:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)playOrPause:(id)sender {
    NSLog(@"点击");
    if ([PlayerManager sharedPlayerManager].isPlaying == YES) {
        [[PlayerManager sharedPlayerManager] pause];
        [self.playOrPauseButton setImage:[UIImage imageNamed:@"icon_play"] forState:UIControlStateNormal];
    }else{
        [[PlayerManager sharedPlayerManager] play];
        [self.playOrPauseButton setImage:[UIImage imageNamed:@"iconpause"] forState:UIControlStateNormal];
    }
}

- (IBAction)last:(UIButton *)sender {
    self.songImageView.transform = CGAffineTransformMakeRotation(0);
    
    switch ([PlayerManager sharedPlayerManager].playType) {
        case 0: // 随机播放
        {
            NSInteger num = [MusicManager sharedMusicManager].allMusic.count;
            _currentIndex = arc4random() % num + 1;
            break;
        }
        case 1: // 顺序播放
        {
            _currentIndex --;
            if (_currentIndex < 0) {
                _currentIndex = [MusicManager sharedMusicManager].allMusic.count - 1;
            }
            break;
        }
        case 2: // 单曲播放
        {
            break;
        }
        default:
            break;
    }
    [self prepareForPlaying];
}

- (IBAction)next:(UIButton *)sender {
    self.songImageView.transform = CGAffineTransformMakeRotation(0);
    [[PlayerManager sharedPlayerManager] pause];
    

    switch ([PlayerManager sharedPlayerManager].playType) {
        case 0: // 随机播放
        {
            NSInteger num = [MusicManager sharedMusicManager].allMusic.count;
           _currentIndex = arc4random() % num + 1;
            break;
        }
        case 1: // 循环播放
        {
            _currentIndex ++;
            if (_currentIndex == [MusicManager sharedMusicManager].allMusic.count) {
                _currentIndex = 0;
            }
            break;
        }
        case 2: // 单曲播放
        {
           break;
        }
        default:
            break;
    }
        [self prepareForPlaying];
    [[PlayerManager sharedPlayerManager] play];
}

- (IBAction)timeSlider:(UISlider *)sender {
    [[PlayerManager sharedPlayerManager] seekToTime:sender.value];
}

- (IBAction)soundSlider:(UISlider *)sender {
    [PlayerManager sharedPlayerManager].sound = sender.value;
}
#pragma mark - PlayerManagerDelegate
- (void)playingWithTime:(NSTimeInterval)time
{
    _timeSlider.value = time;
    
    int min = time / 60;
    int sec = (int)time % 60;
    
    self.secondLabel.text = [NSString stringWithFormat:@"%0.2d:%0.2d",min,sec];
    
    self.songImageView.transform = CGAffineTransformRotate(self.songImageView.transform, M_PI_2 / 180);
    
    NSInteger index = [[LyricManager sharedLyricManager] lyricIndexWithTime:time];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self.lyricTableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
}
- (void)didStop
{
    [self next:nil];
}
#pragma mark - UITableViewDelegate && UITableViewDataSource

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [LyricManager sharedLyricManager].allLyricData.count;
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"lyricCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.highlightedTextColor = [UIColor blueColor];
        
        cell.selectedBackgroundView = ({
            UIView *view = [UIView new];
            view;
        });
    }
    cell.textLabel.text = [[LyricManager sharedLyricManager] lyricStringWithIndexPath:indexPath];
    return cell;
}
// 弹出选择播放模式
- (IBAction)musicClassifyButton:(UIButton *)sender {
    
    UIAlertController *alertController = nil;
    
    alertController = [UIAlertController alertControllerWithTitle:@"Jenko Music" message:@"请选择播放模式" preferredStyle:UIAlertControllerStyleActionSheet];
    
    // 添加播放模式按钮
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"随机播放" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [PlayerManager sharedPlayerManager].playType = 0;
        NSLog(@"随机播放");
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"循环播放" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [PlayerManager sharedPlayerManager].playType = 1;
        NSLog(@"循环播放");
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"单曲播放" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [PlayerManager sharedPlayerManager].playType = 2;
        NSLog(@"单曲播放");
    }];
    UIAlertAction *action4 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"取消");
    }];

    [alertController addAction:action1];
    [alertController addAction:action2];
    [alertController addAction:action3];
    [alertController addAction:action4];
    
    [self presentViewController:alertController animated:YES completion:nil];
}
@end
