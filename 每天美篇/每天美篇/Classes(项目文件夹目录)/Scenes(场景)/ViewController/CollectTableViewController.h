//
//  CollectTableViewController.h
//  每天美篇
//
//  Created by lanou3g on 15/10/26.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^returnBlock)(ReadModel *read);

@interface CollectTableViewController : UITableViewController
@property (nonatomic, copy) returnBlock returnBlock;
@property (nonatomic, strong) ReadModel *read;

@end
