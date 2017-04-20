//
//  CoreAnimationEffect.h
//  CoreAnimationEffect
//
//  Created by 胡晓阳 on 2016/9/23.
//  Copyright © 2016年 胡晓阳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface CoreAnimationEffect : NSObject

#pragma mark - Custom Animation


/**
 快速构建一个自定义动画（构建系统预置type需要在调用类中引入<QuartzCore/QuartzCore.h>）
 
 @param type          动画过渡类型
 @param subType       动画过渡方向（子类型）
 @param duration      动画持续时间
 @param timingFuction 动画定时函数属性
 @param theView       需要添加动画的view
 */
+ (void)showAnimationType:(NSString *)type
              withSubType:(NSString *)subType
                 duration:(CFTimeInterval)duration
           timingFunction:(NSString *)timingFuction
                     view:(UIView *)theView;


#pragma mark - Preset Animation

// Reveal（出现）
+ (void)animationRevealFromBottom:(UIView *)view;
+ (void)animationRevealFromTop:(UIView *)view;
+ (void)animationRevealFromLeft:(UIView *)view;
+ (void)animationRevealFromRight:(UIView *)view;

// 渐隐渐现
+ (void)animationEaseIn:(UIView *)view;
+ (void)animationEaseOut:(UIView *)view;

// 翻转
+ (void)animationFlipFromLeft:(UIView *)view;
+ (void)animationFlipFromRight:(UIView *)view;
+ (void)animationFlipFromTop:(UIView *)view;
+ (void)animationFlipFromDown:(UIView *)view;


// 立方体旋转
+ (void)animationCubeFromLeft:(UIView *)view;
+ (void)animationCubeFromRight:(UIView *)view;
+ (void)animationCubeFromTop:(UIView *)view;
+ (void)animationCubeFromBottom:(UIView *)view;


// 翻页
+ (void)animationCurlUp:(UIView *)view;
+ (void)animationCurlDown:(UIView *)view;

// Push
+ (void)animationPushUp:(UIView *)view;
+ (void)animationPushDown:(UIView *)view;
+ (void)animationPushLeft:(UIView *)view;
+ (void)animationPushRight:(UIView *)view;

// Move
+ (void)animationMoveUp:(UIView *)view duration:(CFTimeInterval)duration;
+ (void)animationMoveDown:(UIView *)view duration:(CFTimeInterval)duration;
+ (void)animationMoveLeft:(UIView *)view duration:(CFTimeInterval)duration;
+ (void)animationMoveRight:(UIView *)view duration:(CFTimeInterval)duration;

// 旋转缩放
+ (void)animationRotateAndScaleEffects:(UIView *)view;

// 吮吸效果
+ (void)animationSuckEffect:(UIView *)view;

// 波纹效果
+ (void)animationRippleEffect:(UIView *)view; 


//相机
+ (void)animationCameraOpen:(UIView *)view;
+ (void)animationCameraClose:(UIView *)view;

@end
