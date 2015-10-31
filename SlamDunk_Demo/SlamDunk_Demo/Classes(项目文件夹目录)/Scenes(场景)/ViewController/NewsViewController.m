//
//  NewsViewController.m
//  SlamDunk_Demo
//
//  Created by jinke on 15/10/23.
//  Copyright © 2015年 IsaJenko.github.io. All rights reserved.
//

#import "NewsViewController.h"

@interface NewsViewController () <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *myTabelView;

@end

static NSString *const newsCellID = @"nbaNewsCell";

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    _myTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self loadData];
    
    [self.myTabelView registerNib:[UINib nibWithNibName:@"nbaNewsCell" bundle:nil] forCellReuseIdentifier:newsCellID];
    
    _myTabelView.dataSource = self;
    
    _myTabelView.delegate = self;
    
    [DataManager sharedDataManager].nbaBlock = ^() {
        [self.myTabelView reloadData];
    };
    
    [self setupRefresh];
}

- (void) setupRefresh
{
    self.myTabelView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [[DataManager sharedDataManager] deleteAllNBANews];
        [[DataManager sharedDataManager] loadNBANEWSData];
        [self.myTabelView reloadData];
        [self.myTabelView.header endRefreshing];
    }];
}

- (void) loadData
{
    [[DataManager sharedDataManager] loadNBANEWSData];
    NSLog(@"加载体育新闻数据完成");
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [DataManager sharedDataManager].nbaNewsArray.count;

}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    nbaNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:newsCellID forIndexPath:indexPath];
    
    NBANEWS *nbaNews = [DataManager sharedDataManager].nbaNewsArray[indexPath.row];
    
    cell.nbaNews = nbaNews;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    newsInfoViewController *newsInfoVC = [newsInfoViewController new];
    NBANEWS *nbaNews = [DataManager sharedDataManager].nbaNewsArray[indexPath.row];
    newsInfoVC.nbaNews = nbaNews;
    [self.navigationController pushViewController:newsInfoVC animated:YES];
}
@end
