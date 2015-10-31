//
//  ComTopicTableViewController.m
//  SlamDunk_Demo
//
//  Created by jinke on 15/10/23.
//  Copyright © 2015年 IsaJenko.github.io. All rights reserved.
//

#import "ComTopicTableViewController.h"

@interface ComTopicTableViewController ()

@end

static NSString *ComTopicCellID = @"comTopicCell";
static NSString *ComTopicHeaderCellID = @"comTopicHeaderCell";

@implementation ComTopicTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    self.navigationController.navigationBar.translucent = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height + 20);
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ComTopicCell" bundle:nil] forCellReuseIdentifier:ComTopicCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"ComTopicHeaderCell" bundle:nil] forCellReuseIdentifier:ComTopicHeaderCellID];

    [DataManager sharedDataManager].callBackBlock = ^() {
        [self.tableView reloadData];
    };
}

- (void) loadData
{
    [[DataManager sharedDataManager] loadCommunityTopicData];
    NSLog(@"社区话题数据加载完成");
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0) {
        return 1;
    }
    return [DataManager sharedDataManager].communityTopicArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        ComTopicHeaderCell *headerCell = [tableView dequeueReusableCellWithIdentifier:ComTopicHeaderCellID forIndexPath:indexPath];
    headerCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return headerCell;
    }else
    {
        ComTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:ComTopicCellID forIndexPath:indexPath];
        
        CommunityTopic *communityTopic = [DataManager sharedDataManager].communityTopicArray[indexPath.row];
        
        cell.communityTopic = communityTopic;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 100;
    }
    
    return 160;
}
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if (section == 0) {
        return 10;
    }
    return 10;
}
@end
