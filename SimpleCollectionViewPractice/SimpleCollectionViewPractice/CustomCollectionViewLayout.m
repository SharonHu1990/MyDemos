//
//  CustomCollectionViewLayout.m
//  SimpleCollectionViewPractice
//
//  Created by 胡晓阳 on 16/3/23.
//  Copyright © 2016年 胡晓阳. All rights reserved.
//

#import "CustomCollectionViewLayout.h"

@implementation CustomCollectionViewLayout

-(CGSize)collectionViewContentSize{
    return CGSizeMake(([UIScreen mainScreen].bounds.size.width-4.f)/2.f, 100.f);
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return nil;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    return attributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}
@end
