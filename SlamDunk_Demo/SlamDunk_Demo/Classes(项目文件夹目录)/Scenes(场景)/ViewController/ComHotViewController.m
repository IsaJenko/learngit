//
//  ComHotViewController.m
//  SlamDunk_Demo
//
//  Created by jinke on 15/10/24.
//  Copyright © 2015年 IsaJenko.github.io. All rights reserved.
//

#import "ComHotViewController.h"

@interface ComHotViewController () <UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong) UICollectionView *myCollectionView;
@property (nonatomic,assign) NSInteger page;

@end

@implementation ComHotViewController

// 定义cell重用标识符
static NSString * const cellReuseIdentifier = @"systemID";
// 定义增补视图重用标识符
static NSString * const headerReuseID = @"header";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
//    self.tabBarController.tabBar.hidden = YES;
    _page = 0;
    self.automaticallyAdjustsScrollViewInsets = NO;

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(150, 280);
    flowLayout.sectionInset = UIEdgeInsetsMake(120, 20, 40, 20);
    flowLayout.headerReferenceSize = CGSizeMake(0, 100);
    flowLayout.minimumLineSpacing = 30;
    
    self.myCollectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:flowLayout];
    
    [DataManager sharedDataManager].hotBlock = ^() {
        [_myCollectionView reloadData];
    };
    
    _myCollectionView.delegate = self;
    _myCollectionView.dataSource = self;
    
    [_myCollectionView registerClass:[ComHotCell class] forCellWithReuseIdentifier:cellReuseIdentifier];
    [_myCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerReuseID];
    
    [self.view addSubview:_myCollectionView];
    
    [self refreshData];
    
}

- (void) refreshData
{
   
    self.myCollectionView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //刷新数据
        ComGMRank_id *comGMrank_id = [ComGMRank_id new];
        comGMrank_id = [DataManager sharedDataManager].rank_idArr.firstObject;
         _page ++;
        [[DataManager sharedDataManager] refreshCommunityHotDataWithRank_id:comGMrank_id.rank_id Page:_page];
        [self.myCollectionView reloadData];
        [self.myCollectionView.footer endRefreshing];
    }];

    self.myCollectionView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [[DataManager sharedDataManager] deleteHotData];
        [[DataManager sharedDataManager] loadCommunityHotData];
        [self.myCollectionView reloadData];
        [self.myCollectionView.header endRefreshing];
        
    }];
}
- (void) loadData
{
    [[DataManager sharedDataManager] loadCommunityHotData];
    NSLog(@"加载热门数据完成");
}
// 数量
- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [DataManager sharedDataManager].communityHotArray.count;
}
// 内容
- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ComHotCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellReuseIdentifier forIndexPath:indexPath];
    
    CommunityGM *communityGM = [DataManager sharedDataManager].communityHotArray[indexPath.item];
//    NSLog(@"加载cell");
    cell.communityGM = communityGM;
    
    return cell;
}
// 区头 轮播图
- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerReuseID forIndexPath:indexPath];
    
    NSArray *titles = @[@"Field General 2 “USA”配色即将登场",
                        @"Air Jordan 11 ’Legend Blue’ get app 周六原价发售",
                        @"Nike Air Mag 2015官方发布",
                        @"Penny 6 皇家蓝麂皮版官图发布",
                        @"不服！GQ杂志评选NBA最佳穿着TOP15"
                        ];
    
    NSArray *images = @[[UIImage imageNamed:@"slamDunk0.jpg"],[UIImage imageNamed:@"slamDunk1.jpg"],[UIImage imageNamed:@"slamDunk2.jpg"],[UIImage imageNamed:@"slamDunk3.jpg"],[UIImage imageNamed:@"slamDunk4.jpg"]];
    CGFloat w = self.view.frame.size.width;
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, w, 200) imagesGroup:images];
    cycleScrollView.infiniteLoop = YES;
    cycleScrollView.titlesGroup = titles;
    cycleScrollView.autoScrollTimeInterval = 2.0;
    cycleScrollView.dotColor = [UIColor clearColor];
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    
    [header addSubview:cycleScrollView];
    
    return header;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ComHotInfoViewController *comHotVC = [ComHotInfoViewController new];
    CommunityGM *communityGM = [DataManager sharedDataManager].communityHotArray[indexPath.item];
    comHotVC.communityGM = communityGM;
    [self presentViewController:comHotVC animated:YES completion:nil];
}
@end
