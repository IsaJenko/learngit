//
//  PersonListViewController.m
//  MVCbook
//
//  Created by jinke on 15/9/12.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "PersonListViewController.h"
#import "PersonListView.h"
#import "AddPersonViewController.h"
//#import "Person.h"
#import "InfoViewController.h"
@interface PersonListViewController () <AddPersonViewControllerDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) PersonListView *personListView;
@property (nonatomic,strong) NSMutableDictionary *allDataDictionary;
@property (nonatomic,strong) Person *LVperson;
@end

@implementation PersonListViewController
- (void)loadView
{
    self.personListView = [[PersonListView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.personListView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"通讯录";
    
    self.personListView.tableView.dataSource = self;
    self.personListView.tableView.delegate = self;
    
    // 更新数据
//    [self loadData];
    
    // 添加 添加联系人按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addPerson:)];
    
    // 添加编辑按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editPerson:)];
}
- (void) editPerson:(UIBarButtonItem *)sender
{
    if (self.personListView.tableView.editing == YES) {
        sender.title = @"编辑";
    }
    else
    {
        sender.title = @"完成";
    }
    //设置取反状态
    [self.personListView.tableView setEditing:!self.personListView.tableView.editing animated:YES];
}

// 设置哪些行可以编辑 默认是所有 canEditRowAtIndexPath
// 设置编辑样式 默认是删除 editingStyleForRowAtIndexPath
#pragma mark - 处理编辑过程
- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 获取key值
    NSString *key = self.allDataDictionary.allKeys[indexPath.section];
    // 获取存放Person的数组
    NSMutableArray *arr = self.allDataDictionary[key];
    // 判断元素是否是一个，如果是一个直接删除该分组
    if (arr.count == 1) {
        // 删除分组
        [self.allDataDictionary removeObjectForKey:key];//更新数据
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:indexPath.section];//更新页面
        [tableView deleteSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    }else{
        // 删除行
        [arr removeObjectAtIndex:indexPath.row];//更新数据
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];//更新页面
    }
}
#pragma mark - 设置可以移动
- (BOOL) tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
#pragma mark - 处理移动过程
- (void) tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    // 获取key值
NSString *key = self.allDataDictionary.allKeys[sourceIndexPath.section];
    // 获取数组
    NSMutableArray *arr = self.allDataDictionary[key];
    // 获取元素
    Person *p = arr[sourceIndexPath.row];
    // 删除元素
    [arr removeObject:p];
    // 插入到目标位置
    [arr insertObject:p atIndex:destinationIndexPath.row];
}
#pragma mark - 设置禁止跨分区移动
- (NSIndexPath *) tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
    if (sourceIndexPath.section == proposedDestinationIndexPath.section) {
        return proposedDestinationIndexPath;
    }else{
        return sourceIndexPath;
    }
}




#pragma mark - 添加联系人
- (void) loadData
{
    // 1.懒加载 添加联系人
    NSString *key = [[_LVperson.PersonName substringToIndex:1] uppercaseString];
    
    if ([self.allDataDictionary valueForKey:key] == nil) {
        NSMutableArray *personArr = [NSMutableArray new];
        [self.allDataDictionary setValue:personArr forKey:key];
    }
    [[self.allDataDictionary valueForKey:key] addObject:_LVperson];
}
- (void) addPerson:(UIBarButtonItem *)sender
{
    AddPersonViewController *addPersonVC = [AddPersonViewController new];
    addPersonVC.delegate = self;
    [self.navigationController pushViewController:addPersonVC animated:YES];
}
- (void)getPerson:(Person *)person
{
    _LVperson = person;
    [self loadData];
    [self.personListView.tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 设置分组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.allDataDictionary.count;
}
// 设置行数
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.allDataDictionary[self.allDataDictionary.allKeys[section]] count];
}
// 设置显示内容
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.声明重用标识符，只初始化一次
    static NSString *cellID = @"abc";
    // 2.从重用队列中查找cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    // 3.如果不存在，则创建新的
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    
    // 使用
    NSString *key = self.allDataDictionary.allKeys[indexPath.section];
    NSArray *array = self.allDataDictionary[key];
    Person *p = array[indexPath.row];
    

    // 4.新的
    cell.textLabel.text = p.PersonName;
    cell.detailTextLabel.text = p.PhoneNumber;
    // 设置行中右边的符号
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    // 5.返回
    return cell;
}

// 设置分组区头显示信息
- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
     return [_allDataDictionary allKeys][section];
}

// 点击列表上行的时候，点击事件，代理方法
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES ];
    InfoViewController *infoVC = [InfoViewController new];
    // 获取key值
    NSString *key = self.allDataDictionary.allKeys[indexPath.section];
    // 获取数组
    NSMutableArray *arr = self.allDataDictionary[key];
    // 获取元素
    Person *p = arr[indexPath.row];
    // 属性传值
    infoVC.person = p;
    
    [self.navigationController pushViewController:infoVC animated:YES];
    
}
#pragma mark - 懒加载 重写getter方法
- (NSMutableDictionary *) allDataDictionary
{

    if (_allDataDictionary == nil) {
        
        self.allDataDictionary = [NSMutableDictionary dictionary];
    }
    return _allDataDictionary;
}
@end
