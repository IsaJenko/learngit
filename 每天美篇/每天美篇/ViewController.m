//
//  ViewController.m
//  每天美篇
//
//  Created by lanou3g on 15/10/21.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "ViewController.h"
//屏幕宽高
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
//左侧的辅助view相对主屏幕宽度的百分比，这里设定为0.5
#define SUBVIEW_WIDTH_RATIO .5
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>
{
    UITableView *_sideTableView;
}
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UITextView *contentLabel;


@property (weak, nonatomic) IBOutlet UIView *conView;


@property (nonatomic, assign) BOOL net;
@property (nonatomic, strong) NSDateComponents *conponent;
@property (nonatomic, assign) NSInteger year;
@property (nonatomic, assign) NSInteger month;
@property (nonatomic, assign) NSInteger day;
@property (nonatomic, assign) NSInteger ayear;
@property (nonatomic, assign) NSInteger amonth;
@property (nonatomic, assign) NSInteger aday;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UIAlertController *alert;
@property (nonatomic, assign) CGFloat i;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    LockController *lc = [[LockController alloc] init];
    [self presentViewController:lc animated:YES completion:nil];

    
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor colorWithRed:96 / 255. green:56 / 255. blue:17 / 255. alpha:1.];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor colorWithRed:96 / 255. green:56 / 255. blue:17 / 255. alpha:1.];
    self.contentLabel.delegate = self;
    self.conView.nightBackgroundColor = UIColorFromRGB(0x343434);
    self.view.nightBackgroundColor = UIColorFromRGB(0x343434);
    self.navigationItem.rightBarButtonItem.nightTintColor = UIColorFromRGB(0x444444);
    self.navigationItem.leftBarButtonItem.nightTintColor = UIColorFromRGB(0x444444);
    self.titleLabel.nightTextColor = [UIColor grayColor];
    self.contentLabel.tintColor = [UIColor grayColor];
    self.authorLabel.nightTextColor = [UIColor grayColor];
    
    self.authorLabel.tintColor = [UIColor colorWithRed:100 / 255. green:100 / 255. blue:100 / 255. alpha:1.];
    self.view.backgroundColor = [UIColor colorWithRed:246 / 255. green:224 / 255. blue:180 / 255. alpha:1.];
    self.conView.backgroundColor = [UIColor colorWithRed:246 / 255. green:224 / 255. blue:180 / 255. alpha:1.];
        self.net = YES;

    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesture:)];
    swipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.conView addGestureRecognizer:swipeGesture];
    UISwipeGestureRecognizer *swipeGestureLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesture:)];
    swipeGestureLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.conView addGestureRecognizer:swipeGestureLeft];
    
        [self load];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeSkin:) name:@"skin" object:nil];
    
    UITapGestureRecognizer  *tap1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    tap1.numberOfTapsRequired=1;
    [self.conView addGestureRecognizer:tap1];
    
    UILongPressGestureRecognizer *longGR=[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(smallAction)];
    
    [self.conView addGestureRecognizer:longGR];
    
    self.i = 17;

    
    
}
- (void)smallAction
{
    _i--;
    self.contentLabel.font = [UIFont systemFontOfSize:_i];
}
-(void)tapAction:(UITapGestureRecognizer *)sender{
    if (sender.numberOfTapsRequired==1) {
        _i++;
        self.contentLabel.font = [UIFont systemFontOfSize:_i];
    }
    
}

//- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    [NSObject cancelPreviousPerformRequestsWithTarget:self];
//    UITouch *touch = [touches anyObject];
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        self.i = 17;
//    });
//    if (touch.tapCount == 1) {
//        self.i++;
//        [self performSelector:@selector(bigAction) withObject:nil afterDelay:0.5];
//    }else if (touch.tapCount == 2)
//    {
//        self.i--;
//        
//        [self smallAction];
//    }
//}
//- (void)bigAction
//{
//    self.contentLabel.font = [UIFont systemFontOfSize:_i];
//}
//- (void)smallAction
//{
//    self.contentLabel.font = [UIFont systemFontOfSize:_i];
//}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return NO;
}
// 接收通知
- (void)changeSkin:(NSNotification *)notification
{
    UIColor *color = notification.userInfo[@"color"];
    self.view.backgroundColor = color;
    self.conView.backgroundColor = color;
    

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [_sideTableView dequeueReusableCellWithIdentifier:@"otherCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"otherCell"];
        cell.backgroundColor = [UIColor clearColor];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"row : %ld",(long)indexPath.row];
    return cell;
}


