//
//  CoreAnimationEffect.m
//  CoreAnimationEffect
//
//  Created by 胡晓阳 on 2016/9/23.
//  Copyright © 2016年 胡晓阳. All rights reserved.
//

#import "CoreAnimationEffect.h"

@implementation CoreAnimationEffect

#pragma mark - Custom Animation

+ (void)showAnimationType:(NSString *)type withSubType:(NSString *)subType duration:(CFTimeInterval)duration timingFunction:(NSString *)timingFuction view:(UIView *)theView{
    
    
    /** CATransition
     *
     *  @see http://www.dreamingwish.com/dream-2012/the-concept-of-coreanimation-programming-guide.html
     *  @see http://geeklu.com/2012/09/animation-in-ios/
     *
     *  CATransition 常用设置及属性注解如下:
     */
    CATransition *animation = [CATransition animation];
    
    
    /** delegate
     *
     *  动画的代理,如果你想在动画开始和结束的时候做一些事,可以设置此属性,它会自动回调两个代理方法.
     *
     *  @see CAAnimationDelegate    (按下command键点击)
     */
    animation.delegate = self;
    
    
    /** duration
     *
     *  动画持续时间
     */
    animation.duration = duration;

/*    CAMediaTimingFunction:
 *
 *    用于变化起点和终点之间的插值计算,形象点说它决定了动画运行的节奏,比如是均匀变化(相同时间变化量相同)还是先快后慢,先慢后快还是先慢再快再慢.
 *
 *    kCAMediaTimingFunctionDefault 默认效果，实际效果是中间较快
 *    kCAMediaTimingFunctionLinear  线性效果，匀速
 *    kCAMediaTimingFunctionEaseIn  先慢后快
 *    kCAMediaTimingFunctionEaseOut 先快后慢
 *    kCAMediaTimingFunctionEaseInEaseOut  先慢后快再慢
 *
 *    当上面的预置不能满足你的需求的时候,你可以使用下面的两个方法来自定义你的timingFunction
 *  具体参见下面的URL
 *
 *  @see http://developer.apple.com/library/ios/#documentation/Cocoa/Reference/CAMediaTimingFunction_class/Introduction/Introduction.html
 *
 *  + (id)functionWithControlPoints:(float)c1x :(float)c1y :(float)c2x :(float)c2y;
 *
 *  - (id)initWithControlPoints:(float)c1x :(float)c1y :(float)c2x :(float)c2y;
 */
    
    animation.timingFunction = [CAMediaTimingFunction functionWithName:timingFuction];
    
    
    
    /** fillMode
     *
     *  决定当前对象过了非active时间段的行为,比如动画开始之前,动画结束之后.
     *  预置为:
     *  kCAFillModeRemoved   默认,当动画开始前和动画结束后,动画对layer都没有影响,动画结束后,layer会恢复到之前的状态
     *  kCAFillModeForwards  当动画结束后,layer会一直保持着动画最后的状态
     *  kCAFillModeBackwards 和kCAFillModeForwards相对,具体参考上面的URL
     *  kCAFillModeBoth      kCAFillModeForwards和kCAFillModeBackwards在一起的效果
     */
    animation.fillMode = kCAFillModeForwards;
    
    
    
    
    /** removedOnCompletion
     *
     *  这个属性默认为YES.一般情况下,不需要设置这个属性.
     *
     *  但如果是CAAnimation动画,并且需要设置 fillMode 属性,那么需要将 removedOnCompletion 设置为NO,否则
     *  fillMode无效
     */
    
    //    animation.removedOnCompletion = NO;
    
    
    /** type
     *
     *  各种动画效果  其中除了'fade', `moveIn', `push' , `reveal' ,其他属于私有的API(我是这么认为的,可以点进去看下注释).
     *  ↑↑↑上面四个可以分别使用'kCATransitionFade', 'kCATransitionMoveIn', 'kCATransitionPush', 'kCATransitionReveal'来调用.
     *  @"cube"                     立方体翻滚效果
     *  @"moveIn"                   新视图移到旧视图上面
     *  @"reveal"                   显露效果(将旧视图移开,显示下面的新视图)
     *  @"fade"                     交叉淡化过渡(不支持过渡方向)             (默认为此效果)
     *  @"pageCurl"                 向上翻一页
     *  @"pageUnCurl"               向下翻一页
     *  @"suckEffect"               收缩效果，类似系统最小化窗口时的神奇效果(不支持过渡方向)
     *  @"rippleEffect"             滴水效果,(不支持过渡方向)
     *  @"oglFlip"                  上下左右翻转效果
     *  @"rotate"                   旋转效果
     *  @"push"
     *  @"cameraIrisHollowOpen"     相机镜头打开效果(不支持过渡方向)
     *  @"cameraIrisHollowClose"    相机镜头关上效果(不支持过渡方向)
     */
    
    /** type
     *
     *  kCATransitionFade            交叉淡化过渡
     *  kCATransitionMoveIn          新视图移到旧视图上面
     *  kCATransitionPush            新视图把旧视图推出去
     *  kCATransitionReveal          将旧视图移开,显示下面的新视图
     */
    animation.type = type;
    
    
    /** subtype
     *
     *  各种动画方向
     *
     *  kCATransitionFromRight;      同字面意思(下同)
     *  kCATransitionFromLeft;
     *  kCATransitionFromTop;
     *  kCATransitionFromBottom;
     */
    
    /** subtype
     *
     *  当type为@"rotate"(旋转)的时候,它也有几个对应的subtype,分别为:
     *  90cw    逆时针旋转90°
     *  90ccw   顺时针旋转90°
     *  180cw   逆时针旋转180°
     *  180ccw  顺时针旋转180°
     */
    
    /**
     *  type与subtype的对应关系(必看),如果对应错误,动画不会显现.
     *
     *  @see http://iphonedevwiki.net/index.php/CATransition
     */
    animation.subtype = subType;
    
    
    
    /**
     *  所有核心动画和特效都是基于CAAnimation,而CAAnimation是作用于CALayer的.所以把动画添加到layer上.
     *  forKey  可以是任意字符串.
     */
    [theView.layer addAnimation:animation forKey:nil];
}


