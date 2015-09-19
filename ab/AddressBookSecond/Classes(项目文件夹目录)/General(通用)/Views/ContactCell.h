//
//  ContactCell.h
//  AddressBookSecond
//
//  Created by jinke on 15/9/15.
//  Copyright (c) 2015年 . All rights reserved.
//

#import <UIKit/UIKit.h>
@class Contact;
@interface ContactCell : UITableViewCell
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *phoneLabel;
@property (nonatomic,strong) UILabel *introduceLabel;
@property (nonatomic,strong) Contact *contact;
@end
