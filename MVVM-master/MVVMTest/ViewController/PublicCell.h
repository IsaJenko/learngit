//
//  PublicCell.h
//  MVVMTest
//
//  Created by Jenko on 15/1/8.
//  Copyright (c) 2015年 Jenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PublicModel.h"

@interface PublicCell : UITableViewCell

-(void) setValueWithDic : (PublicModel *) publicModel;

@end
