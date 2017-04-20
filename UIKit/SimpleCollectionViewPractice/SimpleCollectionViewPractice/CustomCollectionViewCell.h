//
//  CustomCollectionViewCell.h
//  SimpleCollectionViewPractice
//
//  Created by 胡晓阳 on 16/3/23.
//  Copyright © 2016年 胡晓阳. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCollectionViewCell : UICollectionViewCell

- (void)fillContentWithImage:(NSString *)imageToLoad description:(NSString *)description indexPath:(NSIndexPath *)indexPath;
@end
