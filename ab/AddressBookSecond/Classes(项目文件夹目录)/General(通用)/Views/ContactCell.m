//
//  ContactCell.m
//  AddressBookSecond
//
//  Created by jinke on 15/9/15.
//  Copyright (c) 2015年 . All rights reserved.
//

#import "ContactCell.h"
#import "Contact.h"
@implementation ContactCell
- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addAllViews];
    }
    return self;
}
- (void) addAllViews
{
    CGFloat margin = 10;
    CGSize cellSize = self.bounds.size;
    CGFloat height = 35;
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, margin, cellSize.width / 2, height)];
    _nameLabel.text = @"姓名";
    [self.contentView addSubview:_nameLabel];
    
    self.phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin + cellSize.width / 2, margin, cellSize.width / 2, height)];
    _phoneLabel.text = @"电话";
    [self.contentView addSubview:_phoneLabel];
    
    self.introduceLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, _nameLabel.frame.origin.y + margin * 4, cellSize.width, height * 2)];
    _introduceLabel.text = @"如果有一天，我吃胖了";
    [self.contentView addSubview:_introduceLabel];
}
- (void)awakeFromNib {
    // Initialization code
}
- (void)setContact:(Contact *)contact
{
    _nameLabel.text = contact.name;
    _phoneLabel.text = contact.phone;
    _introduceLabel.text = contact.introduce;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
