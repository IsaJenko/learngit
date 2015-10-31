//
//  ComPictureTableViewController.m
//  SlamDunk_Demo
//
//  Created by jinke on 15/10/23.
//  Copyright © 2015年 IsaJenko.github.io. All rights reserved.
//

#import "ComPictureTableViewController.h"

@interface ComPictureTableViewController ()


@end

static NSString *const ComPictureCellID = @"comPictureCell";

@implementation ComPictureTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;

    [self loadData];
    
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.translucent = NO;
    self.tableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ComPictureCell" bundle:nil] forCellReuseIdentifier:ComPictureCellID];
    
    [DataManager sharedDataManager].pictureBlock = ^() {
        [self.tableView reloadData];
    };
    
//    self.navigationController.navigationBarHidden = YES;
//    self.tabBarController.tabBar.hidden = YES;
    
    [self setupDownRefresh];
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tableView.contentOffset = CGPointMake(0, 0);
}
- (void) setupDownRefresh
{
    
self.tableView.footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
    CommunityGM *communityGM = [CommunityGM new];
  communityGM = [DataManager sharedDataManager].communityPictureArray.lastObject;
    
    [[DataManager sharedDataManager] refreshCommunityPictureDataWithID:communityGM.ID];
    [self.tableView reloadData];
    [self.tableView.footer endRefreshing];
}];
    
        self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //重新请求最新数据
        [[DataManager sharedDataManager] deleteAllData];
        [[DataManager sharedDataManager] loadCommunityPictureData];
        [self.tableView reloadData];
        [self.tableView.header endRefreshing];
    }];
}
- (void) loadData
{
    [[DataManager sharedDataManager] loadCommunityPictureData];
    NSLog(@"加载晒图数据完成");
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [DataManager sharedDataManager].communityPictureArray.count;
}

//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    self.navigationController.navigationBarHidden = YES;
//}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ComPictureCell *cell = [tableView dequeueReusableCellWithIdentifier:ComPictureCellID forIndexPath:indexPath];
    
    CommunityGM *communityGM = [DataManager sharedDataManager].communityPictureArray[indexPath.row];
    
    cell.communityGM = communityGM;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 600;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ComPictureInfoViewController *comPictureVC = [ComPictureInfoViewController new];
    CommunityGM *communityGM = [DataManager sharedDataManager].communityPictureArray[indexPath.row];
    comPictureVC.communityGM = communityGM;
    [self presentViewController:comPictureVC animated:YES completion:nil];
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat change = 100 / scrollView.contentOffset.y;
//    NSLog(@"%f",change);
    if (change < 0.3 && change > 0) {
        change = 0 ;
    }
    if (change >= 0) {
        self.tabBarController.tabBar.alpha = change;
    }else{
        self.tabBarController.tabBar.alpha = 1;
    }
    
}

@end
