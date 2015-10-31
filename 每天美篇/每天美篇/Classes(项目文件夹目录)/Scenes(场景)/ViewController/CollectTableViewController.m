//
//  CollectTableViewController.m
//  每天美篇
//
//  Created by lanou3g on 15/10/26.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "CollectTableViewController.h"

@interface CollectTableViewController ()
@property (nonatomic, strong) NSArray * array;
@end

@implementation CollectTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的收藏";
    self.view.backgroundColor = [UIColor colorWithRed:246 / 255. green:224 / 255. blue:180 / 255. alpha:1.];
    self.view.nightBackgroundColor = UIColorFromRGB(0x343434);

    
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[BookDataManager shareManager] open];
    self.array = [[BookDataManager shareManager] selectAllReadModel];
    [[BookDataManager shareManager] close];

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
    
    
    return self.array.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    self.read = _array[indexPath.row];
    NSLog(@"%@",self.read.title);
    if (self.returnBlock != nil) {
    
        self.returnBlock(self.read);
        
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.read = _array[indexPath.row];
    [[BookDataManager shareManager] open];
    [[BookDataManager shareManager] deleteWithReadModel:_read.number];
    _array = [[BookDataManager shareManager] selectAllReadModel];
    [[BookDataManager shareManager] close];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *const cellId = @"accc";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    
    cell.backgroundColor = [UIColor colorWithRed:246 / 255. green:224 / 255. blue:180 / 255. alpha:1.];
    cell.nightBackgroundColor = UIColorFromRGB(0x343434);

    ReadModel *read = _array[indexPath.row];
    cell.textLabel.text = read.title;
    
    return cell;
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
