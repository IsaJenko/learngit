//
//  MusicListTableViewController.m
//  J_music
//
//  Created by jinke on 15/10/13.
//  Copyright © 2015年 IsaJenko.github.io. All rights reserved.
//

#import "MusicListTableViewController.h"

@interface MusicListTableViewController () <UISearchResultsUpdating>

@property (nonatomic,strong) NSMutableArray *searchResultDataArray; // 存放搜索出结果的数组
@property (nonatomic,strong) UISearchController *searchController; // 搜索控制器
@property (nonatomic, retain) UITableViewController *searchTVC;  //搜索使用的表视图控制器

@end

static NSString * const cellID = @"musicCell";

@implementation MusicListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [MusicManager sharedMusicManager].result = ^(){
        
        [self.tableView reloadData];
        
    };
    // 搜索按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchBarButtonItemAction:)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 注册
    [self.tableView registerNib:[UINib nibWithNibName:@"MusicCell" bundle:nil] forCellReuseIdentifier:cellID];
    
       UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"a1fceaf3334d69f37665fe42e524a0d9.jpeg"]];
    
    //毛玻璃效果
    UIVisualEffectView *visualView = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:(UIBlurEffectStyleLight)]];
    visualView.frame = self.tableView.bounds;
    visualView.alpha = 0.8;
    [imageView addSubview:visualView];
    self.tableView.backgroundView = imageView;
}
// 搜索按钮点击事件
- (void) searchBarButtonItemAction:(UIBarButtonItem *)sender
{
    self.searchTVC = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
    _searchTVC.tableView.dataSource = self;
    _searchTVC.tableView.delegate = self;
    [_searchTVC.tableView registerNib:[UINib nibWithNibName:@"MusicCell" bundle:nil] forCellReuseIdentifier:cellID];

    self.searchController = [[UISearchController alloc] initWithSearchResultsController:_searchTVC];
    
    _searchController.searchResultsUpdater = self;
    _searchController.searchBar.placeholder = @"请输入您要搜索的歌曲信息";
    _searchController.searchBar.prompt = @"输入歌曲或歌手名称";
    
    [self presentViewController:_searchController animated:YES completion:nil];
}
- (IBAction)toMusic:(UIButton *)sender {
    MusicPlayerViewController *musicPlayerVC = [MusicPlayerViewController sharedMusicPlayer];
    musicPlayerVC.index = -1;
    [self showDetailViewController:musicPlayerVC sender:nil];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return (tableView == self.tableView ? [MusicManager sharedMusicManager].allMusic.count : _searchResultDataArray.count);
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MusicCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    Music *music = (tableView == self.tableView ? [MusicManager sharedMusicManager].allMusic[indexPath.row] : _searchResultDataArray[indexPath.row]);
    
    cell.music = music;
    
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MusicPlayerViewController *musicPlayerVC = [MusicPlayerViewController sharedMusicPlayer];
    if (tableView == self.tableView) {
        musicPlayerVC.index = indexPath.row;
    }else{
        Music *music = self.searchResultDataArray[indexPath.row];
        for (int i = 0; i < [MusicManager sharedMusicManager].allMusic.count; i ++) {
            Music *m = [MusicManager sharedMusicManager].allMusic[i];
            if ([m.name isEqualToString:music.name]) {
                int index;
                index = i;
                musicPlayerVC.index = index;
            }
        }
    }
    [self showDetailViewController:musicPlayerVC sender:nil];
}
#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString *conditionStr = searchController.searchBar.text;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.name CONTAINS [CD] %@ OR self.singer CONTAINS [CD] %@", conditionStr, conditionStr];
    
    self.searchResultDataArray = [NSMutableArray arrayWithArray:[[MusicManager sharedMusicManager].allMusic filteredArrayUsingPredicate:predicate]];
    [_searchTVC.tableView reloadData];
    
    
    
}
@end
