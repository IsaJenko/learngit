//
//  MusicListTableViewController.m
//  PlayerByCoding
//
//  Created by LakesMac on 15/10/10.
//  Copyright © 2015年 Lake. All rights reserved.
//

#import "MusicListTableViewController.h"
#import "MusicListTableViewCell.h"

#import "OnPlayingViewController.h"


@interface MusicListTableViewController ()


@end

@implementation MusicListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = ({
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        title.text = @"音乐";
        title.textAlignment = NSTextAlignmentCenter;
        title.textColor = [UIColor whiteColor];
        title.font = [UIFont systemFontOfSize:20];
        title;
    });
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MusicListTableViewCell" bundle:nil] forCellReuseIdentifier:@"MusicListCell"];
    self.tableView.backgroundColor = kTintColorGreen_1;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [Data_MusicList shareData_MusicList].resultComplete = ^{
        self.navigationItem.rightBarButtonItem.enabled = YES;
        [self.tableView reloadData];
    };
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"正在播放" style:(UIBarButtonItemStyleDone) target:self action:@selector(action:)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
}

- (void)action:(id)sender{
    if ([OnPlayingFootView shareOnPlayingFootView].isShow) {
        [[OnPlayingFootView shareOnPlayingFootView] hidden];
    }else{
        [[OnPlayingFootView shareOnPlayingFootView] show];

    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [Data_MusicList shareData_MusicList].numberOfItems;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MusicListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MusicListCell" forIndexPath:indexPath];
    
    cell.model = [[Data_MusicList shareData_MusicList] modelAtIndex:indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OnPlayingViewController *onplayingVC = [OnPlayingViewController sharedOnPlayingViewController];
    
    [onplayingVC setIndex:indexPath.row];
    
    [[OnPlayingFootView shareOnPlayingFootView] hidden];
    [OnPlayingFootView shareOnPlayingFootView].touchUpInside = ^{
        [[OnPlayingFootView shareOnPlayingFootView] hidden];
        onplayingVC.Index = -1;
        [self presentViewController:onplayingVC animated:YES completion:^{
            
        }];
    };
    [self presentViewController:onplayingVC animated:YES completion:nil];
    
//    [tableView deselectRowAtIndexPath:indexPath animated:NO];
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
