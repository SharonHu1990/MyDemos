/*!
 
 @header TestViewController.h
 
 @abstract TestViewController
 
 @author Created by SharonHu on 2017/4/18.
 
 @version 1.0 2017/4/18 Creation
 
   Copyright © 2017年 胡晓阳. All rights reserved.
 
 */

#import <UIKit/UIKit.h>




/**TestEnum 描述
 */
typedef enum : NSUInteger {
    TestEnum_V1,
    TestEnum_V2,
    TestEnum_V3,
} TestEnum;

/**
 TestVCDelegate:通过实现delegate方法实现某个功能
 */
@protocol TestVCDelegate <NSObject>


/**
 测试代理方法
 */
- (void)testDelegateMethod;

@end

/**
 ceshi
 */
@interface TestViewController : UIViewController



/**
 ceshi
 */
@property (nonatomic, copy) NSString *nameLabel;


/**
 测试枚举
 */
@property (nonatomic, assign) TestEnum *enumValue;


/**
 代理
 */
@property (nonatomic, weak) id<TestVCDelegate> delegate;

/**
 方法isTrue

 @param value1 入参1
 @param value2 入参1
 @return 返回值
 */
- (BOOL)isTrueWith:(CGFloat)value1 value2:(CGFloat)value2;
@end
