//
//  MakeTableViewController.m
//  每天美篇
//
//  Created by lanou3g on 15/10/22.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "MakeTableViewController.h"

@interface MakeTableViewController ()
@property (nonatomic, strong) ReadModel *read;
@property (nonatomic, strong) SideSlideCell *scell;
@property (nonatomic, strong) NSDateComponents *conponent;

@end

@implementation MakeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:246 / 255. green:224 / 255. blue:180 / 255. alpha:1.];
    self.view.nightBackgroundColor = UIColorFromRGB(0x343434);
    [self.tableView registerNib:[UINib nibWithNibName:@"SideSlideCell" bundle:nil] forCellReuseIdentifier:@"a"];
    NSDate *sendDate = [NSDate date];
    NSCalendar * cal = [NSCalendar currentCalendar];
    NSUInteger uniFlags = NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear;
    self.conponent = [cal components:uniFlags fromDate:sendDate];
    self.Year = [_conponent year];
    self.Month = [_conponent month];
    self.Day = [_conponent day];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    self.scell = [tableView dequeueReusableCellWithIdentifier:@"a" forIndexPath:indexPath];
    _scell.backgroundColor = [UIColor colorWithRed:246 / 255. green:224 / 255. blue:180 / 255. alpha:1.];
    _scell.nightBackgroundColor = UIColorFromRGB(0x343434);
    if (indexPath.row == 0) {
        _scell.imageView.image = [UIImage imageNamed:@"today"];
        _scell.nameLabel.text = @"今日文章";
    }else if (indexPath.row == 1){
        _scell.imageView.image = [UIImage imageNamed:@"suiji"];
        _scell.nameLabel.text = @"随机一篇";
    }else if (indexPath.row == 2)
    {
        
        if ([DKNightVersionManager currentThemeVersion] == DKThemeVersionNight) {
            
            _scell.imageView.image = [UIImage imageNamed:@"sun"];
            _scell.nameLabel.text = @"日间模式";
            NSLog(@"aaaa");
        } else {
            _scell.imageView.image = [UIImage imageNamed:@"moon"];
            _scell.nameLabel.text = @"夜间模式";
            NSLog(@"bbb");
        }


    }else
    {
        _scell.imageView.image = [UIImage imageNamed:@"22"];
        _scell.nameLabel.text = @"分享";
    }
    
    
    return _scell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        NSString *string = [NSString stringWithFormat:@"%4ld%2ld%2ld",(long)_Year,(long)_Month,(long)_Day];
        
        NSString *str = [POST_URL stringByAppendingString:string];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:str]];
        
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
            
            
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
            self.read = readModel;
            if (self.returnBlock != nil) {
                self.returnBlock(self.read);
            }
            
            [self.navigationController popViewControllerAnimated:YES];
        }];

       
    }else if (indexPath.row == 1)
    {
        self.Day = arc4random()%(self.Day - 14) + 14;
        NSString *string = [NSString stringWithFormat:@"%4ld%2ld%2ld",_Year,(long)_Month,(long)_Day];
        
        NSString *str = [POST_URL stringByAppendingString:string];
        NSLog(@"%@",str);
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:str]];
        
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
            
            
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
            self.read = readModel;
            if (self.returnBlock != nil) {
                self.returnBlock(self.read);
            }

            [self.navigationController popViewControllerAnimated:YES];

        }];
           }else if (indexPath.row == 2)
    {


        
        if ([DKNightVersionManager currentThemeVersion] == DKThemeVersionNight) {
            [DKNightVersionManager dawnComing];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [DKNightVersionManager nightFalling];
            [self.navigationController popViewControllerAnimated:YES];
            
        }

    }
    else
    {
        
        
        NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"ShareSDK" ofType:@"jpg"];
        id<ISSContent> publihContent = [ShareSDK content:@"要分享的内容" defaultContent:@"默认的内容" image:[ShareSDK imageWithPath:imagePath] title:@"每天美篇" url:@"http://www.meiriyiwen.com/random/iphone" description:@"这是一条演示信息" mediaType:SSPublishContentMediaTypeNews];
        id<ISSContainer> container = [ShareSDK container];
        [container setIPadContainerWithView:self.view arrowDirect:UIPopoverArrowDirectionUp];
        [ShareSDK showShareActionSheet:container shareList:nil content:publihContent statusBarTips:YES authOptions:nil shareOptions:nil result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
            if (state == SSResponseStateSuccess) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享成功" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }else if (state == SSResponseStateFail)
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败" message:[NSString stringWithFormat:@"失败描述:%@",[error errorDescription]] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
        }];
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
