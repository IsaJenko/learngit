//
//  MakeTableViewController.h
//  每天美篇
//
//  Created by lanou3g on 15/10/22.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^returnBlock)(ReadModel *read);

@interface MakeTableViewController : UITableViewController
@property (nonatomic, assign) NSInteger Year;
@property (nonatomic, assign) NSInteger Month;
@property (nonatomic, assign) NSInteger Day;
@property (nonatomic, copy) returnBlock returnBlock;


@end
