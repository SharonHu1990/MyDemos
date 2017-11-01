//
//  ViewController.m
//  GridCollectionDemo
//
//  Created by SharonHu on 2017/7/14.
//  Copyright © 2017年 胡晓阳. All rights reserved.
//

#import "ViewController.h"
#import "GridCollectionViewLayot.h"
#import "GridItemView.h"

@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, GridCollectionViewLayotDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UIColor *headerColor;
@property (nonatomic, strong) UIColor *footerColor;
@property (nonatomic, assign) CGFloat headerHeight;
@property (nonatomic, assign) CGFloat footerHeight;
@property (nonatomic, assign) UIEdgeInsets sectionInset;

@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    GridCollectionViewLayot *layout = [[GridCollectionViewLayot alloc] init];
    layout.sectionInset = self.sectionInset;
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.delegate = self;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 200) collectionViewLayout:layout];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CellID"];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderReuseID"];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterReuseID"];
    
    self.headerColor = [UIColor blueColor];
    self.footerColor = [UIColor blueColor];
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellID" forIndexPath:indexPath];
    switch (indexPath.item) {
        case 0:{
            [cell.contentView setBackgroundColor:[UIColor redColor]];
        }
        case 1:{
            [cell.contentView setBackgroundColor:[UIColor yellowColor]];
        }
            break;
        case 2:{
            [cell.contentView setBackgroundColor:[UIColor blueColor]];
        }
            break;
        case 3:{
            [cell.contentView setBackgroundColor:[UIColor greenColor]];
        }
            break;
        case 4:
        {
            [cell.contentView setBackgroundColor:[UIColor orangeColor]];
        }
            break;
            
        default:
            break;
    }

    return cell;

}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusableView= nil;
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderReuseID" forIndexPath:indexPath];
        [headerView setBackgroundColor:self.headerColor];
        reusableView = headerView;
    }
    
    if (kind == UICollectionElementKindSectionFooter) {
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FooterReuseID" forIndexPath:indexPath];
        [footerView setBackgroundColor:self.footerColor];
    }
    return reusableView;
}


#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(CGRectGetWidth(collectionView.bounds), 10);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(CGRectGetWidth(collectionView.bounds), 10);
}

#pragma mark - GridCollectionViewLayotDelegate

- (CGRect)itemFrameAtIndexpath:(NSIndexPath *)indexpath{
    CGRect frame = CGRectZero;
    switch (indexpath.item) {
        case 0:
//            frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds)/2.f, CGRectGetHeight(_collectionView.bounds)/2.f);
            frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(_collectionView.bounds)/2.f-self.sectionInset.bottom);
            break;
        case 1:
//            frame = CGRectMake(CGRectGetWidth(self.view.bounds)/2.f, 0, CGRectGetWidth(self.view.bounds)/2.f, CGRectGetHeight(_collectionView.bounds)/2.f);
            frame = CGRectMake(0, CGRectGetHeight(_collectionView.bounds)/2.f, CGRectGetWidth(self.view.bounds)/2.f, CGRectGetHeight(_collectionView.bounds)/2.f);
            break;
        case 2:
//            frame = CGRectMake(0, CGRectGetHeight(_collectionView.bounds)/2.f, CGRectGetWidth(self.view.bounds), CGRectGetHeight(_collectionView.bounds)/2.f-self.sectionInset.bottom);
            frame = CGRectMake(CGRectGetWidth(self.view.bounds)/2.f, CGRectGetHeight(_collectionView.bounds)/2.f, CGRectGetWidth(self.view.bounds)/2.f, CGRectGetHeight(_collectionView.bounds)/2.f);
            break;
        default:
            break;
    }
    return frame;
    
}

@end
