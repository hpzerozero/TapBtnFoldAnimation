//
//  TapBtnView.h
//  AnimationTest
//
//  Created by hp on 16/6/30.
//  Copyright © 2016年 FrSky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TapBtnView : UIView
/** 只需要设定半径值，尺寸不需要设置，位置设置圆心*/
@property (assign, nonatomic) CGFloat radius;
/** 按钮标题*/
@property (copy,   nonatomic) NSString *title;
/** 标题尺寸*/
@property (assign, nonatomic) CGFloat titleSize;
/** 按钮的颜色*/
@property (strong, nonatomic) UIColor *tapBtnColor;
/** 按钮上文字的颜色*/
@property (strong, nonatomic) UIColor *titleColor;
/** 按钮上文字的字体*/
@property (copy,   nonatomic) NSString *titleFont;
/** 弹出的按钮数量*/
@property (assign, nonatomic) uint btnCount;
/** 按钮与中心按钮的间距*/
@property (assign, nonatomic) CGFloat distance;
/** 按钮的中心点位置数组*/
@property (strong, nonatomic) NSArray *points;
/** 是否点击*/
@property (assign, nonatomic,getter=isTap) BOOL tap;
/**
 *  初始化方法，如果使用
 *
 *  @param radius 按钮的半径
 *  @param center 按钮的圆心位置
 *
 *  @return
 */
- (instancetype)initWithRadius:(CGFloat)radius
                        center:(CGPoint)center;
- (void)addTarget:(id)target
           action:(SEL)action;

- (void)addAnimationFromPoint:(CGPoint)fromPoint
                      toPoint:(CGPoint)toPoint;

+ (void)animateWithDuration:(NSTimeInterval)duration
                      delay:(NSTimeInterval)delay
                    options:(UIViewAnimationOptions)options
          animationPrevious:(void(^)())animaionBlock
                 animations:(void(^)())animations
                 completion:(void(^)(BOOL finished))completed;


+ (void)animateWithDuration:(NSTimeInterval)duration
                      delay:(NSTimeInterval)delay
     usingSpringWithDamping:(CGFloat)Damping
      initialSpringVelocity:(CGFloat)velccity
                    options:(UIViewAnimationOptions)options
          animationPrevious:(void(^)())animaionBlock
                 animations:(void(^)())animations
                 completion:(void(^)(BOOL finished))completed;
@end