// 设计手势
- (void)swipeGesture:(id)sender
{
    NSInteger year = _year;
    UISwipeGestureRecognizer *swipe = sender;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        self.ayear = self.year;
        self.amonth = self.month;
        self.aday = self.day;
    });
    if (swipe.direction == UISwipeGestureRecognizerDirectionRight) {
        // 轻扫向右做得事情
        if ([DKNightVersionManager currentThemeVersion] == DKThemeVersionNight) {
            
        } else {
            self.alert = [UIAlertController alertControllerWithTitle:nil message:@"前一天" preferredStyle:UIAlertControllerStyleAlert];
            
            [self presentViewController:_alert animated:YES completion:nil];
            
            
            
        }
        self.timer = [NSTimer timerWithTimeInterval:0.8 target:self selector:@selector(disappearAction) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
        BOOL flag = NO;
        while (_year > 0) {
            if (flag == YES) {
                break;
            }
            
            while (_month
                   
                   > 0) {
                
                while (_day > 0) {
                    
                    _day--;
                    if (_day <= 0) {
                        break;
                    }
                    NSString *string = [NSString stringWithFormat:@"%4ld%2ld%2ld",(long)_year,(long)_month,(long)_day];
                    NSString *str = [POST_URL stringByAppendingString:string];
                    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:str]];
                    [self analysis:request];
                    flag = YES;
                    break;
                }
                if (flag == YES) {
                    break;
                }
                _month--;
                if (_month <= 0) {
                    break;
                }
                NSString *string = [NSString stringWithFormat:@"%4ld%2ld%2ld",(long)_year,(long)_month,(long)_day];
                NSString *str = [POST_URL stringByAppendingString:string];
                NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:str]];
                [self analysis:request];
                flag = YES;
                break;
                
            }
            if (flag == YES) {
                break;
            }
            _year--;
            if (_year <= 0) {
                break;
            }
            NSString *string = [NSString stringWithFormat:@"%4ld%2ld%2ld",(long)_year,(long)_month,(long)_day];
            NSString *str = [POST_URL stringByAppendingString:string];
            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:str]];
            [self analysis:request];
            flag = YES;
            break;
        }
        
    }

    if (self.ayear == _year && self.amonth == _month && self.aday == _day) {
        if ([DKNightVersionManager currentThemeVersion] == DKThemeVersionNight) {
            
        } else {
            self.alert = [UIAlertController alertControllerWithTitle:nil message:@"今天的已经看完了，发下手机出去走走" preferredStyle:UIAlertControllerStyleAlert];
            
            [self presentViewController:_alert animated:YES completion:nil];
        }

        self.timer = [NSTimer timerWithTimeInterval:1.5 target:self selector:@selector(disappearAction) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
        return;
    }
    
    if (swipe.direction == UISwipeGestureRecognizerDirectionLeft) {
        // 轻扫向左做的事情
        if ([DKNightVersionManager currentThemeVersion] == DKThemeVersionNight) {
            
        } else {
            self.alert = [UIAlertController alertControllerWithTitle:nil message:@"后一天" preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:_alert animated:YES completion:nil];
        }

        
        
        self.timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(disappearAction) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
        
        
        BOOL flag = NO;
        while (_year <= year){
            while (_month <= 12) {
                
                if (_month == 4 || _month == 6 || _month == 9 || _month == 11){
                    while (_day <= 30) {
                        _day++;
                        if (_day > 30) {
                            break;
                        }
                        NSString *string = [NSString stringWithFormat:@"%4ld%2ld%2ld",(long)_year,(long)_month,(long)
                                            _day];
                        NSString *str = [POST_URL stringByAppendingString:string];
                        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:str]];
                        [self analysis:request];
                        flag = YES;
                        
                    }
                }
                if (_month == 1 || _month == 3 || _month == 5 || _month == 7 || _month == 8 || _month == 10 || _month == 12) {
                    while (_day <= 31) {
          
                        
                        _day++;
                        if (_day > 31) {
                            break;
                        }
                        NSString *string = [NSString stringWithFormat:@"%4ld%2ld%2ld",(long)_year,(long)_month,(long)_day];
                        NSString *str = [POST_URL stringByAppendingString:string];
                        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:str]];
                        [self analysis:request];
                        flag = YES;
                        break;
                    }
                }
                if (_month == 2) {
                    if (((_year % 4 == 0) && (_year % 100 != 0)) || (_year % 400 == 0)) {
                        while (_day <= 29) {
                            _day++;
                            if (_day > 29) {
                                break;
                            }
                            NSString *string = [NSString stringWithFormat:@"%4ld%2ld%2ld",(long)_year,(long)_month,(long)_day];
                            NSString *str = [POST_URL stringByAppendingString:string];
                            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:str]];
                            [self analysis:request];
                            flag = YES;
                            break;
                        }
                    }else{
                        while (_day <= 28) {
                            _day++;
                            if (_day > 28) {
                                break;
                            }
                            NSString *string = [NSString stringWithFormat:@"%4ld%2ld%2ld",(long)_year,(long)_month,(long)_day];
                            NSString *str = [POST_URL stringByAppendingString:string];
                            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:str]];
                            [self analysis:request];
                            flag = YES;
                            break;
                        }
                    }
                }
                if (flag == YES) {
                    break;
                }
                _month++;
                if (_month > 12) {
                    break;
                }
                NSString *string = [NSString stringWithFormat:@"%4ld%2ld%2ld",(long)_year,(long)_month,(long)_day];
                NSString *str = [POST_URL stringByAppendingString:string];
                NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:str]];
                [self analysis:request];
                flag = YES;
                break;
            }
            if (flag == YES) {
                break;
            }
            _year++;
            if (_year > year) {
                break;
            }
            NSString *string = [NSString stringWithFormat:@"%4ld%2ld%2ld",(long)_year,(long)_month,(long)_day];
            NSString *str = [POST_URL stringByAppendingString:string];
            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:str]];
            [self analysis:request];
            flag = YES;
            break;
        }
        
        
    }
    }
