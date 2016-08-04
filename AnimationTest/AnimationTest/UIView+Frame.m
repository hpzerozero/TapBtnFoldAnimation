//
//  UIView+Frame.m
//  weibo
//
//  Created by hp on 16/4/25.
//  Copyright © 2016年 hp. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)
- (void)setX_:(CGFloat)x_
{
    CGRect frame = self.frame;
    frame.origin.x = x_;
    self.frame = frame;
}

- (void)setY_:(CGFloat)y_
{
    CGRect frame = self.frame;
    frame.origin.y = y_;
    self.frame = frame;
}

- (void)setWidth_:(CGFloat)width_
{
    CGRect frame = self.frame;
    frame.size.width = width_;
    self.frame = frame;
}

- (void)setHeight_:(CGFloat)height_
{
    CGRect frame = self.frame;
    frame.size.height = height_;
    self.frame = frame;
}

- (void)setCx:(CGFloat)cx
{
    CGPoint center = self.center;
     center.x = cx;
    self.center = center;
}

- (void)setCy:(CGFloat)cy
{
    CGPoint center = self.center;
    center.y = cy;
    self.center = center;
}

- (CGFloat)x_
{
    CGRect frame = self.frame;
    return frame.origin.x;
}

- (CGFloat)y_
{
    CGRect frame = self.frame;
    return frame.origin.y;
}
- (CGFloat)width_
{
    CGRect frame = self.frame;
    return frame.size.width;
}
- (CGFloat)height_
{
    CGRect frame = self.frame;
    return frame.size.height;
}

- (CGFloat)cx
{
    CGPoint center = self.center;
    return center.x;
}

- (CGFloat)cy
{
    CGPoint center = self.center;
    return center.y;
}
@end
