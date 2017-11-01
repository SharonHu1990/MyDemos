//
//  GridCollectionViewLayot.h
//  GridCollectionDemo
//
//  Created by SharonHu on 2017/7/14.
//  Copyright © 2017年 胡晓阳. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  GridCollectionViewLayotDelegate<NSObject>

- (CGRect)itemFrameAtIndexpath:(NSIndexPath *)indexpath;

@end

@interface GridCollectionViewLayot : UICollectionViewFlowLayout

@property (nonatomic, weak) id<GridCollectionViewLayotDelegate> delegate;

@end
