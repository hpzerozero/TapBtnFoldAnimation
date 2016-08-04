//
//  TapBtnView.m
//  AnimationTest
//
//  Created by hp on 16/6/30.
//  Copyright © 2016年 FrSky. All rights reserved.
//

#import "TapBtnView.h"
#define DEFAULT_RADIUS 30

@interface TapBtnView ()
@property (nonatomic, weak) UIButton *btn;
@property (strong, nonatomic) id target;
@property (assign, nonatomic) SEL selector;
@end

@implementation TapBtnView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];

        self.bounds = CGRectMake(0, 0, DEFAULT_RADIUS*2, DEFAULT_RADIUS*2);
    }
    return self;
}

- (instancetype)initWithRadius:(CGFloat)radius
                        center:(CGPoint)center
{
    if (self=[super init]) {
        _radius = radius;
        self.center = center;
        self.backgroundColor = [UIColor clearColor];
        self.bounds = CGRectMake(0, 0, _radius*2, _radius*2);
        
    }
    return self;
}

- (void)addTarget:(id)target
           action:(SEL)action
{
    UIButton *btn = [[UIButton alloc] initWithFrame:self.bounds];
    [self addSubview:btn];
    self.btn = btn;
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn addTarget:self action:@selector(performSelector) forControlEvents:UIControlEventTouchUpInside];
    _target = target;
    _selector = action;
}

- (void)performSelector
{
    if ([_target respondsToSelector:_selector]) {

        [_target performSelector:_selector withObject:self afterDelay:0.3];
        
    }
    [self showAnimation];
}

- (void)setBtnCount:(uint)btnCount
{
    _btnCount = btnCount;
    CGFloat angle = M_PI*2/(float)_btnCount;
    NSMutableArray *mArr = [NSMutableArray array];
    CGFloat cx = self.center.x;
    CGFloat cy = self.center.y;
    CGFloat dx;
    CGFloat dy;
    if (!self.distance) {
        self.distance = self.radius * sinf(angle/2);
        CGPoint point = CGPointMake(cx, cy-self.distance);
        NSValue *value = [NSValue valueWithCGPoint:point];
        [mArr addObject:value];
        dx = sinf(angle) * self.distance;
        dy = cosf(angle) *self.distance;
    }
}

- (void)setDistance:(CGFloat)distance
{
    _distance = distance;
}
- (void)setTap:(BOOL)tap
{
    _tap = tap;
//    [self showAnimation];
    
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    [self setNeedsDisplay];
}

- (void)setTitleFont:(NSString *)titleFont
{
    _titleFont = titleFont;
    [self setNeedsDisplay];
}

- (void)setTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor;
    [self setNeedsDisplay];
}

- (void)setRadius:(CGFloat)radius
{
    _radius = radius;
    self.bounds = CGRectMake(0, 0, _radius*2, _radius*2);
    [self setNeedsDisplay];
}

- (void)setTapBtnColor:(UIColor *)tapBtnColor
{
    _tapBtnColor = tapBtnColor;
    [self setNeedsDisplay];
}

- (void)setTitleSize:(CGFloat)titleSize
{
    _titleSize = titleSize;
    [self setNeedsDisplay];
}


- (void)addAnimationFromPoint:(CGPoint)fromPoint
                      toPoint:(CGPoint)toPoint
{
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:fromPoint];
    [bezierPath addLineToPoint:toPoint];

    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    [anim setPath:bezierPath.CGPath];// 设定路径
    anim.duration = 2;
    anim.fillMode = kCAFillModeForwards;
    anim.removedOnCompletion = NO;
    [self.layer addAnimation:anim forKey:nil];
