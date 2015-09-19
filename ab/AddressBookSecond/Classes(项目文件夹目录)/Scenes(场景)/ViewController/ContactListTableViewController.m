//
//  ContactListTableViewController.m
//  AddressBookSecond
//
//  Created by jinke on 15/9/15.
//  Copyright (c) 2015年 . All rights reserved.
//

#import "ContactListTableViewController.h"
#import "ContactCell.h"
#import "AddContactViewController.h"
#import "Contact.h"
#import "DataManager.h"
@interface ContactListTableViewController ()

@end

@implementation ContactListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"通讯录";
         self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addAction:)];
    [self loadData];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}
- (void)loadData
{
    NSInteger count = 10;
    for (int i = 0; i < count;  i ++) {
        NSString *name = [NSString stringWithFormat:@"name_%d",i];
        NSString *phone = [NSString stringWithFormat:@"phone_%d",i];
        NSString *introduce = [NSString stringWithFormat:@"测试数据"];
        Contact *contact = [Contact contactWithName:name phone:phone introduce:introduce];
        NSLog(@"%@",contact);
        [[DataManager sharedDataManager] addContact:contact];
    }
}
- (void) addAction:(UIBarButtonItem *)sender
{
    AddContactViewController *addContactVC = [AddContactViewController new];
    UINavigationController *addContactNC = [[UINavigationController alloc] initWithRootViewController:addContactVC];
    [self presentViewController:addContactNC animated:YES completion:nil];
    
    NSLog(@"推出模态视图");
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return [DataManager sharedDataManager].findAllContact.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"address";
    ContactCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[ContactCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.contact = [[DataManager sharedDataManager] findContactWithIndexPath:indexPath];
    return cell;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[DataManager sharedDataManager] deleteContactWithIndexPath:indexPath];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}



// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    
    
    [[DataManager sharedDataManager] moveDataFromIndexPath:fromIndexPath ToIndexPath:toIndexPath];
    
    
    
    
}


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