- (void)disappearAction
{
    [self.alert dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)insertAction:(UIBarButtonItem *)sender
{
    BOOL fff = NO;
    [[BookDataManager shareManager] open];
    NSArray *array = [[BookDataManager shareManager] selectAllReadModel];
    [[BookDataManager shareManager] close];
    
    
    CollectTableViewController *collectVC = [CollectTableViewController new];
    
    if (array.count == 0)
    {
        [[BookDataManager shareManager] open];
        [[BookDataManager shareManager] createTable];
        [[BookDataManager shareManager] insetReadModel:self.readModel];
        [[BookDataManager shareManager] close];
        [self.navigationController pushViewController:collectVC animated:YES];
    }else
    {
        for (ReadModel *read in array)
        {
            if ([read.title isEqualToString:self.readModel.title])
            {
                fff = YES;
            }
        }
        if (fff == YES)
        {
            
            
            
            
            [self.navigationController pushViewController:collectVC animated:YES];
            
        }
        else
        {
            [[BookDataManager shareManager] open];
            [[BookDataManager shareManager] insetReadModel:self.readModel];
            
            [[BookDataManager shareManager] close];
//            collectVC.returnBlock = ^(ReadModel *read)
//            {
//                
//                self.titleLabel.text = read.title;
//                self.authorLabel.text = read.author;
//                self.contentLabel.text = read.content;
//                NSLog(@"----%@",read.title);
//            };
            
            
            [self.navigationController pushViewController:collectVC animated:YES];
        }
        
        collectVC.returnBlock = ^(ReadModel *read)
        {
            
            self.titleLabel.text = read.title;
            self.authorLabel.text = read.author;
            self.contentLabel.text = read.content;
            NSLog(@"----%@",read.title);
        };
        
    }
}


- (void)times
{
    NSDate *sendDate = [NSDate date];
    NSCalendar * cal = [NSCalendar currentCalendar];
    NSUInteger uniFlags = NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear;
    self.conponent = [cal components:uniFlags fromDate:sendDate];
    self.year = [_conponent year];
    self.month = [_conponent month];
    self.day = [_conponent day];
}

- (NSString *)append
{
    NSString *string = [NSString stringWithFormat:@"%4ld%2ld%2ld",(long)_year,(long)_month,(long)_day];
    NSString *str = [POST_URL stringByAppendingString:string];
    return str;
}
- (void)load
{
    // 获取系统时间
    [self times];
    NSString *str = [self append];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:str]];
    [self analysis:request];
}
- (void)analysis:(NSURLRequest *)request
{
       // 进行数据加载
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (data == nil) {
            self.net = NO;
            [[BookDataManager shareManager] open];
           NSArray *array= [[BookDataManager shareManager] selectAllReadModel];
           
            ReadModel *read = [array lastObject];
            self.titleLabel.text = read.title;
            
            self.authorLabel.text = read.author;
            self.contentLabel.text = read.content;
            [[BookDataManager shareManager] close];
            
        }
        if (self.net == YES){
            self.title = @"";
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            ReadModel *readModel = [ReadModel new];
            readModel.author = dict[@"author"];
            NSString *str = dict[@"content"];
            NSString *str1 = [str stringByReplacingOccurrencesOfString:@"<p>" withString:@"     "];
            NSString *str2 = [str1 stringByReplacingOccurrencesOfString:@"</p>" withString:@""];
            readModel.content = str2;
            readModel.date = dict[@"date"];
            readModel.extra = dict[@"extra"];
            readModel.status = dict[@"stauts"];
            readModel.title = dict[@"title"];
            self.titleLabel.text = readModel.title;
            self.authorLabel.text = readModel.author;
            self.contentLabel.text = readModel.content;
            
            
//            _contentLabel.numberOfLines = 403;
            

            NSLog(@"%@",self.contentLabel.text);
            self.readModel = readModel;
        }
    }];
}
- (IBAction)sideSlideAction:(UIBarButtonItem *)sender
{
    MakeTableViewController *makeVC = [MakeTableViewController new];
//    makeVC.Year = self.year;
//    makeVC.Month = self.month;
//    makeVC.Day = self.day;
    makeVC.returnBlock = ^(ReadModel *read){
        self.titleLabel.text = read.title;
        self.authorLabel.text = read.author;
        self.contentLabel.text = read.content;
    };
    [self.navigationController pushViewController:makeVC animated:YES];
    
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
