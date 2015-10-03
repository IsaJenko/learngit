//
//  RootViewController.m
//  Lesson21_Collection
//
//  Created by jinke on 15/9/30.
//  Copyright (c) 2015年 IsaJenko.github.io. All rights reserved.
//

#import "RootViewController.h"
#import "CustomCell.h"
@interface RootViewController () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@end

@implementation RootViewController
static NSString * const customReuseIdentifier = @"customID";
// 定义cell重用标识符
static NSString * const cellReuseIdentifier = @"systemID";
// 定义增补视图重用标识符
static NSString * const headerReuseID = @"header";
static NSString * const footerReuseID = @"footer";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    // 设置item大小
    flowLayout.itemSize = CGSizeMake(70, 70);
    // 横向item之间的最小距离
//    flowLayout.minimumInteritemSpacing = 30;
    // 竖向item之间的最小距离
//    flowLayout.minimumLineSpacing = 30;
    // 上左下右
    flowLayout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
    // 增补视图
    flowLayout.headerReferenceSize = CGSizeMake(0, 100);
    flowLayout.footerReferenceSize = CGSizeMake(0, 200);
//    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:flowLayout];
    
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerClass:[CustomCell class] forCellWithReuseIdentifier:customReuseIdentifier];
    // 注册
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellReuseIdentifier];
    // 注册增补视图
    // 区头
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerReuseID];
    // 区尾
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerReuseID];
    
    
    [self.view addSubview:collectionView];
    
    self.view.backgroundColor = [UIColor blackColor];

}
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 10;
}
- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item%2 == 0 ) {
        return CGSizeMake(100, 100);
    }
    return CGSizeMake(70, 70);
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}
- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerReuseID forIndexPath:indexPath];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(150, 50, 150, 30)];
    label.text = @"This is header";
    [header addSubview:label];
    header.backgroundColor = [UIColor redColor];
    
    UICollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerReuseID forIndexPath:indexPath];
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(150, 50, 150, 30)];
    label1.text = @"This is footer";
    [footer addSubview:label1];
    footer.backgroundColor = [UIColor magentaColor];
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        return header;
    }else{
        return footer;
    }
}
- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CustomCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:customReuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor blackColor];
//    cell.layer.cornerRadius = cell.frame.size.width / 2;
//    cell.layer.masksToBounds = YES;
    if (indexPath.item%2 == 0) {
        cell.imgView.image = [UIImage imageNamed:@"1106288470734ad914l.jpg"];
    }else
    {
    cell.imgView.image = [UIImage imageNamed:@"7a5ff4f2412df2b3a00b81593675df80.jpeg"];
    }
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
