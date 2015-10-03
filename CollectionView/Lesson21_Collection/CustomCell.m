//
//  CustomCell.m
//  Lesson21_Collection
//
//  Created by jinke on 15/9/30.
//  Copyright (c) 2015年 IsaJenko.github.io. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell
- (instancetype)initWithFrame:(CGRect)frame
{
    // super: 编译器指令，指向父类发送消息
    self = [super initWithFrame:frame];
    // 1.初始化子类和父类共有的实例变量（子类继承下来的实例变量）
    // 2.接受初始化结果
            // 1.如果一个类的父类不存在，返回结果为nil，实例变量的初始化将不会执行。（不允许初始化无父类的实例变量）
            // 2.如果一个类的父类在对内存中数据进行初始化的时候失败，子类并没有意义去初始化实例变量。（不做无意义的计算）
    if (self) {
        [self addAllViews];
    }
    return self;
}
- (void) addAllViews
{
    
    [self.contentView addSubview:self.imgView];
    
}
- (UIImageView *)imgView
{
    if (!_imgView) {
        self.imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1106288470734ad914l.jpg"]];
    }
    return _imgView;
}
// 重写视图布局方法
- (void)layoutSubviews
{
    // collectionView向重用池取出cell的时候，因为cell的尺寸不一致，无法判定取出的cell的尺寸是否正确（同种cell同一个重用标识符导致的现象），重写layoutSubviews可以在每次绘制cell的时候，将当前collectionView的尺寸重新赋值给cell，保证cell尺寸绘制正确。
    [super layoutSubviews];
    self.imgView.frame = self.contentView.bounds;
}
@end
