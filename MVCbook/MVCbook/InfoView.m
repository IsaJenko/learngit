//
//  InfoView.m
//  MVCbook
//
//  Created by jinke on 15/9/12.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import "InfoView.h"
#import "Person.h"
@implementation InfoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addAllViews];
    }
    return self;
}
- (void) addAllViews
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, 50, 40)];
    label.text = @"姓名";
    [self addSubview:label];
    
    self.backgroundColor = [UIColor whiteColor];
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 150, 40)];
    _nameLabel.text = _person.PersonName;
    
    [self addSubview:_nameLabel];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 150, 50, 40)];
    label1.text = @"电话";
    [self addSubview:label1];
    
    self.numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 150, 150, 40)];
    _numberLabel.text = _person.PhoneNumber;
    
    [self addSubview:_numberLabel];

}
@end