//    return planePath;
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    NSString *title      = self.title ? self.title : @"title" ;
    CGFloat titleSize    = self.titleSize ? self.titleSize : 16;
    UIColor *tapBtnColor = self.tapBtnColor ? self.tapBtnColor : [UIColor greenColor];
    UIColor *titleColor  = self.titleColor ? self.titleColor : [UIColor blackColor];
    NSString *titleFont  = self.titleFont ? self.titleFont : @".AppleSystemUIFontBold";
    //// General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();
    //// Rectangle Drawing
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: rect];
    [tapBtnColor setFill];
    [ovalPath fill];
    
    // text Drawing
    NSString* textContent = title;
    NSMutableParagraphStyle* ovalStyle = NSMutableParagraphStyle.defaultParagraphStyle.mutableCopy;
    ovalStyle.alignment = NSTextAlignmentCenter;
    
    NSDictionary* ovalFontAttributes = @{NSFontAttributeName: [UIFont fontWithName: titleFont size: titleSize], NSForegroundColorAttributeName: titleColor, NSParagraphStyleAttributeName: ovalStyle};
    
    CGFloat ovalTextHeight = [textContent boundingRectWithSize: CGSizeMake(rect.size.width, INFINITY)  options: NSStringDrawingUsesLineFragmentOrigin attributes: ovalFontAttributes context: nil].size.height;
    CGContextSaveGState(context);
    CGContextClipToRect(context, rect);
    [textContent drawInRect: CGRectMake(CGRectGetMinX(rect), CGRectGetMinY(rect) + (CGRectGetHeight(rect) - ovalTextHeight) / 2, CGRectGetWidth(rect), ovalTextHeight) withAttributes: ovalFontAttributes];
    CGContextRestoreGState(context);
}

#pragma mark - 
- (void)showAnimation
{
    CABasicAnimation *anim1 = [CABasicAnimation animationWithKeyPath:@"opacity"];
    anim1.duration = 0.2f;
    anim1.fromValue = @1;
    anim1.toValue = @0.2;
    anim1.repeatCount = 1;
    anim1.fillMode = kCAFillModeBackwards;
    anim1.removedOnCompletion = NO;
    [self.layer addAnimation:anim1 forKey:@"animate1"];
    
    CABasicAnimation *anim2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    anim2.duration = 0.3f; // 动画过程的时间
    anim2.fromValue = @1.2; // 起始值
    anim2.toValue = @1.0;   // 终止值
    anim2.repeatCount = 1; // 次数
    anim2.fillMode = kCAFillModeBackwards;
    anim2.removedOnCompletion = NO;
    [self.layer addAnimation:anim2 forKey:@"animate2"];
}
/** 动画是否在运行*/
static BOOL animating = NO;
+ (void)animateWithDuration:(NSTimeInterval)duration
                      delay:(NSTimeInterval)delay
                    options:(UIViewAnimationOptions)options
          animationPrevious:(void(^)())animaionBlock
                 animations:(void(^)())animations
                 completion:(void(^)(BOOL finished))completed
{
    if (animating) {
        return;
    }
    animating = YES;
    
    if(animaionBlock) {
        
        animaionBlock();
    }
    [UIView animateWithDuration:duration delay:delay options:options animations:animations completion:^(BOOL finished) {
        animating = NO;
        completed(finished);
    }];
}
+ (void)animateWithDuration:(NSTimeInterval)duration
                      delay:(NSTimeInterval)delay
     usingSpringWithDamping:(CGFloat)Damping
      initialSpringVelocity:(CGFloat)velccity
                    options:(UIViewAnimationOptions)options
          animationPrevious:(void(^)())animaionBlock
                 animations:(void(^)())animations
                 completion:(void(^)(BOOL finished))completed
{
    if (animating) {
        return;
    }
    animating = YES;
    
    if(animaionBlock) {
        
        animaionBlock();
    }
    [UIView animateWithDuration:duration delay:delay usingSpringWithDamping:Damping initialSpringVelocity:velccity options:options animations:animations completion:^(BOOL finished) {
        animating = NO;
        completed(finished);
    }];
}


@end