#pragma mark - Preset Animation
+ (void)animationRevealFromBottom:(UIView *)view{
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.3];
    [animation setType:kCATransitionReveal];
    [animation setSubtype:kCATransitionFromBottom];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [view.layer addAnimation:animation forKey:nil];
}

+ (void)animationRevealFromTop:(UIView *)view{
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.3];
    [animation setType:kCATransitionReveal];
    [animation setSubtype:kCATransitionFromTop];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [view.layer addAnimation:animation forKey:nil];
}

+ (void)animationRevealFromLeft:(UIView *)view{
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.3];
    [animation setType:kCATransitionReveal];
    [animation setSubtype:kCATransitionFromLeft];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [view.layer addAnimation:animation forKey:nil];
}

+ (void)animationRevealFromRight:(UIView *)view{
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.3];
    [animation setType:kCATransitionReveal];
    [animation setSubtype:kCATransitionFromRight];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [view.layer addAnimation:animation forKey:nil];
}


+ (void)animationEaseIn:(UIView *)view{
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.3];
    [animation setType:kCATransitionFade];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [view.layer addAnimation:animation forKey:nil];
}


+ (void)animationEaseOut:(UIView *)view{
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.3];
    [animation setType:kCATransitionFade];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [view.layer addAnimation:animation forKey:nil];
}

/**
 *  UIViewAnimation
 *
 *  @see    http://www.cocoachina.com/bbs/read.php?tid=110168
 *
 *  @brief  UIView动画应该是最简单便捷创建动画的方式了,详解请猛戳URL.
 *
 *  @method beginAnimations:context 第一个参数用来作为动画的标识,第二个参数给代理代理传递消息.至于为什么一个使用
 *                                  nil而另外一个使用NULL,是因为第一个参数是一个对象指针,而第二个参数是基本数据类型.
 *  @method setAnimationCurve:      设置动画的加速或减速的方式(速度)
 *  @method setAnimationDuration:   动画持续时间
 *  @method setAnimationTransition:forView:cache:   第一个参数定义动画类型，第二个参数是当前视图对象，第三个参数是是否使用缓冲区
 *  @method commitAnimations        动画结束
 */
+ (void)animationFlipFromLeft:(UIView *)view{
    [UIView beginAnimations:nil context:nil];
    [UIView commitAnimations];
}

@end
