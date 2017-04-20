//
//  TextViewWithTag.h
//  TextKitTest
//
//  Created by 胡晓阳 on 2016/11/1.
//  Copyright © 2016年 胡晓阳. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextViewWithTag : UITextView


@property (nonatomic, copy) NSString *content;
@property (nonatomic, assign) NSUInteger location;
@property (nonatomic, assign) NSUInteger length;


- (instancetype)initWithFrame:(CGRect)frame content:(NSString *)content tagLocation:(NSUInteger)location tagLenght:(NSUInteger)length;
@end
