//
//  GridCollectionViewLayot.m
//  GridCollectionDemo
//
//  Created by SharonHu on 2017/7/14.
//  Copyright © 2017年 胡晓阳. All rights reserved.
//

#import "GridCollectionViewLayot.h"

@interface GridCollectionViewLayot ()
//总列数
@property (nonatomic, assign) NSInteger columnCount;
//列间距
@property (nonatomic, assign) NSInteger columnSpacing;
//行间距
@property (nonatomic, assign) NSInteger rowSpacing;

@property (nonatomic, strong) NSMutableDictionary *maxYDic;
@property (nonatomic, strong) NSMutableArray *attributesArray;
@end
@implementation GridCollectionViewLayot
- (void)prepareLayout{
    [super prepareLayout];
    
    self.attributesArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < self.columnCount; i ++) {
        self.maxYDic[@(i)] = @(self.sectionInset.top);
    }
    
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    
    for (int i = 0; i < itemCount;  i++) {
        NSIndexPath *indexpath = [NSIndexPath indexPathForRow:i inSection:0];
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexpath];
        
        attributes.frame = [self.delegate itemFrameAtIndexpath:indexpath];
        
        [self.attributesArray addObject:attributes];
    }
    
}

- (CGSize)collectionViewContentSize{
    __block NSNumber *maxIndex = @0;
    [self.maxYDic enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, NSNumber *obj, BOOL * _Nonnull stop) {
        if ([self.maxYDic[maxIndex] floatValue] < obj.floatValue) {
            maxIndex = key;
        }
    }];
    
    return CGSizeMake(0, [self.maxYDic[maxIndex] floatValue] + self.sectionInset.top + self.sectionInset.bottom);
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.attributesArray;
}

@end
