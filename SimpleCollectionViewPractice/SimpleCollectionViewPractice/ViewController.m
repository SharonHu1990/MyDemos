//
//  ViewController.m
//  SimpleCollectionViewPractice
//
//  Created by 胡晓阳 on 16/3/22.
//  Copyright © 2016年 胡晓阳. All rights reserved.
//

#import "ViewController.h"
#import "CustomCollectionViewCell.h"
#import "DetailViewController.h"
#import "CustomCollectionReusableHeaderView.h"
#define KCollectionViewCellID @"CustomCollectionViewCellIdentifier"
#define KCollectionHeaderViewID @"CustomCollectionHeaderViewIdentifier"

@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
    UICollectionView *myCollectionView;
    
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"Simple CollectionView";
    [self initiateMyCollectionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initiateMyCollectionView{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 4.f;
    myCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    [myCollectionView setBackgroundColor:[UIColor whiteColor]];
    myCollectionView.delegate = self;
    myCollectionView.dataSource = self;
    [myCollectionView registerNib:[UINib nibWithNibName:@"CustomCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:KCollectionViewCellID];
    [myCollectionView registerNib:[UINib nibWithNibName:@"CustomCollectionReusableHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:KCollectionHeaderViewID];
    [self.view addSubview:myCollectionView];
}

#pragma mark - UICollectionViewDelegate & UICollectionViewDatasource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 32;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KCollectionViewCellID forIndexPath:indexPath];
    NSString *imageToLoad = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    NSString *description = [NSString stringWithFormat:@"{%ld,%ld}",(long)indexPath.row,(long)indexPath.section];
    [cell fillContentWithImage:imageToLoad description:description indexPath:indexPath];
    return cell;
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CustomCollectionViewCell *myCell = (CustomCollectionViewCell *)[myCollectionView cellForItemAtIndexPath:indexPath];
    if (myCell == nil) {
        
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"CustomCollectionViewCell" owner:self options:nil];
        myCell = [topLevelObjects objectAtIndex:0];
        myCell.frame = CGRectMake(0, 0, (CGRectGetWidth(self.view.frame)-4.f)/2.0, 20);
        
        
        
        // SET YOUR CONTENT
        [myCell layoutIfNeeded];
    }
    

    CGSize cellSize = [myCell systemLayoutSizeFittingSize:UILayoutFittingCompressedSize withHorizontalFittingPriority:UILayoutPriorityDefaultHigh verticalFittingPriority:UILayoutPriorityDefaultLow];
    return cellSize;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusableView = nil;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        CustomCollectionReusableHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:KCollectionHeaderViewID forIndexPath:indexPath];
        reusableView = headerView;
    }
    return reusableView;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds), 40.f);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController *detailVC = [[[NSBundle mainBundle] loadNibNamed:@"DetailViewController" owner:self options:nil] lastObject];
    detailVC.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
    [self.navigationController pushViewController:detailVC animated:YES];
}
@end
